local process_loc_textref = JokerEvolution_Mod.process_loc_text
function JokerEvolution_Mod.process_loc_text()
    process_loc_textref()
    G.localization.descriptions.Other.je_j_space = {
        name = "Evolution",
        text = {
            "Upgrade {C:attention}#2#{} poker hands",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_seance = {
        name = "Evolution",
        text = {
            "Score {C:attention}#2# Straight Flush",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_chaos = {
        name = "Evolution",
        text = {
            "Reroll {C:attention}#2#{} times",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_obelisk = {
        name = "Evolution",
        text = {
            "Evolve {C:attention}#2#{} card",
            "this run",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_luchador = {
        name = "Evolution",
        text = {
            "Defeat {C:attention}#2#{} boss blinds",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_cartomancer = {
        name = "Evolution",
        text = {
            "Use {C:attention}#2#{} {C:purple}Tarot{} cards",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_loyalty_card = {
        name = "Evolution",
        text = {
            "Score twice",
            "the blind goal",
            "{C:attention}#2#{} times",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_raised_fist = {
        name = "Evolution",
        text = {
            "Score {C:attention}#2#{} cards",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_cloud_9 = {
        name = "Evolution",
        text = {
            "Score {C:attention}#2# 9{}s cards",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_diet_cola = {
        name = "Evolution",
        text = {
            "Skip {C:attention}#2#{} blinds",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_campfire = {
        name = "Evolution",
        text = {
            "Sell {C:attention}#2#{} cards",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_acrobat = {
        name = "Evolution",
        text = {
            "Play your final hand {C:attention}#2#{} times",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_drivers_license = {
        name = "Evolution",
        text = {
            "Add {C:attention}#2#{} cards to your deck",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_delayed_grat = {
        name = "Evolution",
        text = {
            "Win {C:attention}#2#{} rounds",
            "without discarding",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
    G.localization.descriptions.Other.je_j_splash = {
        name = "Evolution",
        text = {
            "Score {C:attention}#2#{} hands",
            "with extra cards",
            "{C:inactive}(ex: Pair with 5 cards)",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
        }
    }
end

return
