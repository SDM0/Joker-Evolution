--- STEAMODDED HEADER
--- MOD_NAME: Joker Evolution
--- MOD_ID: joker_evolution
--- MOD_AUTHOR: [SDM_0]
--- MOD_DESCRIPTION: Gives a few jokers strong evolutions! Consumable art by RattlingSnow353
--- PRIORITY: -1000
--- BADGE_COLOUR: 18cadc
--- DISPLAY_NAME: Joker Evolution
--- PREFIX: evo
--- VERSION: 1.2.1e
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1030f]

----------------------------------------------
------------MOD CODE -------------------------

JokerEvolution_Mod = SMODS.current_mod
JokerEvolution_Config = JokerEvolution_Mod.config

JokerEvolution = {}
JokerEvolution.evolutions = {}

SMODS.Rarity{
    key = "evo",
    prefix_config = {key = false},
    badge_colour = G.C.GOLD,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.load_file("overrides.lua")()
SMODS.load_file("functions.lua")()

if JokerEvolution_Config.enable_jokers then
    SMODS.load_file("data/example_joker.lua")()
    SMODS.load_file("data/jokers.lua")()
    if JokerDisplay then
        SMODS.load_file("jokerdisplay_definitions.lua")()
    end
end

if JokerEvolution_Config.enable_consus then
    SMODS.load_file("data/consumables.lua")()
end

JokerEvolution_Mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6}, nodes = {
        {n = G.UIT.R, config = {align = "cl", padding = 0, minh = 0.1}, nodes = {}},

        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = JokerEvolution_Config, ref_value = "enable_jokers" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Enable Original Evolutions", scale = 0.42, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = JokerEvolution_Config, ref_value = "enable_consus" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Enable Consumables", scale = 0.42, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = JokerEvolution_Config, ref_value = "enable_mod_jokers" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Enable Extra Jokers (ex: Collector Joker)", scale = 0.42, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = JokerEvolution_Config, ref_value = "enable_pool_restriction" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Enable poll restriction", scale = 0.42, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.5}, nodes = {
            {n = G.UIT.T, config = {text = "(Must restart to apply changes)", scale = 0.40, colour = G.C.UI.TEXT_LIGHT}},
        }},

    }}
end

----------------------------------------------
------------MOD CODE END----------------------