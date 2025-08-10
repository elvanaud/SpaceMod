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
      {type = "item", name = "construction-robot", amount = 5},
      {type = "item", name = "speed-module-3", amount = 1},
      {type = "item", name = "efficiency-module-3", amount = 1 },
	    {type = "item", name = "low-density-structure", amount = 5}
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
      {type = "item", name = "assembly-robot", amount = 50 * productionCost},
      {type = "item", name = "roboport", amount = 10 * productionCost},
      {type = "item", name = "processing-unit", amount = 200 * productionCost},
	    {type = "item", name = "solar-panel", amount = 200 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
	  {type = "item", name = "low-density-structure", amount = 200 * productionCost}
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
	  {type = "item", name = "fission-reactor-equipment", amount = 100 * productionCost} -- TODO: either rename everything 'fission' or re introduce fusion-reactor-equipment
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
	  {type = "item", name = "low-density-structure", amount = 250 * productionCost},
	  {type = "item", name = "steel-plate", amount = 100 * productionCost}
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
	  {type = "item", name = "energy-shield-mk2-equipment", amount = 100 * productionCost}
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
      {type = "item", name = "speed-module-3", amount = 50 * productionCost},
      {type = "item", name = "pipe", amount = 100 * productionCost},
      {type = "item", name = "processing-unit", amount = 100 * productionCost},
	    {type = "item", name = "electric-engine-unit", amount = 100 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "steel-plate", amount = 100 * productionCost},
      {type = "item", name = "rocket-fuel", amount = 500 * productionCost},
      {type = "item", name = "processing-unit", amount = 100 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "steel-plate", amount = 100 * productionCost},
      {type = "item", name = "plastic-bar", amount = 500 * productionCost},
      {type = "item", name = "processing-unit", amount = 100 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "productivity-module-3", amount = 50 * productionCost},
      {type = "item", name = "pipe", amount = 200 * productionCost},
      {type = "item", name = "processing-unit", amount = 100 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "speed-module-3", amount = 50 * productionCost},
	    {type = "item", name = "efficiency-module-3", amount = 50 * productionCost},
	    {type = "item", name = "productivity-module-3", amount = 50 * productionCost},
      {type = "item", name = "plastic-bar", amount = 200 * productionCost},
      {type = "item", name = "processing-unit", amount = 100 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "speed-module-3", amount = 50 * productionCost},
      {type = "item", name = "processing-unit", amount = 300 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost}
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
      {type = "item", name = "productivity-module-3", amount = 500 * productionCost},
      {type = "item", name = "speed-module-3", amount = 500 * productionCost},
      {type = "item", name = "efficiency-module-3", amount = 500 * productionCost},
	    {type = "item", name = "low-density-structure", amount = 100 * productionCost},
	    {type = "item", name = "processing-unit", amount = 500 * productionCost}
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
		{type = "item", name = "copper-cable", amount = 5},
		{type = "item", name = "electronic-circuit", amount = 5},
		{type = "item", name = "advanced-circuit", amount = 1}
	},
	results = {{type = "item", name = "spacex-combinator", amount = 1}}
  },  
})

local fix = data.raw.recipe["fusion-reactor"]
if cheapFusion == true then
	fix.ingredients =
		{
		{type = "item", name = "fission-reactor-equipment", amount = 40*productionCost}
		}
end