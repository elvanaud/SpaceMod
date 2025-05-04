local bob_coefficient = 10
local researchCost = settings.startup["SpaceX-research"].value
if researchCost == nil then
  researchCost = 1
end

local SpaceXTechs = {
  "space-assembly",
  "space-construction",
  "space-casings",
  "protection-fields",
  "fusion-reactor",
  "space-thrusters",
  "fuel-cells",
  "habitation",
  "life-support-systems",
  "spaceship-command",
  "astrometrics",
  "ftl-theory-A",
  "ftl-theory-B",
  "ftl-theory-C",
  "ftl-theory-D1",
  "ftl-theory-D2",
  "ftl-propulsion",
}

if bobmods.tech and bobmods.tech.advanced_logistic_science then
  table.insert(SpaceXTechs, "ftl-theory-D")

  data:extend({
    {
      type = "technology",
      name = "ftl-theory-D",
      icon = "__SpaceMod__/graphics/technology/ftl.png",  
      icon_size = 128,
      prerequisites = {"ftl-theory-C"},
      unit =
        {
          count = 200000 * researchCost,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"bob-advanced-logistic-science-pack", 1},
          },
          time = 60
        },
      order = "k-o-a"
    }
  })

  bobmods.lib.tech.add_science_pack("space-assembly", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("space-construction", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("space-casings", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("protection-fields", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("fusion-reactor", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("space-thrusters", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("fuel-cells", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("habitation", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("life-support-systems", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("spaceship-command", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("astrometrics", "bob-advanced-logistic-science-pack", 1)
  bobmods.lib.tech.add_science_pack("ftl-propulsion", "bob-advanced-logistic-science-pack", 1)


  data.raw.technology["ftl-theory-A"].unit.count = 200000 * researchCost
  data.raw.technology["ftl-theory-B"].unit.count = 200000 * researchCost
  data.raw.technology["ftl-theory-C"].unit.count = 200000 * researchCost
  data.raw.technology["ftl-theory-D1"].unit.count = 200000 * researchCost
  data.raw.technology["ftl-theory-D2"].unit.count = 200000 * researchCost
  data.raw.technology["ftl-propulsion"].unit.count = 200000 * researchCost

  bobmods.lib.tech.replace_prerequisite("ftl-theory-D1", "ftl-theory-C", "ftl-theory-D")
  bobmods.lib.tech.replace_prerequisite("ftl-theory-D2", "ftl-theory-C", "ftl-theory-D")

end

bobmods.lib.tech.add_prerequisite("space-assembly", "bob-robots-3")

if bobmods.modules.EnableGodModules == true then
  bobmods.lib.tech.add_prerequisite("space-assembly", "god-module-5")
--    data.raw.technology["space-assembly"].prerequisites = {"god-module-5","rocket-silo","bob-robots-3"}
else
  bobmods.lib.tech.add_prerequisite("space-assembly", "bob-speed-module-5")
  bobmods.lib.tech.add_prerequisite("space-assembly", "bob-efficiency-module-5")
--    data.raw.technology["space-assembly"].prerequisites = {"bob-speed-module-5","bob-efficiency-module-5","rocket-silo","bob-robots-3"}
  bobmods.lib.tech.add_prerequisite("ftl-propulsion", "bob-productivity-module-5")
--    data.raw.technology["ftl-propulsion"].prerequisites = {"bob-productivity-module-5","ftl-theory-D"}  
end

bobmods.lib.tech.add_prerequisite("space-construction", "bob-robo-modular-4")
-- data.raw.technology["space-construction"].prerequisites = {"space-assembly","bob-robo-modular-4"}
bobmods.lib.tech.add_prerequisite("protection-fields", "bob-energy-shield-equipment-6")
-- data.raw.technology["protection-fields"].prerequisites = {"space-construction","energy-shield-equipment-6"}
bobmods.lib.tech.add_prerequisite("fusion-reactor", "bob-fission-reactor-equipment-4")
-- data.raw.technology["fusion-reactor"].prerequisites = {"space-construction","bob-fission-reactor-equipment-4"}

bobmods.lib.tech.add_prerequisite("rocket-silo", "bob-titanium-processing")
bobmods.lib.tech.add_prerequisite("rocket-silo", "bob-nitinol-processing")
bobmods.lib.tech.add_prerequisite("rocket-silo", "bob-electric-energy-accumulators-3")
bobmods.lib.tech.add_prerequisite("rocket-silo", "bob-solar-energy-3")
bobmods.lib.tech.add_prerequisite("rocket-silo", "bob-advanced-processing-unit")
-- bobmods.lib.tech.add_prerequisite("rocket-silo", "radars-4")

-- alternate protection field recipe enabler
bobmods.lib.tech.add_recipe_unlock("protection-fields", "protection-field-goopless")

-- Nerf Bob's end game
for i, tech in pairs(SpaceXTechs) do
  local rootTech = data.raw.technology[tech]
  if rootTech ~= nil then
    rootTech.unit.count = rootTech.unit.count * bob_coefficient
  end
end
