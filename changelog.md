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
- Added particles as a trail for Meteors, hit text particles don't show up when the Particles setting is set to None (x0.00).

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