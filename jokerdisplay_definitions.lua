local jd_def = JokerDisplay.Definitions

jd_def["j_evo_astronaut"] = { --Astronaut
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values",                    ref_value = "odds" },
            { text = " in " },
            { ref_table = "card.ability",                    ref_value = "extra" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        card.joker_display_values.odds = G.GAME and G.GAME.probabilities.normal or 1
    end
}
jd_def["j_evo_rendezvous"] = { -- Rendez-Vous
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count" },
    },
    text_config = { colour = G.C.SECONDARY_SET.Spectral },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    calc_function = function(card)
        local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        local is_seance_hand = text == card.ability.extra.poker_hand

        card.joker_display_values.count = is_seance_hand and 1 or 0
        card.joker_display_values.localized_text = localize(card.ability.extra.poker_hand, 'poker_hands')
    end
}
jd_def["j_evo_bordel"] = { -- Bordel The Clown
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability", ref_value = "extra", colour = G.C.GREEN },
        { text = ")" },
    },
    reminder_text_config = {scale = 0.35}
}
jd_def["j_evo_monolith"] = { -- Monolith
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult" }
            }
        }
    },
    calc_function = function(card)
        local hand = G.hand.highlighted
        local text, _, _ = JokerDisplay.evaluate_hand(hand)
        local play_more_than = 0
        for k, v in pairs(G.GAME.hands) do
            if v.played and v.played >= play_more_than and v.visible then
                play_more_than = v.played
            end
        end
        local hand_exists = text ~= 'Unknown' and G.GAME and G.GAME.hands and G.GAME.hands[text]
        card.joker_display_values.x_mult = (hand_exists and (G.GAME.hands[text].played >= play_more_than and math.max(1, card.ability.x_mult - 1) or card.ability.x_mult + card.ability.extra) or card.ability.x_mult)
    end
}
jd_def["j_evo_superstar"] = { -- Superstar
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "active_text" },
    },
    calc_function = function(card)
        local disableable = G.GAME and G.GAME.blind and G.GAME.blind.get_type and
            ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss'))
        card.joker_display_values.active = disableable
        card.joker_display_values.active_text = localize(disableable and 'k_active' or 'ph_no_boss_active')
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[1] then
            reminder_text.children[1].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.RED
            reminder_text.children[1].config.scale = card.joker_display_values.active and 0.35 or 0.3
            return true
        end
        return false
    end
}
jd_def["j_evo_tarotologist"] = { -- Tarotologist

}
jd_def["j_evo_vip_card"] = { -- VIP Card
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "loyalty_text" },
        { text = ")" },
    },
    calc_function = function(card)
        local loyalty_remaining = card.ability.loyalty_remaining + (next(G.play.cards) and 1 or 0)
        card.joker_display_values.loyalty_text = localize { type = 'variable', key = (loyalty_remaining % (card.ability.extra.every+1) == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { loyalty_remaining } }
        card.joker_display_values.x_mult = (loyalty_remaining % (card.ability.extra.every+1) == 0 and card.ability.extra.Xmult or 1)
    end
}
jd_def["j_evo_clenched_fist"] = { -- Clenched Fist
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local temp_Mult, temp_ID = 0, 0
        local temp_card = nil
        local retriggers = 1
        for i = 1, #G.hand.cards do
            if not G.hand.cards[i].highlighted and temp_ID <= G.hand.cards[i].base.id
                and G.hand.cards[i].ability.effect ~= 'Stone Card' then
                retriggers = JokerDisplay.calculate_card_triggers(G.hand.cards[i], nil, true)
                temp_Mult = G.hand.cards[i].base.nominal
                temp_ID = G.hand.cards[i].base.id
                temp_card = G.hand.cards[i]
            end
        end
        if not temp_card or temp_card.debuff or temp_card.facing == 'back' then
            temp_Mult = 0
        end
        card.joker_display_values.mult = temp_Mult * 2 * retriggers
    end
}
jd_def["j_evo_ninefold_joy"] = { -- Ninefold Joy
    text = {
        { text = "+$" },
        { ref_table = "card.ability", ref_value = "extra" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
jd_def["j_evo_full_sugar_cola"] = { -- Full-Sugar Cola

}
jd_def["j_evo_wildfire"] = { -- Wildfire
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability", ref_value = "x_mult" }
            }
        }
    }
}
jd_def["j_evo_aerialist"] = { -- Aerialist
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult" }
            }
        }
    },
    calc_function = function(card)
        card.joker_display_values.x_mult = G.GAME and G.GAME.current_round.hands_played == 0 and card.ability.extra or 1
    end
}
jd_def["j_evo_pilots_license"] = { -- Pilot's License
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            }
        }
    }
}
jd_def["j_evo_short_term_satisfaction"] = { -- Short-Term Satisfaction
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    },
    calc_function = function(card)
        card.joker_display_values.dollars = (G.GAME and G.GAME.current_round.discards_left > 0 and G.GAME.current_round.discards_left * card.ability.extra or 0)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}
jd_def["j_evo_ripple"] = { -- Ripple
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        card.joker_display_values.mult = (#JokerDisplay.current_hand - #scoring_hand) * card.ability.extra
    end
}
jd_def["j_evo_collector"] = { -- Collector
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability", ref_value = "extra" }
            }
        }
    }
}