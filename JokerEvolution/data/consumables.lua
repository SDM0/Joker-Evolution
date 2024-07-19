SMODS.Atlas{
    key = "je_consus",
    path = "je_consus.png",
    px = 71,
    py = 95
}

SMODS.Consumable{
    key = 'c_evolution',
    set = 'Spectral',
    pos = {x = 0, y = 0},
    cost = 4,
    loc_txt = {
        name = "Evolution",
        text = {
            "{C:attention}Evolves{} a random Joker,",
            "{C:red}destroys{} a random Joker",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.config.extra}}
    end,
    can_use = function(self, card, area, copier)
        if G.jokers.cards and #G.jokers.cards > 1 then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:get_card_evolution() then
                    return true
                end
            end
        end
        return false
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.jokers.cards and #G.jokers.cards > 1 then
                local evolvable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i]:get_card_evolution() then
                        evolvable_jokers[#evolvable_jokers+1] = G.jokers.cards[i]
                    end
                end
                local chosen_joker = pseudorandom_element(evolvable_jokers, pseudoseed('evo_choice'))
                local deletable_jokers = {}
                for _, v in pairs(G.jokers.cards) do
                    if not v.ability.eternal and v ~= chosen_joker then deletable_jokers[#deletable_jokers + 1] = v end
                end
                
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.75, func = function()
                    chosen_joker:evolve_card()
                    pseudorandom_element(deletable_jokers, pseudoseed('evo_choice')):start_dissolve()
                    return true
                end }))
                return true
            end
        end }))
    end,
    atlas = "je_consus"
}

return