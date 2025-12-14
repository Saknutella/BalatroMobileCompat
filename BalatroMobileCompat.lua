--- STEAMODDED HEADER
--- MOD_NAME: Balatro Mobile Compat
--- MOD_ID: BalatroMobileCompat
--- MOD_AUTHOR: [eeve-lyn & more]
--- MOD_DESCRIPTION: Toggle CRT shader effect in-game, with FPS Cap, externalstorage, flamefix, and lots more to make Balatro working on mobile
--- VERSION: 1.0.1o
--- PREFIX: bmc

----------------------------------------------
------------MOD CODE -------------------------

local config = SMODS.current_mod.config

G.BMC_CRT_ENABLED = config.crt_enabled
G.BMC_FPS_LIMIT_ENABLED = config.fps_limit_enabled

local function apply_crt_effect(enabled)
    if enabled then
        if G.SHADERS and G.SHADERS['CRT'] then
            love.graphics.setShader(G.SHADERS['CRT'])
        end
    else
        love.graphics.setShader()
    end
end

local function apply_fps_limit(enabled)
    if enabled then
        local refresh_rate = select(3, love.window.getMode())['refreshrate'] or 60
        G.FPS_CAP = refresh_rate
    else
        G.FPS_CAP = 500
    end
end

function SMODS.current_mod.config_tab()
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK,
            r = 0.1,
            emboss = 0.05
        },
        nodes = {
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.1},
                nodes = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = "Mobile Compatibility Settings",
                            scale = 0.5,
                            colour = G.C.UI.TEXT_LIGHT
                        }
                    }
                }
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.1},
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {align = "cl", minw = 4},
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "CRT Shader",
                                    scale = 0.4,
                                    colour = G.C.UI.TEXT_LIGHT
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cr"},
                        nodes = {
                            create_toggle({
                                label = "",
                                ref_table = config,
                                ref_value = "crt_enabled",
                                callback = function(val)
                                    config.crt_enabled = val
                                    G.BMC_CRT_ENABLED = val
                                    apply_crt_effect(val)
                                    SMODS.save_mod_config(SMODS.current_mod)
                                end
                            })
                        }
                    }
                }
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.05},
                nodes = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = "Retro CRT screen effect",
                            scale = 0.3,
                            colour = G.C.UI.TEXT_INACTIVE
                        }
                    }
                }
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.1},
                nodes = {}
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.1},
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {align = "cl", minw = 4},
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "FPS Limit",
                                    scale = 0.4,
                                    colour = G.C.UI.TEXT_LIGHT
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cr"},
                        nodes = {
                            create_toggle({
                                label = "",
                                ref_table = config,
                                ref_value = "fps_limit_enabled",
                                callback = function(val)
                                    config.fps_limit_enabled = val
                                    G.BMC_FPS_LIMIT_ENABLED = val
                                    apply_fps_limit(val)
                                    SMODS.save_mod_config(SMODS.current_mod)
                                end
                            })
                        }
                    }
                }
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.05},
                nodes = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = "Limit to monitor refresh rate",
                            scale = 0.3,
                            colour = G.C.UI.TEXT_INACTIVE
                        }
                    }
                }
            },
            
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.2},
                nodes = {
                    {
                        n = G.UIT.T,
                        config = {
                            text = "Settings saved automatically",
                            scale = 0.3,
                            colour = G.C.BLUE
                        }
                    }
                }
            }
        }
    }
end

function SMODS.current_mod.reset_game_globals(run_start)
    local config = SMODS.current_mod.config
    
    G.BMC_CRT_ENABLED = config.crt_enabled
    G.BMC_FPS_LIMIT_ENABLED = config.fps_limit_enabled
    
    apply_crt_effect(config.crt_enabled)
    apply_fps_limit(config.fps_limit_enabled)
end


apply_crt_effect(config.crt_enabled)
apply_fps_limit(config.fps_limit_enabled)

----------------------------------------------
------------MOD CODE END----------------------
