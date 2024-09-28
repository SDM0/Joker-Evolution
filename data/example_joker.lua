
--- Create the evolved joker using SMODS.Joker (documentation for SMODS.Joker available on the Steamodded wiki)
SMODS.Joker{
	key = "ultimate_joker",
	name = "Ultimate Joker",
	rarity = "evo", -- New rarity for evolved jokers
	blueprint_compat = true,
	pos = {x = 0, y = 0},
	cost = 4,	--Rule of thumb: double the original joker cost
	config = {extra = 8},
	loc_txt = {
		name = "Ultimate Joker",
		text = {
			"{C:red}+#1#{} Mult"
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra}},
				mult_mod = card.ability.extra
			}
		end
	end,
	-- "calculate_evo" works like "calculate_joker"
	-- but instead of returning something you use it to decrement the condition
	calculate_evo = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition) and G.GAME.blind.boss then
			card:decrement_evo_condition()	--Helper function from "JokerEvolution" to decrement the requirement count
		end
	end,
	-- Credits the "Joker Evolution" mod, thank you if you add it to your evolved jokers!
	--[[set_badges = function(self, card, badges)
		local len = string.len("Joker Evolution")
		local size = 0.9 - (len > 6 and 0.02*(len-6) or 0)
		badges[#badges + 1] = create_badge("Joker Evolution", HEX("18cadc"), nil, size)
	end,--]]
	atlas = "je_jokers"
}

--- Add the evolution condition tooltip to the original joker, you can also write it in your localization folder
local process_loc_textref = JokerEvolution_Mod.process_loc_text
function JokerEvolution_Mod.process_loc_text()
    process_loc_textref()
	-- G.localization.descriptions.Other.je_ + original joker key
    G.localization.descriptions.Other.je_j_joker = {
        name = "Evolution",
        text = {
			-- #1#: Current requirement count
			-- #2#: Evolution requirement count
			"Defeat {C:attention}#2#{} boss blind",
			"{C:inactive}({C:attention}#1#{C:inactive}/#2#)" -- This line is important to keep track of the count
		}
    }
end

--- Add the mod check to make sure the mod is installed
if SMODS.Mods['joker_evolution'] then

    ---JokerEvolution.evolutions:add_evolution(joker, evolved_joker, amount)

    --- joker: the key of the non-evolved joker
    --- evolved_joker: the "j_ + mod prefix + key" of your evolved joker
    --- amount: The amount of time the condition (calculate_evo) has to be achieved

    JokerEvolution.evolutions:add_evolution("j_joker", "j_evo_ultimate_joker", 1)

else
	sendDebugMessage('Please install the "Joker Evolution" mod') -- You can also add the mod as a dependency in your mod header
end

return --- No need to add this return if the evolution is in your main mod lua file