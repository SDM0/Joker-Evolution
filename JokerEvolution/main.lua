--- STEAMODDED HEADER
--- MOD_NAME: Joker Evolution
--- MOD_ID: joker_evolution
--- MOD_AUTHOR: [SDM_0]
--- MOD_DESCRIPTION: Gives a few jokers strong evolutions!
--- PRIORITY: -1000
--- BADGE_COLOUR: 18cadc
--- DISPLAY_NAME: Joker Evolution
--- PREFIX: evo
--- VERSION: 1.0.0c
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

NFS.load(JokerEvolution_Mod.path.."localization.lua")()
NFS.load(JokerEvolution_Mod.path.."overrides.lua")()
NFS.load(JokerEvolution_Mod.path.."functions.lua")()

NFS.load(JokerEvolution_Mod.path.."data/jokers.lua")()

----------------------------------------------
------------MOD CODE END----------------------