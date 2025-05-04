local productionCost = settings.startup["SpaceX-production"].value
if productionCost == nil then
	productionCost = 1
end

local cheapFusion = settings.startup["SpaceX-cheaper-fusion-reactor"].value

data:extend({
  {
    type = "recipe",
    name = "assembly-robot",
    enabled = false,
	  energy_required = 10,
    ingredients =
    {
      {"construction-robot", 5},
      {"speed-module-3", 1},
      {"efficiency-module-3", 1 },
	    {"low-density-structure", 5}
    },
    results = {{type = "item", name = "assembly-robot", amount = 1}}
  },
  {
    type = "recipe",
    name = "drydock-assembly",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"assembly-robot", 50 * productionCost},
      {"roboport", 10 * productionCost},
      {"processing-unit", 200 * productionCost},
	    {"solar-panel", 200 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "drydock-assembly", amount = 1}}
  },
  {
    type = "recipe",
    name = "drydock-structural",
    enabled = false,
	  energy_required = 50,
    ingredients =
    {
	  {"low-density-structure", 200 * productionCost}
    },
    results = {{type = "item", name = "drydock-structural", amount = 1}}
  },  
  {
    type = "recipe",
    name = "fusion-reactor",
    enabled = false,
	  energy_required = 100,
    ingredients =
    {
	  {"fission-reactor-equipment", 100 * productionCost} -- TODO: either rename everything 'fission' or re introduce fusion-reactor-equipment
    },
    results = {{type = "item", name = "fusion-reactor", amount = 1}}
  },
  {
    type = "recipe",
    name = "hull-component",
    enabled = false,
	  energy_required = 50,
    ingredients =
    {
	  {"low-density-structure", 250 * productionCost},
	  {"steel-plate", 100 * productionCost}
    },
    results = {{type = "item", name = "hull-component", amount = 1}}
  },  
  {
    type = "recipe",
    name = "protection-field",
    enabled = false,
	  energy_required = 100,
    ingredients =
    {
	  {"energy-shield-mk2-equipment", 100 * productionCost}
    },
    results = {{type = "item", name = "protection-field", amount = 1}}
  }, 
  {
    type = "recipe",
    name = "space-thruster",
    enabled = false,
	  energy_required = 50,
    ingredients =
    {
      {"speed-module-3", 50 * productionCost},
      {"pipe", 100 * productionCost},
      {"processing-unit", 100 * productionCost},
	    {"electric-engine-unit", 100 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "space-thruster", amount = 1}}
  },  
  {
    type = "recipe",
    name = "fuel-cell",
    enabled = false,
	  energy_required = 50,
    ingredients =
    {
      {"steel-plate", 100 * productionCost},
      {"rocket-fuel", 500 * productionCost},
      {"processing-unit", 100 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "fuel-cell", amount = 1}}
  },   
  {
    type = "recipe",
    name = "habitation",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"steel-plate", 100 * productionCost},
      {"plastic-bar", 500 * productionCost},
      {"processing-unit", 100 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "habitation", amount = 1}}
  }, 
  {
    type = "recipe",
    name = "life-support",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"productivity-module-3", 50 * productionCost},
      {"pipe", 200 * productionCost},
      {"processing-unit", 100 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "life-support", amount = 1}}
  }, 
  {
    type = "recipe",
    name = "command",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"speed-module-3", 50 * productionCost},
	    {"efficiency-module-3", 50 * productionCost},
	    {"productivity-module-3", 50 * productionCost},
      {"plastic-bar", 200 * productionCost},
      {"processing-unit", 100 * productionCost},
	    {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "command", amount = 1}}
  },   
  {
    type = "recipe",
    name = "astrometrics",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"speed-module-3", 50 * productionCost},
      {"processing-unit", 300 * productionCost},
	  {"low-density-structure", 100 * productionCost}
    },
    results = {{type = "item", name = "astrometrics", amount = 1}}
  }, 
  {
    type = "recipe",
    name = "ftl-drive",
    enabled = false,
	energy_required = 50,
    ingredients =
    {
      {"productivity-module-3", 500 * productionCost},
      {"speed-module-3", 500 * productionCost},
      {"efficiency-module-3", 500 * productionCost},
	    {"low-density-structure", 100 * productionCost},
	    {"processing-unit", 500 * productionCost}
    },
    results = {{type = "item", name = "ftl-drive", amount = 1}}
  },
  {
	type = "recipe",
	name = "spacex-combinator",
	enabled = false,
	energy_required = 5,
	ingredients =
	{
		{"copper-cable", 5},
		{"electronic-circuit", 5},
		{"advanced-circuit", 1}
	},
	results = {{type = "item", name = "spacex-combinator", amount = 1}}
  },  
})

local fix = data.raw.recipe["fusion-reactor"]
if cheapFusion == true then
	fix.ingredients =
		{
		{"fission-reactor-equipment", 40*productionCost}
		}
end