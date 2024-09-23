--- STEAMODDED HEADER
--- MOD_NAME: Joker Evolution
--- MOD_ID: joker_evolution
--- MOD_AUTHOR: [SDM_0]
--- MOD_DESCRIPTION: Gives a few jokers strong evolutions! Consumable art by RattlingSnow353
--- PRIORITY: -1000
--- BADGE_COLOUR: 18cadc
--- DISPLAY_NAME: Joker Evolution
--- PREFIX: evo
--- VERSION: 1.1.0c
--- LOADER_VERSION_GEQ: 1.0.0 

----------------------------------------------
------------MOD CODE -------------------------

JokerEvolution_Mod = SMODS.current_mod

JokerEvolution = {}
JokerEvolution.evolutions = {}

function JokerEvolution_Mod.process_loc_text()
	G.localization.misc.dictionary["k_evolution_ex"] = "Evolution!"
	G.localization.misc.dictionary["b_evolve"] = "EVOLVE"
    G.localization.descriptions.Other.modified_card = {
        name = "Modified",
        text = {
            "Enhancement, seal, edition"
        }
    }
    G.localization.descriptions.Other.luchador = {  -- Recreating Luchador tooltip to avoid showing evo tooltip on Superstar
        name = "Luchador",
        text = {
            "Sell this card to",
            "disable the current",
            "{C:attention}Boss Blind{}",
        }
    }
end

SMODS.load_file("localization.lua")()
SMODS.load_file("overrides.lua")()
SMODS.load_file("functions.lua")()

SMODS.load_file("data/example_joker.lua")()
SMODS.load_file("data/jokers.lua")()
SMODS.load_file("data/consumables.lua")()

----------------------------------------------
------------MOD CODE END----------------------