if not bobmods.modules then bobmods.modules = {} end

local productionCost = settings.startup["SpaceX-production"].value
if productionCost == nil then
	productionCost = 1
end

data:extend({
    {
    type = "recipe",
    name = "protection-field-goopless",
    enabled = false,
	  energy_required = 100,
    ingredients =
    {
	  {type = "item", name = "bob-energy-shield-mk3-equipment", amount = 1000 * productionCost},
	  {type = "item", name = "bob-advanced-processing-unit", amount = 3500 * productionCost},
	  {type = "item", name = "efficiency-module-3", amount = 400 * productionCost},
	  {type = "item", name = "productivity-module-3", amount = 400 * productionCost},
	  {type = "item", name = "bob-efficiency-module-4", amount = 200 * productionCost},
	  {type = "item", name = "bob-productivity-module-4", amount = 200 * productionCost},
	  {type = "item", name = "bob-efficiency-module-5", amount = 100 * productionCost},
	  {type = "item", name = "bob-productivity-module-5", amount = 100 * productionCost},
    },
    results = {{ type = "item", name = "protection-field", amount = 1 }}
  }
}) 

if bobmods.modules.EnableGodModules == true then
  -- assembly-robot
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "speed-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "efficiency-module-3", "bob-god-module") 
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "construction-robot", "bob-construction-robot-4")    
--  data.raw.recipe["assembly-robot"].ingredients = {{"bob-god-module",2},{"bob-construction-robot-4",5},{"low-density-structure",5}}
  -- space-thruster
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "speed-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "pipe", "bob-titanium-pipe")  
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "processing-unit", "bob-advanced-processing-unit")  
--  data.raw.recipe["space-thruster"].ingredients = {{"bob-god-module",50},{"bob-titanium-pipe",100},{"bob-advanced-processing-unit",100},{"electric-engine-unit", 100},{"low-density-structure",100}}
  -- life-support
  bobmods.lib.recipe.replace_ingredient ("life-support", "productivity-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("life-support", "pipe", "bob-titanium-pipe")
  bobmods.lib.recipe.replace_ingredient ("life-support", "processing-unit", "bob-advanced-processing-unit")   
--  data.raw.recipe["life-support"].ingredients = {{"bob-god-module",50},{"bob-titanium-pipe",200},{"bob-advanced-processing-unit",100},{"low-density-structure",100}}
  -- command
  bobmods.lib.recipe.replace_ingredient ("command", "speed-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("command", "efficiency-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("command", "productivity-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("command", "processing-unit", "bob-advanced-processing-unit")   
--  data.raw.recipe["command"].ingredients = {{"bob-god-module",150},{"bob-advanced-processing-unit",100},{"plastic-bar", 200},{"low-density-structure",100}}
  -- astrometrics
  bobmods.lib.recipe.replace_ingredient ("astrometrics", "speed-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("astrometrics", "processing-unit", "bob-advanced-processing-unit") 
--  data.raw.recipe["astrometrics"].ingredients = {{"bob-god-module",50},{"bob-advanced-processing-unit",300},{"low-density-structure",100}}
  -- ftl-drive
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "speed-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "efficiency-module-3", "bob-god-module")  
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "productivity-module-3", "bob-god-module")
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "processing-unit", "bob-advanced-processing-unit")    
--  data.raw.recipe["ftl-drive"].ingredients = {{"bob-god-module",1500},{"bob-advanced-processing-unit",500},{"low-density-structure",100}}
else
  -- assembly-robot
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "speed-module-3", "bob-speed-module-5")
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "efficiency-module-3", "bob-efficiency-module-5")
  bobmods.lib.recipe.replace_ingredient ("assembly-robot", "construction-robot", "bob-construction-robot-4")
  -- space-thruster
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "speed-module-3", "bob-speed-module-5")
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "pipe", "bob-titanium-pipe")
  bobmods.lib.recipe.replace_ingredient ("space-thruster", "processing-unit", "bob-advanced-processing-unit")
  
  
--  data.raw.recipe["space-thruster"].ingredients = {{"bob-speed-module-5",50},{"bob-titanium-pipe",100},{"bob-advanced-processing-unit",100},{"electric-engine-unit", 100},{"low-density-structure",100}}
  -- life-support
  bobmods.lib.recipe.replace_ingredient ("life-support", "productivity-module-3", "bob-productivity-module-5")
  bobmods.lib.recipe.replace_ingredient ("life-support", "pipe", "bob-titanium-pipe")
  bobmods.lib.recipe.replace_ingredient ("life-support", "processing-unit", "bob-advanced-processing-unit")

--  data.raw.recipe["life-support"].ingredients = {{"bob-productivity-module-5",50},{"bob-titanium-pipe",200},{"bob-advanced-processing-unit",100},{"low-density-structure",100}}
  -- command
  bobmods.lib.recipe.replace_ingredient ("command", "speed-module-3", "bob-speed-module-5")
  bobmods.lib.recipe.replace_ingredient ("command", "efficiency-module-3", "bob-efficiency-module-5")
  bobmods.lib.recipe.replace_ingredient ("command", "productivity-module-3", "bob-productivity-module-5")
  bobmods.lib.recipe.replace_ingredient ("command", "processing-unit", "bob-advanced-processing-unit")
  
--  data.raw.recipe["command"].ingredients = {{"bob-speed-module-5",50},{"bob-efficiency-module-5",50},{"bob-productivity-module-5", 50},{"bob-advanced-processing-unit",100},{"plastic-bar", 200},{"low-density-structure",100}}
  -- astrometrics
  bobmods.lib.recipe.replace_ingredient ("astrometrics", "speed-module-3", "bob-speed-module-5")
  bobmods.lib.recipe.replace_ingredient ("astrometrics", "processing-unit", "bob-advanced-processing-unit") 
  
--  data.raw.recipe["astrometrics"].ingredients = {{"bob-speed-module-5",50},{"bob-advanced-processing-unit",300},{"low-density-structure",100}}
  -- ftl-drive
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "speed-module-3", "bob-speed-module-5")
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "efficiency-module-3", "bob-efficiency-module-5")
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "productivity-module-3", "bob-productivity-module-5")
  bobmods.lib.recipe.replace_ingredient ("ftl-drive", "processing-unit", "bob-advanced-processing-unit")
--  data.raw.recipe["ftl-drive"].ingredients = {{"bob-speed-module-5",500},{"bob-efficiency-module-5",500},{"bob-productivity-module-5", 500},{"bob-advanced-processing-unit",500},{"low-density-structure",100}}
end

-- drydock-assembly
  bobmods.lib.recipe.replace_ingredient ("drydock-assembly", "solar-panel", "bob-solar-panel-large-3")
  bobmods.lib.recipe.replace_ingredient ("drydock-assembly", "roboport", "bob-roboport-4")
  bobmods.lib.recipe.replace_ingredient ("drydock-assembly", "processing-unit", "bob-advanced-processing-unit")
-- data.raw.recipe["drydock-assembly"].ingredients = {{"assembly-robot",50},{"bob-roboport-4",10},{"bob-advanced-processing-unit",200},{"bob-solar-panel-large-3",200},{"low-density-structure", 100}}
  -- fusion-reactor
  bobmods.lib.recipe.replace_ingredient ("fusion-reactor", "fission-reactor-equipment", "bob-fission-reactor-equipment-4")
--data.raw.recipe["fusion-reactor"].ingredients = {{"bob-fission-reactor-equipment-4",100}}
  -- hull-component
  bobmods.lib.recipe.replace_ingredient ("hull-component", "steel-plate", "bob-titanium-plate")
--data.raw.recipe["hull-component"].ingredients = {{"low-density-structure", 250},{"bob-titanium-plate", 100}}
  -- protection-field
  bobmods.lib.recipe.replace_ingredient ("protection-field", "energy-shield-mk2-equipment", "bob-energy-shield-mk6-equipment")
-- data.raw.recipe["protection-field"].ingredients = {{"bob-energy-shield-mk6-equipment",100}}
  -- fuel-cell
  bobmods.lib.recipe.replace_ingredient ("fuel-cell", "steel-plate", "bob-titanium-plate")
  bobmods.lib.recipe.replace_ingredient ("fuel-cell", "processing-unit", "bob-advanced-processing-unit")
-- data.raw.recipe["fuel-cell"].ingredients = {{"low-density-structure", 100},{"bob-titanium-plate", 100},{"rocket-fuel", 500},{"bob-advanced-processing-unit",100}}
  -- habitation
  bobmods.lib.recipe.replace_ingredient ("habitation", "steel-plate", "bob-titanium-plate")
  bobmods.lib.recipe.replace_ingredient ("habitation", "processing-unit", "bob-advanced-processing-unit")
-- data.raw.recipe["habitation"].ingredients = {{"low-density-structure", 100},{"bob-titanium-plate", 100},{"plastic-bar", 500},{"bob-advanced-processing-unit",100}}
  -- low-density-structure
  bobmods.lib.recipe.replace_ingredient ("low-density-structure", "steel-plate", "bob-titanium-plate")
  bobmods.lib.recipe.replace_ingredient ("low-density-structure", "copper-plate", "bob-nitinol-alloy")
-- data.raw.recipe["low-density-structure"].ingredients = {{"bob-titanium-plate", 30},{"plastic-bar", 5},{"bob-nitinol-alloy",5}}
  -- satellite
  bobmods.lib.recipe.replace_ingredient ("satellite", "accumulator", "bob-large-accumulator-3")
  bobmods.lib.recipe.replace_ingredient ("satellite", "solar-panel", "bob-solar-panel-large-3")
  bobmods.lib.recipe.replace_ingredient ("satellite", "processing-unit", "bob-advanced-processing-unit")
  bobmods.lib.recipe.replace_ingredient ("satellite", "radar", "bob-radar-5")
