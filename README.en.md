# Water from Waste Plastic — 0.7.1

If plastic is made of elements like carbon, hydrogen, and oxygen, shouldn't it be possible to obtain water from it?

This mod expands the vanilla chemistry system with new laboratory equipment and chemical reagents, including beakers, distillation apparatus, and laboratory spatulas.

Process plastic waste into water through heating, distillation, filtration, salting-out, and solvent extraction. You can also experiment with the game's existing water purification mechanics to discover alternative methods.

Is spending all those resources just to produce a little water really worth it? Maybe not economically, but it's certainly an interesting chemistry experiment.

Simplified and Traditional Chinese locales use the existing Chinese text. Every other locale uses English. After changing the game language, reload your save to refresh existing items and machine controls. The hexane bottle description remains blank.

## Playing

- Get a beaker, spatula and distillation unit from the retired chemist. The beaker is guaranteed; the distiller has a 50% stocking chance. A chemist start or the retired chemist equipment service also grants a beaker and spatula.
- Opening common chemical supplies adds one bottle of salt and one bottle of hexane to the original contents.
- Drag an owned empty plastic bottle into a dry beaker. Standard/large/mini/small water bottles yield 5/8/1/3mL of plastic; a jug yields 20mL. Empty alcohol, lipobond, acid, base, hexane and salt bottles yield 1mL.
- Heat the plastic above 70 degrees C for three in-game seconds to soften it. Put the softened plastic beaker in the unit's input slot and an empty beaker in its output slot, then choose Heat.
- Use the native filtration tools and inspect the mixture with scanners or a water test strip. Water testing requires actual water; the composition scanner also reads solids.
- Benzene yield is randomized between 7.00% and 8.00% of the plastic volume. Distillation needs at least as much actual hexane as benzene to remove benzene. Temporary removal is 75% without salt and 100% with at least 1mL added salt.
- Distillation collects all water, carries over 30% of the chemical contaminant amount and any untreated benzene, and clears other input residue.
- Pour a salt bottle to transfer all that fits; a spatula handles at most 1mL. Dry salt can be poured back. Empty salt and hexane bottles can store liquids or solid salt.
- At lower-level reputation 20 and with the retired chemist unlocked, a handwritten note arrives at the next day's opening, once per save.

## Updating and validation

Back up your mod and save. Replace the DLL and manifest, retaining your distillation-settings.json and textures. The mod ID remains plastic_water_chemistry for save compatibility.

Build, chemistry/story rules, locale routing, English-resource coverage and the native mod scan passed. English UI layout has not been tested in-game. The release build excludes item-spawn buttons and all runtime self-test code. Developers can opt in with build.ps1 -DeveloperTools; do not upload that build.

## Credits

Code: ChatGPT
Tireless tester: 八尾星風
Special thanks: 拉挖稀
https://www.bilibili.com/video/BV1HTY76MEvV/

