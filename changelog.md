# NoxTD 1.1.3 Aurora
### Nov 25th, 2025
- Added Enemy Info screen.
- Added the Disruptance Wave - Damage Dealt stat.
- Changed resource assets for more accessibility.
- Fixed username returning nil in one of the Orbitals.

## NoxTD 1.1.2 Aurora
### Oct 31st, 2025
- Fixed Disruptance Wave Ability crashing the game when upgraded to level 10.
- Expanded Ability Card border functionality:
    - Glows orange if the Ability is maxed out.
    - Glows green if it's upgradable.
    - Glows white otherwise.
- Stat menu is openable in the Abilities Hub section.
- Made all Kit Abilities incompatible.
- Bumped Critical Chance and Cluster Fire upgrades to 24% and 30% respectively.
- Ice Domain is incompatible with Magma Touch.
- Redesigned the Rainforest Ability to Ice Domain.
- Made D5 Waves count for Idle Gains.
- Fixed absurd amount of decimal points for stored resources in Idle Gains.
- Added on-screen messages for how much Copper/Silver you earned at the end of each wave.
- Added 10 more Orbitals.
- Switched logic of Nexus Buffs.
- Misc menu fixes.

### NoxTD 1.1.1a Aurora
### Oct 24th, 2025
- Added link to the Discord server.
- Made visual representation of Spiked Crystal explosion match the logic one.

## NoxTD 1.1.1 Aurora
### Oct 22nd, 2025
- Added the Disruptance Wave ability, regularly dealing damage to all enemies within the tower's range.
- Changed enemy scaling on D2+ once again.
- Fixed the Damage Round upgrade cost showing "nannil" if upgraded in the Hub.
- Nerfed Copper/wave and Silver/wave upgrades.
- Made the game dependent on logic steps which cannot exceed 1/50th of a second instead of raw delta time.
- Optimized the table.remove functions.
- Made Scatter Fire projectiles actually remove themselves if they are off-screen.
- Pressing Escape while in battle will pause the game.

# NoxTD 1.1 Aurora
### Oct 7, 2025
- Added Idle Gains:
    - For every 10 unique Waves beaten on any difficulty, gain 2 Silver/min.
    - For every 100 unique Waves beaten on any difficulty, gain 0.06 Gold/min.
    - Idle Time also goes up when you are offline with a maximum time of 6 hours (360m).
    - Idle Time is unaffected by Game Speed.
- Added Lifesteal and Cluster Fire related upgrades:
    - Lifesteal:
        - Lifesteal Chance increases the chance of healing by some damage dealt, maximum of 20%.
        - Lifesteal Percent increases the amount of damage the tower heals by (in %), maximum of 8.25% of damage dealt.
    - Cluster Fire:
        - Cluster Fire Chance increases the chance of shooting several enemies simultaneously, maximum of 22.5%.
        - Cluster Fire Targets increases the number of targets the tower would shoot simultaneously, maximum of 6.
        - Cluster Fire Efficiency increases the damage dealt to enemies which have been hit by Cluster Fire up to 85%.
- Added the Exploder enemy type:
    - Explodes when dies or approaches the tower.
    - Deals damage in a diameter of 10u equal to 250% of Basic enemies' attack damage.
- Added 3 Abilities: Sniper Kit, Tank Kit and Supercritical:
    - Sniper Kit increases your tower's Range while decreasing its Attack Speed.
    - Tank Kit increases your tower's Health, Regeneration, and Resistance and decreases its Attack Damage and Attack Speed stats.
    - Supercritical increases your Critical Chance, Critical Factor and grants a chance to deal more damage compared to critical hits.
- Added the Ability Chance and Cooldown Nexus stat buffs:
    - Ability Chance increases the chance of some Abilities triggering.
    - Ability Cooldown speeds up timed Abilities.
- Added the Acceleration Gameplay Modifier which speeds the game up by 4% each level, up to a maximum of 172% total compared to normal game speed.
- In-round tooltips show both Science and Round levels bought in brackets.
- The Theme setting allows you to change accent colors and backgrounds out of 5 pre-set ones.
- Added Difficulty 5.
    - Enemy HP and Damage start at 210K and 15K respectively.
    - Enemy amount and spawn rate start at 23 and 2.7 respectively.
- Added small instant visual hues on Ability previews based on their role.
- The Hub has different backgrounds based on chosen theme.
- Significantly weakened Magma Touch.
- Silver Multiplier is displayed under currently selected Difficulty.
- Enemy scaling has been tuned down for Difficulties 3 and 4.
- Increased Electrum alloying requirements.

## NoxTD 1.0.3 Nova
### Sep 2, 2025
- Added the Berserker Kit ability - it increases your Attack Damage and Attack Speed while decreasing Health and Resistance.
- Added basic internal savefile protection.
- Added 25 randomized Orbitals.
- Abilities incompatible with currently equipped ones have their Equip button glow red.
- Abilities can't be equipped when any Ability Menu is open.
- Fixed the hovering position for viewing Abilities' tags.
- Fixed uneven offsets for Lightning Orb detection.
- Fixed inconsistent upgrade text for the Hyperloop modifier.
- Tower collapse particle amount is affected by Particle Multiplier setting.
- Settings and Statistics can be opened from the Hub and the Pause menu while in battle.
- Added an outline to some menus that didn't have it previously.
- Nova tower has a visible shield while it is active.

### NoxTD 1.0.2a Nova
### Jan 28, 2025
- Fixed a bug with Lightning Orb cooldown.
- Ability Frequencies have been moved to the Abilities' general info.

## NoxTD 1.0.2 Nova
### Jan 16, 2025
- Added various Ability-related stats to both the Battle Stats and Savefile Stats menus.
- Added a sound for the Lightning Orb launch.

## NoxTD 1.0.1 Nova
### Jan 1, 2025
- Added the Lightning Orb and Jerelo's Blessing abilities.
- Fixed some Abilities crashing the game upon enhancing from level 0.
- Added the Nova tower appearance.

# NoxTD 1.0 Nova
### Dec 12, 2024
- Added 5 Abilities: Spiked Crystals, Scatter Fire, Burst Fire, Rainforest and Magma Touch.
    - Spiked Crystals spawn explosive crystals which deal high AoE damage.
    - Scatter Fire simultaneously shoots a number of projectiles in a random position on the screen.
    - Burst Fire simultaneously shoots a number of projectiles from the tower.
    - Rainforest slows enemy movement and attack speed if they are in range.
    - Magma Touch spawns a magma pool which deals burning damage.
- Added sounds for most battle events, such as tower firing, enemy kills, crystal explosions, tower collapsing, taking/absorbing damage.
- Resistance upgrades go up to 75% (90% before), Crit Chance upgrades go up to 15% (50% before) and Crit Factor upgrades go up to x10.
- Added particles as a trail for Meteors.

## NoxTD: Update Eclipse **B**
### Nov 10, 2024
- Added the Gameplay Info, Battle Stats and Savefile Stats menus.
- Renamed "Special Abilities" to "Gameplay Modifiers".
- Added the Hyperloop Gameplay Modifier.
- Enemy health and damage growth is slower on Levels α and β.

## NoxTD: Update Eclipse **A**
### Nov 04, 2024

- Enemies have been modified to have more rapid health and attack damage growth.
- Enemy cap and enemy spawn rate grow slower the higher the wave.
- Attack Speed and Range upgrades go to levels 106 and 81 instead of 101 and 61 respectively.
- Electrum alloying requires 400 Silver and 2 Gold instead of 160 Silver and 2 Gold.
- Slightly changed particle behaviour.
- The Regeneration upgrades scale differently.
- Sentries do not ignore the Shield and Centurions do not ignore Resistance anymore.
- Automatic color adjustment (for the tower info and enemy info panels) based on current background.

# NoxTD: Update Eclipse
### Oct 29, 2024
- Almost all of the variables are stored in a table, including timers and enemy attributes.
- Upgrade modules and Tooltips are stored as objects instead of being processed individually. Upgrade modules can also have custom sizes for both the buy button and the module itself.
- Moved all the tower displays into a separate file.
- Wave Skip Chance starts at 5% and goes up to 65% (+6% per level).
- Added the Eclipse Tower appearances.
