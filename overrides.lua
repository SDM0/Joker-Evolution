--function Card:add_to_deck(from_debuff)

-- Custom Rarity setup by MathIsFun
Game:set_globals()
G.C.RARITY["evo"] = G.C.GOLD;
local ip = SMODS.insert_pool
function SMODS.insert_pool(pool, center, replace)
    if pool == nil then pool = {} end
    ip(pool, center, replace)
end
local get_badge_colourref = get_badge_colour
function get_badge_colour(key)
    local fromRef = get_badge_colourref(key)
    if key == 'evo' then return G.C.RARITY["evo"] end
    return fromRef
end
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then lc() end
    G.ARGS.LOC_COLOURS.evo = G.C.RARITY['evo']
    return lc(_c, _default)
end
local is = SMODS.injectItems
function SMODS.injectItems()
    local m = is()
    G.P_JOKER_RARITY_POOLS.evo = {}
    for k, v in pairs(G.P_CENTERS) do
        v.key = k
        if v.rarity and v.rarity == 'evo'and v.set == 'Joker' and not v.demo then
            table.insert(G.P_JOKER_RARITY_POOLS[v.rarity], v)
        end
    end
    return m
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)
	if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card:get_card_evolution() then
		local evolve = 
		{n=G.UIT.C, config={h=0.6, align = "cr"}, nodes={
		  {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_evolve_card'}, nodes={
			{n=G.UIT.C, config={align = "tm"}, nodes={
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.B, config={w=0.1,h=0.6}},
					{n=G.UIT.T, config={text = localize('b_evolve'),colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true}}
				}},
			}},
		  }}
		}}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, evolve)
		return retval
	end
	return retval
end

local updateref = Card.update
function Card:update(dt)
  updateref(self, dt)

	if G.STAGE == G.STAGES.RUN then

		if self:get_card_evolution() ~= false then
			self.ability.evolution = self.ability.evolution or {}

			if self:can_evolve_card() and not self.ability.evolution.jiggle then
				juice_card_until(self, function(card) return (card:can_evolve_card()) end, true)

				self.ability.evolution.jiggle = true
			end
		
			if not self:can_evolve_card() and self.ability.evolution.jiggle then 
				self.ability.evolution.jiggle = false
			end
		end
  	end
end

local calculate_jokerref = Card.calculate_joker
function Card:calculate_joker(context)
	local ret = calculate_jokerref(self, context)
	if not context.retrigger_joker then --Cryptid Canvas/retrigger_joker failsafe
		self:calculate_evo(context)
	end
	return ret
end

local level_up_handref = level_up_hand
function level_up_hand(card, hand, instant, amount)
	level_up_handref(card, hand, instant, amount)
	if G.jokers and G.jokers.cards then
		for i = 1, #G.jokers.cards do
			G.jokers.cards[i]:calculate_joker({je_level_up = true})
		end
	end
end