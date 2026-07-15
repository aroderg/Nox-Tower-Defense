function assetReload()
    local imgStrings = {
        backgrounds = {
            default = "background.png",
            stellar = "background_stellar.png",
            eclipse = "background_eclipse.png",
            nova = "background_nova.png",
            aurora = "background_aurora.png",
            polaris = "background_polaris.png",
        },
        currencies = {
            copper = "currency_copper_new.png",
            silver = "currency_silver_new.png",
            gold = "currency_gold_new.png",
            electrum = "currency_electrum.png",
            token = "currency_token.png",
            token_big = "currency_token_big.png",
            jade = "currency_jade.png",
        },
        towers = {
            main = "tower_main.png",
            main_shielded = "tower_main_shielded.png",
            eclipse_sun = "tower_eclipse_sun.png",
            eclipse_sun2 = "tower_eclipse_sun2.png",
            eclipse_sun2_shielded = "tower_eclipse_sun2_shielded.png",
            eclipse_moon = "tower_eclipse_moon.png",
            eclipse_moon2 = "tower_eclipse_moon2.png",
            nova_static = "tower_nova_static.png",
            nova_outerLines = "tower_nova_outerLines.png",
            nova_branches = "tower_nova_branches.png",
            nova_shield = "tower_nova_shield.png",
            aurora_static = "tower_aurora_static.png",
            aurora_unshielded = "tower_aurora_unshielded.png",
            aurora_shield = "tower_aurora_shield.png",
            polaris = "tower_polaris.png",
            polaris_base = "tower_polaris_base.png",
            polaris_medium = "tower_polaris_medium.png",
            polaris_inner = "tower_polaris_inner.png",
            polaris_shield = "tower_polaris_shield.png",
            projectile = "tower_projectile.png",
        },
        enemies = {
            basic = "enemy_basic.png",
            tank = "enemy_tank.png",
            swift = "enemy_swift.png",
            sentry = "enemy_sentry.png",
            centurion = "enemy_centurion.png",
            exploder_static = "enemy_exploder_static.png",
        },
        icons = {
            enemy_health = "icon_enemy_health.png",
            enemy_attack = "icon_enemy_attack.png",
            player_attack = "icon_player_attack.png",
        },
        particles = {
            collapse = "particle_collapse.png",
            kill_basic = "particle_kill_enemy_basic.png",
            kill_tank = "particle_kill_enemy_tank.png",
            kill_swift = "particle_kill_enemy_swift.png",
            kill_sentry = "particle_kill_enemy_sentry.png",
            kill_centurion = "particle_kill_enemy_centurion.png",
            kill_exploder = "particle_kill_enemy_exploder.png",
            crystalExplosion = "particle_crystalExplosion.png",
            burn = "particle_burn.png",
            meteor = "particle_meteor.png",
        },
        buttons = {
            pause = "button_pause.png",
            arrowLeft = "button_arrowLeft.png",
            arrowRight = "button_arrowRight.png",
            arrowLeft_big = "button_arrowLeft_big.png",
            arrowRight_big = "button_arrowRight_big.png",
            questionMark = "button_questionMark.png",
        },
        abilities = {
            crystal = "crystal.png",
            crystal_l1 = "crystal_multilayered_l1.png",
            crystal_l2 = "crystal_multilayered_l2.png",
            crystal_l3 = "crystal_multilayered_l3.png",
            crystal_aoe = "crystal_aoe.png",
            rainforest = "rainforest.png",
            ice_domain = "ice_domain.png",
            magma_pool = "magmaTouch_pool.png",
            lightningOrb = "lightningOrb.png",
            lightningOrb_shadow = "lightningOrb_shadow.png",
            lightningOrb_laser1 = "lightningOrb_laser_var1.png",
            lightningOrb_laser2 = "lightningOrb_laser_var2.png",
            lightningOrb_laser3 = "lightningOrb_laser_var3.png",
            vines1 = "JerelosBlessing_vines_var1.png",
            vines2 = "JerelosBlessing_vines_var2.png",
            vines3 = "JerelosBlessing_vines_var3.png",
            vines4 = "JerelosBlessing_vines_var4.png",
            water = "JerelosBlessing_water.png",
            waves1 = "JerelosBlessing_waves_var1.png",
            waves2 = "JerelosBlessing_waves_var2.png",
            waves3 = "JerelosBlessing_waves_var3.png",
            waves4 = "JerelosBlessing_waves_var4.png",
            disruptWave = "disruptWave.png",
        },
        previews = {
            spikedCrystals = "ability_preview_spikedCrystals.png",
            scatterFire = "ability_preview_scatterFire.png",
            burstFire = "ability_preview_burstFire.png",
            rainforest = "ability_preview_rainforest.png",
            iceDomain = "ability_preview_iceDomain.png",
            magmaTouch = "ability_preview_magmaTouch.png",
            lightningOrb = "ability_preview_lightningOrb.png",
            JerelosBlessing = "ability_preview_JerelosBlessing.png",
            berserkerKit = "ability_preview_berserkerKit.png",
            sniperKit = "ability_preview_sniperKit.png",
            tankKit = "ability_preview_tankKit.png",
            supercritical = "ability_preview_supercritical.png",
            disruptWave = "ability_preview_disruptWave.png",
            enemyBalancing = "ability_preview_enemyBalancing.png",
            waveDash = "ability_preview_waveDash.png",
        },
        misc = {
            meteor = "meteor.png",
            exploder_quads = "enemy_exploder_quads.png",
            exploder_aoe = "exploder_aoe_big.png"
        }
    }
    imgs = {}
    for i,v in pairs(imgStrings) do
        imgs[i] = {}
        for j,w in pairs(v) do
            imgs[i][j] = love.graphics.newImage("assets/" .. w)
        end
    end
    local audioStrings = {
        enemies = {
            kill = "enemy_kill.wav",
            kill_centurion = "enemy_kill_centurion.wav",
            kill_sentry = "enemy_kill_sentry.wav",
            exploder_explode = "exploder_explode.wav"
        },
        tower = {
            scatterBurstFire = "tower_scatterFire-burstFire.wav",
            damageTaken = "tower_damageTaken.wav",
            damageAbsorbed = "tower_damageAbsorbed.wav",
            collapse = "tower_collapse.wav",
            fire = "tower_fire2.wav",
            lifestealTrigger = "tower_lifesteal2.wav",
        },
        misc = {
            crystal_explosion = "crystal_explode.wav",
            rainforest_activation = "rainforest_activation.wav",
            lightningOrb_launch = "lightningOrb_launch.wav",
            upgradeBought = "upgrade_bought.wav"
        }
    }
    audios = {}
    for i,v in pairs(audioStrings) do
        audios[i] = {}
        for j,w in pairs(v) do
            audios[i][j] = love.audio.newSource("assets/audio/" .. w, "static")
        end
    end

    local fontStrings = {
        Afacad = {
            regular = {
                12, 16, 18, 20, 24, 28
            },
            medium = {
                24
            },
            semibold = {
                24, 28
            },
            bold = {
                16, 18, 20, 24, 28, 32, 48
            }
        },
        Vera = {
            regular = {
                12, 16
            },
            bold = {
                16, 18, 24
            }
        }
    }
    local fontFoldersAndTypes = {
        Afacad = {staticpart="AfacadFlux",folder="Afacad Flux",weights={regular="-Regular",medium="-Medium",semibold="-SemiBold",bold="-Bold"}},
        Vera = {staticpart="Vera",folder="Vera",weights={regular="",bold="Bd"}}
    }
    fonts = {}
    for i,v in pairs(fontStrings) do
        for j,w in pairs(v) do
            for k,x in pairs(w) do
                local toIndex = "_" .. x
                local curFont = fontFoldersAndTypes[i]
                local folder = curFont.folder
                local weight = curFont.weights[j]
                local staticpart = curFont.staticpart
                if not fonts[i] then fonts[i] = {} end
                if not fonts[i][j] then fonts[i][j] = {} end
                fonts[i][j][toIndex] = love.graphics.newFont("assets/fonts/" .. folder .. "/" .. staticpart .. weight .. ".ttf", x)
            end
        end
    end
end

assetReload()