return {
    descriptions = {
        Joker = {
            j_evo_astronaut = {
                name = "Astronaut Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "upgrade level of most",
                    "played {C:attention}poker hand{}",
                    "when scoring"
                }
            },
            j_evo_rendezvous = {
                name = "Rendez-Vous",
                text = {
                    "If {C:attention}poker hand{} is a",
                    "{C:attention}#1#{}, create a",
                    "random {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)"
                }
            },
            j_evo_bordel = {
                name = "Bordel the Buffon",
                text = {
                    "Each round, next {C:attention}3{} {C:green}rerolls{}",
                    "are refunded",
                    "{C:inactive}(Currently {C:green}#1#{C:inactive})"
                }
            },
            j_evo_monolith = {
                name = "Monolith",
                text = {
                    "This Joker gains {X:mult,C:white} X#1# {} Mult",
                    "per {C:attention}consecutive{} hand played,",
                    "reduced by {X:mult,C:white}X1{} if playing",
                    "your most played {C:attention}poker hand",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                }
            },
            j_evo_superstar = {
                name = "Superstar",
                text = {
                    "Sell this card to",
                    "disable the current",
                    "{C:attention}Boss Blind{} and create",
                    "a {C:attention}Luchador{} card",
                }
            },
            j_evo_tarotologist = {
                name = "Tarotologist",
                text = {
                    "Create {C:attention}2{} {C:tarot}Tarot{} cards",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room)"
                },
            },
            j_evo_vip_card = {
                name = "VIP Card",
                text = {
                    "{X:red,C:white} X#1# {} Mult every",
                    "{C:attention}#2#{} hands played",
                    "{C:inactive}#3#"
                }
            },
            j_evo_clenched_fist = {
                name = "Clenched Fist",
                text = {
                    "Adds {C:attention}double{} the rank",
                    "of {C:attention}highest{} ranked card",
                    "held in hand to Mult"
                }
            },
            j_evo_ninefold_joy = {
                name = "Ninefold Joy",
                text = {
                    "Earn {C:money}$1{} for each {C:attention}9{}",
                    "or {C:money}$2{} for each {C:attention}modified",
                    "{C:attention}9{} in your {C:attention}full deck",
                    "at end of round",
                    "{C:inactive}(Currently {C:money}$#1#{}{C:inactive})"
                }
            },
            j_evo_full_sugar_cola = {
                name = "Full-Sugar Cola",
                text = {
                    "Sell this card to",
                    "create {C:attention}2{} free",
                    "{C:attention}#1#"
                }
            },
            j_evo_wildfire = {
                name = "Wildfire",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "for each card {C:attention}sold{}, loses",
                    "{X:mult,C:white}X1{} Mult after {C:attention}Boss Blind{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                }
            },
            j_evo_aerialist = {
                name = "Aerialist",
                text = {
                    "{X:red,C:white} X#1# {} Mult on {C:attention}first",
                    "{C:attention}hand{} of round"
                },
            },
            j_evo_pilots_license = {
                name = "Pilot's License",
                text = {
                    "{X:mult,C:white} X#1# {} Mult for every",
                    "{C:attention}4{} Enhanced cards",
                    "in your full deck",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}, {X:mult,C:white} X#3# {C:inactive} Mult)"
                },
            },
            j_evo_short_term_satisfaction = {
                name = "Short-Term Satisfaction",
                text = {
                    "Earn {C:money}$#1#{} per {C:attention}discard{} left",
                    "by end of the round"
                }
            },
            j_evo_ripple = {
                name = "Ripple",
                text = {
                    "Every {C:attention}played card",
                    "counts in scoring",
                    "{C:red}+#1#{} Mult per {C:attention}extra{}",
                    "scored cards",
                    "{C:inactive}(ex: Pair with 5 cards)",
                }
            },
            j_evo_collector = {
                name = "Collector Joker",
                text = {
                    "{X:red,C:white}X#1#{} Mult for each",
                    "{C:attention}evolution{} made this run",
                    "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)",
                }
            },
        },
        Spectral = {
            c_evo_evolution = {
                name = "Evolution",
                text = {
                    "{C:attention}Evolves{} a random Joker,",
                    "destroys a different Joker",
                }
            },
        },
        Other = {
            modified_card = {
                name = "Modified",
                text = {
                    "Enhancement, seal, edition"
                }
            },
            luchador = {  -- Recreating Luchador tooltip to avoid showing evo tooltip on Superstar
                name = "Luchador",
                text = {
                    "Sell this card to",
                    "disable the current",
                    "{C:attention}Boss Blind{}",
                }
            },
            je_j_space = {
                name = "Evolution",
                text = {
                    "Upgrade {C:attention}#2#{} poker hands",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_seance = {
                name = "Evolution",
                text = {
                    "Score {C:attention}#2# Straight Flush",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_chaos = {
                name = "Evolution",
                text = {
                    "Reroll {C:attention}#2#{} times",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_obelisk = {
                name = "Evolution",
                text = {
                    "Evolve {C:attention}#2#{} card",
                    "this run",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_luchador = {
                name = "Evolution",
                text = {
                    "Defeat {C:attention}#2#{} boss blinds",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_cartomancer = {
                name = "Evolution",
                text = {
                    "Use {C:attention}#2#{} {C:purple}Tarot{} cards",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_loyalty_card = {
                name = "Evolution",
                text = {
                    "Score twice",
                    "the blind goal",
                    "{C:attention}#2#{} times",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_raised_fist = {
                name = "Evolution",
                text = {
                    "Score {C:attention}#2#{} cards",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_cloud_9 = {
                name = "Evolution",
                text = {
                    "Score {C:attention}#2# 9{}s cards",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_diet_cola = {
                name = "Evolution",
                text = {
                    "Skip {C:attention}#2#{} blinds",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_campfire = {
                name = "Evolution",
                text = {
                    "Sell {C:attention}#2#{} cards",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_acrobat = {
                name = "Evolution",
                text = {
                    "Play your final hand {C:attention}#2#{} times",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_drivers_license = {
                name = "Evolution",
                text = {
                    "Add {C:attention}#2#{} cards to your deck",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_delayed_grat = {
                name = "Evolution",
                text = {
                    "Win {C:attention}#2#{} rounds",
                    "without discarding",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            },
            je_j_splash = {
                name = "Evolution",
                text = {
                    "Score {C:attention}#2#{} hands",
                    "with extra cards",
                    "{C:inactive}(ex: Pair with 5 cards)",
                    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_evo = "Evolved",
            k_evolution_ex = "Evolution!",
            b_evolve = "EVOLVE"
        }
    }
}