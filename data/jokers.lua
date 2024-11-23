SMODS.Atlas{
    key = "je_jokers",
    path = "je_jokers.png",
    px = 71,
    py = 95
}

-- Evolved Jokers

-- Astronaut Joker (Space Joker evolution)

SMODS.Joker{
	key = "astronaut",
	name = "Astronaut Joker",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 1, y = 0},
	cost = 10,
	config = {extra = 4},
	loc_vars = function(self, info_queue, card)
		return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
            if pseudorandom('astronaut') < G.GAME.probabilities.normal/card.ability.extra then
                local _hand, _tally = "High Card", 0
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _tally = G.GAME.hands[v].played
                    end
                end
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex')})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
                level_up_hand(context.blueprint_card or card, _hand, nil, 1)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.je_level_up then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers"
}

JokerEvolution.evolutions:add_evolution("j_space", "j_evo_astronaut", 6)

-- Rendez-vous (Séance evolution)

SMODS.Joker{
	key = "rendezvous",
	name = "Rendez-Vous",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 2, y = 0},
	cost = 12,
	config = {extra = {poker_hand = 'Straight'}},
	loc_vars = function(self, info_queue, card)
		return {vars = {localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if next(context.poker_hands[card.ability.extra.poker_hand]) then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
							local _card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'rdv')
							_card:add_to_deck()
							G.consumeables:emplace(_card)
							G.GAME.consumeable_buffer = 0
						return true
					end)}))
				return {
					message = localize('k_plus_spectral'),
					colour = G.C.SECONDARY_SET.Spectral,
					card = card
				}
			end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_seance", "j_evo_rendezvous", 2)

-- Bordel the Buffon (Chaos the Clown evolution)

SMODS.Joker{
	key = "bordel",
	name = "Bordel the Buffon",
	rarity = "evo",
	pos = {x = 3, y = 0},
	cost = 8,
	config = {extra = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	calculate = function(self, card, context)
		if context.ending_shop and card.ability.extra < 3 then
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = {"Refresh!"}, colour = G.C.GREEN})
			card.ability.extra = 3
		end
		if context.je_prereroll_shop then
			if not (G.GAME.current_round.reroll_cost <= 0 or G.GAME.current_round.free_rerolls > 0) and card.ability.extra > 0 then
				card.ability.extra = card.ability.extra - 1
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = {'' .. card.ability.extra}, colour = G.C.GREEN})
				ease_dollars(G.GAME.current_round.reroll_cost)
            end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.reroll_shop then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers"
}

JokerEvolution.evolutions:add_evolution("j_chaos", "j_evo_bordel", 10)

-- Monolith (Obelisk evolution)

SMODS.Joker{
	key = "monolith",
	name = "Monolith",
	rarity = "evo",
	blueprint_compat = true,
	perishable_compat = false,
	pos = {x = 4, y = 0},
	cost = 16,
	config = {extra = 0.2, Xmult = 1},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra, card.ability.x_mult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
            local reset = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    reset = false
                end
            end
            if reset then
                if card.ability.x_mult > 1 then
                    card.ability.x_mult = math.max(card.ability.x_mult - 1, 1)
                    return {
                        card = card,
                        message = localize{type='variable',key='a_xmult_minus',vars={0.5}},
                    }
                end
            else
                card.ability.x_mult = card.ability.x_mult + card.ability.extra
            end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.evolution then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_obelisk", "j_evo_monolith", 1, {'x_mult'})

-- Superstar (Luchador evolution)

SMODS.Joker{
	key = "superstar",
	name = "Superstar",
	rarity = "evo",
	pos = {x = 5, y = 0},
	cost = 10,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "luchador", set = "Other"}
	end,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
				G.GAME.blind:disable()
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
					local _card = nil
					if card.edition then
                    	_card = create_card_alt('Joker', G.jokers, nil, nil, nil, nil, 'j_luchador', nil, true, card.edition)
					else
						_card = create_card_alt('Joker', G.jokers, nil, nil, nil, nil, 'j_luchador')
					end
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                    _card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                end}))
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
		end
	end,
	calculate_evo = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition) and G.GAME.blind.boss then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_luchador", "j_evo_superstar", 2)

-- Tarotologist (Cartomancer evolution)

SMODS.Joker{
	key = "tarotologist",
	name = "Tarotologist",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 6, y = 0},
	cost = 10,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			local tarots_to_create = math.min(2, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + tarots_to_create
			G.E_MANAGER:add_event(Event({
			func = (function()
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = 1, tarots_to_create do
							local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'tar')
							_card:add_to_deck()
							G.consumeables:emplace(_card)
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
						end
						return true
					end}))
					card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
				return true
			end)}))
		end
	end,
	calculate_evo = function(self, card, context)
		if context.using_consumeable then
			if context.consumeable.ability.set == "Tarot" then
				card:decrement_evo_condition()
			end
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_cartomancer", "j_evo_tarotologist", 8)

-- VIP Card (Loyalty Card evolution)

SMODS.Joker{
	key = "vip_card",
	name = "VIP Card",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 7, y = 0},
	cost = 12,
	config = {extra = {Xmult = 4, every = 3, remaining = "3 remaining"}},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.Xmult, card.ability.extra.every + 1, localize{type = 'variable', key = (card.ability.loyalty_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = {card.ability.loyalty_remaining}}}}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.burnt_hand = 0
        card.ability.loyalty_remaining = card.ability.extra.every
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.loyalty_remaining = (card.ability.extra.every-1-(G.GAME.hands_played - card.ability.hands_played_at_create))%(card.ability.extra.every+1)
            if context.blueprint then
                if card.ability.loyalty_remaining == card.ability.extra.every then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            else
                if card.ability.loyalty_remaining == 0 then
                    local eval = function(card) return (card.ability.loyalty_remaining == 0) end
                    juice_card_until(card, eval, true)
                elseif card.ability.loyalty_remaining == card.ability.extra.every then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.cardarea == G.jokers then
			if context.after and G.GAME.chips + hand_chips * mult > G.GAME.blind.chips * 2 then
				card:decrement_evo_condition()
			end
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_loyalty_card", "j_evo_vip_card", 4)

-- Clenched Fist (Raised Fist evolution)

SMODS.Joker{
	key = "clenched_fist",
	name = "Clenched Fist",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 8, y = 0},
	cost = 10,
	calculate = function(self, card, context)
		if not context.end_of_round and context.individual and context.cardarea == G.hand then
			local temp_mult, temp_ID = 1, 1
			local clenched_card = nil
			for i=1, #G.hand.cards do
				if temp_ID <= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then temp_mult = G.hand.cards[i].base.nominal; temp_ID = G.hand.cards[i].base.id; clenched_card = G.hand.cards[i] end
			end
			if clenched_card == context.other_card then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED,
						card = card,
					}
				else
					return {
						h_mult = 2*temp_mult,
						card = card,
					}
				end
			end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.cardarea == G.play then
			if context.individual and not context.other_card.debuff then
				card:decrement_evo_condition()
			end
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_raised_fist", "j_evo_clenched_fist", 25)

-- Ninefold Joy (Cloud Nine evolution)

SMODS.Joker{
	key = "ninefold_joy",
	name = "Ninefold Joy",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 9, y = 0},
	cost = 10,
	config = {extra = 0},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "modified_card", set = "Other"}
		return {vars = {card.ability.extra}}
	end,
	update = function(self, card, dt)
		card.ability.extra = 0
		if G.playing_cards then
			for _, v in pairs(G.playing_cards) do
				if v:get_id() == 9 and (v.edition or v.seal or v.ability.effect ~= "Base") then
					card.ability.extra = card.ability.extra + 2
				elseif v:get_id() == 9 then
					card.ability.extra = card.ability.extra + 1
				end
			end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.individual and not context.end_of_round and context.cardarea == G.play then
			if not context.other_card.debuff and context.other_card:get_id() == 9 then
				card:decrement_evo_condition()
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		if card.ability.extra > 0 then
			return card.ability.extra
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_cloud_9", "j_evo_ninefold_joy", 9)

-- Full-Sugar Cola (Diet Cola evolution)

SMODS.Joker{
	key = "full_sugar_cola",
	name = "Full-Sugar Cola",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 0, y = 1},
	cost = 12,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "tag_double", set = "Tag"}
		return {vars = {localize{type = 'name_text', set = 'Tag', key = 'tag_double', nodes = {}}}}
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_double'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
			G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_double'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
		end
	end,
	calculate_evo = function(self, card, context)
		if context.skip_blind then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_diet_cola", "j_evo_full_sugar_cola", 2)

-- Wildfire (Campfire evolution)

SMODS.Joker{
	key = "wildfire",
	name = "Wildfire",
	rarity = "evo",
	blueprint_compat = true,
	perishable_compat = false,
	pos = {x = 1, y = 1},
	cost = 18,
	config = {extra = 0.25},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra, card.ability.x_mult}}
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.blueprint then
			card.ability.x_mult = card.ability.x_mult + card.ability.extra
			G.E_MANAGER:add_event(Event({
				func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
			end}))
			return
		end
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) and G.GAME.blind.boss and card.ability.x_mult > 1 then
			card.ability.x_mult = math.max(card.ability.x_mult -1, 1)
			return {
				message = "-X1 Mult",
				colour = G.C.RED
			}
		end
	end,
	calculate_evo = function(self, card, context)
		if context.selling_card then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_campfire", "j_evo_wildfire", 15, {'x_mult'})

-- Aerialist (Acrobat evolution)

SMODS.Joker{
	key = "aerialist",
	name = "Aerialist",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 2, y = 1},
	cost = 12,
	config = {extra = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
				Xmult_mod = card.ability.extra
			}
		end
	end,
	calculate_evo = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition) and G.GAME.current_round.hands_left == 0 then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_acrobat", "j_evo_aerialist", 4)

-- Pilot's License (Driver's License evolution)

SMODS.Joker{
	key = "pilots_license",
	name = "Pilot's License",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 3, y = 1},
	cost = 14,
	config = {extra = {Xmult = 1, Xmult_mod = 0.75}},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.Xmult_mod, card.ability.passport_tally, card.ability.extra.Xmult or "1"}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end,
	calculate_evo = function(self, card, context)
		if context.playing_card_added then
			card:decrement_evo_condition()
		end
	end,
	update = function(self, card, dt)
		card.ability.passport_tally = 0
		if G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v.config.center ~= G.P_CENTERS.c_base then
					card.ability.passport_tally = card.ability.passport_tally + 1
				end
			end
			if card.ability.passport_tally > 0 and card.ability.passport_tally % 4 == 0 then
				card.ability.extra.Xmult = 1 + (math.floor(card.ability.passport_tally / 4) * card.ability.extra.Xmult_mod)
			end
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_drivers_license", "j_evo_pilots_license", 8)

-- Short-Term Satisfaction (Delayed Gratification evolution)

SMODS.Joker{
	key = "short_term_satisfaction",
	name = "Short-Term Satisfaction",
	rarity = "evo",
	pos = {x = 4, y = 1},
	cost = 8,
	config = {extra = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	calc_dollar_bonus = function(self, card)
		if G.GAME.current_round.discards_left > 0 then
            return G.GAME.current_round.discards_left * card.ability.extra
		end
	end,
	calculate_evo = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition) and G.GAME.current_round.discards_used == 0 then
			card:decrement_evo_condition()
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_delayed_grat", "j_evo_short_term_satisfaction", 3)

-- Ripple (Splash evolution)

SMODS.Joker{
	key = "ripple",
	name = "Ripple",
	rarity = "evo",
	blueprint_compat = true,
	pos = {x = 5, y = 1},
	cost = 6,
	config = {extra = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.play.cards)
			if #context.scoring_hand > #scoring_hand then
				return {
                    message = localize{type='variable',key='a_mult',vars={(#context.scoring_hand - #scoring_hand) * card.ability.extra}},
                    mult_mod = (#context.scoring_hand - #scoring_hand) * card.ability.extra
                }
			end
		end
	end,
	calculate_evo = function(self, card, context)
		if context.joker_main then
			local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(G.play.cards)
			if #context.scoring_hand > #scoring_hand then
				card:decrement_evo_condition()
			end
		end
	end,
	atlas = "je_jokers",
}

JokerEvolution.evolutions:add_evolution("j_splash", "j_evo_ripple", 5)

-- Other Jokers

if JokerEvolution_Config.enable_mod_jokers then

	-- Collector Joker

	SMODS.Joker{
		key = "collector",
		name = "Collector Joker",
		rarity = 3,
		blueprint_compat = true,
		pos = {x = 6, y = 1},
		cost = 8,
		config = {extra = 1},
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra, (G.GAME.evolution_total and G.GAME.evolution_total + 1) or 1}}
		end,
		calculate = function(self, card, context)
			if context.evolution and not context.blueprint then
				G.E_MANAGER:add_event(Event({func = function()
					card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={G.GAME.evolution_total + 1}}});
					return true
				end}))
			end
			if context.joker_main and (G.GAME.evolution_total and G.GAME.evolution_total > 0) then
				return {
					message = localize{type='variable',key='a_xmult',vars={G.GAME.evolution_total + 1}},
					Xmult_mod = G.GAME.evolution_total + 1
				}
			end
		end,
		atlas = "je_jokers",
	}

end