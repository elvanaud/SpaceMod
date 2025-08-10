require ("util")
local mod_gui = require ("mod-gui")


MOD_NAME = "SpaceMod"

--global = global or {}

local function glob_init()
  storage = storage or {}
  if storage.launchMult == nil then
		storage.launchProfile = settings.startup["SpaceX-launch-profile"].value
		if storage.launchProfile == "Classic" then
			storage.launchMult = 1
		elseif storage.launchProfile == "Launch Mania(x5)" then
			storage.launchMult = 5
		elseif storage.launchProfile == "Launch Meglo-mania(x25)" then
			storage.launchMult = 25
		else
			storage.launchMult = 1
		end
	
	end
	
	local launchMult = storage.launchMult
	spaceshiprequirements = {
	   satellite = 7 * launchMult,
	   drydockstructure = 10 * launchMult,
	   drydockcommand = 2 * launchMult,
	   shipcasings = 10 * launchMult,
	   shipthrusters = 4 * launchMult,
	   shiptprotectionfield = 1 * launchMult,
	   shipfusionreactor = 1 * launchMult,
	   shipfuelcells = 2 * launchMult,
	   shiphabitation = 1 * launchMult,
	   shiplifesupport = 1 * launchMult,
	   shipastrometrics = 1 * launchMult,
	   shipcommand = 1 * launchMult,
	   shipftldrive = 1 * launchMult
	   }
   
  storage.requirements = spaceshiprequirements
  if storage.launches == nil then
    storage.launches = {
      satellite = 0,
      drydockstructure = 0,
      drydockcommand = 0,
      shipcasings = 0,
      shipthrusters = 0,
      shiptprotectionfield = 0,
      shipfusionreactor = 0,
      shipfuelcells = 0,
      shiphabitation = 0,
      shiplifesupport = 0,
      shipastrometrics = 0,
      shipcommand = 0,
      shipftldrive = 0
	  }
	end
end

function debugp(text)
	-- for _, player in pairs(game.players) do
		-- player.print(text)
	-- end
end

local function gui_init(player, after_research)

	local button = mod_gui.get_button_flow(player).space_toggle_button
    if button then
	  if player.force.technologies["rocket-silo"].researched ~= true then
        button.destroy() 
	  end
      return	  
    end 

    if (player.force.technologies["rocket-silo"].researched or after_research) then

        -- player.gui.top.add{
		mod_gui.get_button_flow(player).add{
            type = "button",
            name = "space_toggle_button",
			style = mod_gui.button_style,
            caption = {"space-toggle-button-caption"}
        }
		
    end

end

local function on_player_created(event)
  gui_init(game.players[event.player_index], false)
end


function gui_open_frame(player)

	local frame = mod_gui.get_frame_flow(player).space_progress_frame
	
	-- if frame then 
	if not frame then return end
	frame.clear()

    -- Now we can build the GUI.
	
	-- Launch history, if any
	if storage.spacex == nil then
	elseif storage.spacex > 0 then 
		local ltext = "Interstellar Launches: " .. storage.spacex
		local launch = frame.add{type = "table", name = "launch_info", column_count = 2, style = "SpaceMod_table_style"}
		launch.add{type = "label", caption = ltext, style = "caption_label"}
		launch.add{
            type = "button",
            name = "launch_log",
			style = mod_gui.button_style,
            caption = "Log",
			tooltip = {"spacex-log-tooltip"}
        }
	end
	
	local sat_title = frame.add{type = "label", caption = {"satellite-network-progress-title"}, style = "caption_label"}
	local satellite = frame.add{type = "table", name = "satellite", column_count = 2, style = "SpaceMod_table_style"}
	satellite.style.column_alignments[2] = "right"	
 --   satellite.add{type = "label", caption = "-Satellites launched : "}
	satellite.add{type = "label", caption = {"SpaceX-Progress.satellites"} }
	satellite.add{type = "label", caption = " : " .. storage.launches.satellite .. "/" .. storage.requirements.satellite}
	

	-- Test for satellite network established condition
	if storage.launches.satellite < storage.requirements.satellite then
	  return
	end

--    drydock_frame_title(drydock)	
	local drydock_title = frame.add{type = "label", caption = {"drydock-progress-title"}, style = "caption_label"}
	local drydock = frame.add{type = "table", name = "drydock", column_count = 2, style = "SpaceMod_table_style"}
	drydock.style.column_alignments[2] = "right"
--	drydock.add{type = "label", caption = "-Drydock Structure Component : "}
	drydock.add{type = "label", caption = {"SpaceX-Progress.dsc"} }	
	drydock.add{type = "label", caption = " : " .. storage.launches.drydockstructure .. "/" .. storage.requirements.drydockstructure}
--	drydock.add{type = "label", caption = "-Drydock Assembly Component : "}
	drydock.add{type = "label", caption = {"SpaceX-Progress.dac"} }
	drydock.add{type = "label", caption = " : " .. storage.launches.drydockcommand .. "/" .. storage.requirements.drydockcommand}
	
	-- Test for drydock built condition
	if (storage.launches.drydockstructure < storage.requirements.drydockstructure or 
		storage.launches.drydockcommand < storage.requirements.drydockcommand) then
		return
	end
	
	local ship_title = frame.add{type = "label", caption = {"ship-progress-title"}, style = "caption_label"}
	local gui_ship = frame.add{type = "table", name = "ship", column_count = 2, style = "SpaceMod_table_style"}
	gui_ship.style.column_alignments[2] = "right"
--	gui_ship.add{type = "label", caption = "-Protection Field...... : "}
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.protection"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shiptprotectionfield .. "/" .. storage.requirements.shiptprotectionfield}
--	gui_ship.add{type = "label", caption = "-Fusion Reactor........ : "}
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.fusion"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipfusionreactor .. "/" .. storage.requirements.shipfusionreactor }
--	gui_ship.add{type = "label", caption = "-Habitation............... : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.habitation"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shiphabitation .. "/" .. storage.requirements.shiphabitation}
--	gui_ship.add{type = "label", caption = "-Life Support........... : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.life"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shiplifesupport .. "/" .. storage.requirements.shiplifesupport}
--	gui_ship.add{type = "label", caption = "-Astrometrics.......... : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.astro"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipastrometrics .. "/" .. storage.requirements.shipastrometrics}
--	gui_ship.add{type = "label", caption = "-Command................ : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.command"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipcommand .. "/" .. storage.requirements.shipcommand}
--	gui_ship.add{type = "label", caption = "-Fuel Cells............... : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.fuel"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipfuelcells .. "/" .. storage.requirements.shipfuelcells}
--	gui_ship.add{type = "label", caption = "-Thrusters.............. : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.thrusters"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipthrusters .. "/" .. storage.requirements.shipthrusters}
--	gui_ship.add{type = "label", caption = "-Hull components.. : "}	
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.hull"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipcasings .. "/" .. storage.requirements.shipcasings}
--	gui_ship.add{type = "label", caption = "-FTL drive............. : "}
	gui_ship.add{type = "label", caption = {"SpaceX-Progress.ftl"} }
	gui_ship.add{type = "label", caption = " : " .. storage.launches.shipftldrive .. "/" .. storage.requirements.shipftldrive}
	
end

local function better_victory_screen_disable_rocket_victory()
    if remote.interfaces["better-victory-screen"] and remote.interfaces["better-victory-screen"]["set_no_victory"] then
      remote.call("better-victory-screen", "set_no_victory", true)
    end
end

script.on_configuration_changed( function(event) 
  better_victory_screen_disable_rocket_victory()
  local changed = event.mod_changes and event.mod_changes["SpaceMod"]

  if changed then
	debugp("Processing mod change")
	storage.spacex_com = storage.spacex_com or {}
	for _,surface in pairs(game.surfaces) do
		debugp("Surface found")
		for _,spacexCom in pairs(surface.find_entities_filtered{type="constant-combinator", name="spacex-combinator"}) do
			debugp("Found an old spacex combinator")
			table.insert(storage.spacex_com, {entity = spacexCom})	
		end
	end   
		local status,err = pcall(function()

			if game.players ~= nil then
				for _, player in pairs(game.players) do
					local frame = player.gui.left["space-progress-frame"]
					if frame then
						frame.destroy()					
					end
					local button = player.gui.top["space-toggle-button"]
					if button then
						button.destroy()
					end
					gui_init(player, player.force.technologies["rocket-silo"].researched)

					player.print("Mod version changed processed")
				end
			end
			for _, force in pairs(game.forces) do
				if force.technologies["space-assembly"].researched then
					force.recipes["spacex-combinator"].enabled=true
				end
			end		
		end)
	end
end)

-- local function on_gui_click(event)

	
-- end
  
local function gui_open_spacex_launch_gui(player)
	local gui = mod_gui.get_frame_flow(player)
	local gui_spacex = gui.spacex_launch
		if gui_spacex then
			gui_spacex.destroy()
			return
		end
		gui_spacex = gui.add{
			type = "frame",
			name = "spacex_launch",
			direction = "vertical",
			style = mod_gui.frame_style
			}
	if not gui_spacex then return end
	gui_spacex.clear()
	local sub_title = gui_spacex.add{type = "label", caption = {"spacex-launch-title"}, style = "caption_label"}
	-- local sxtxt_table = gui_spacex.add{type = "table", name = "spacex_launchtxt_table", column_count = 1}
	gui_spacex.add{type = "label", caption = {"spacex-completion-text"}, style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = " ", style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = {"spacex-completion-text1"}, style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = " ", style = "Launch_label_style"}	
	gui_spacex.add{type = "label", caption = {"spacex-completion-text2"}, style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = " ", style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = {"spacex-completion-text3"}, style = "Launch_label_style"}
	gui_spacex.add{type = "label", caption = " ", style = "Launch_label_style"}	
	gui_spacex.add{type = "label", caption = {"spacex-completion-text4"}, style = "caption_label"}
	gui_spacex.add{type = "label", caption = " ", style = "Launch_label_style"}	
--	local sxtext = gui_spacex.add{type = "label", text = stext, style = "Launch_text_box_style"}
	if player.admin then
	local sctable = gui_spacex.add{type = "table", name = "spacex_launch_table", column_count = 2, style = "SpaceMod_table_style"}
	sctable.style.minimal_width = 400
	sctable.style.horizontally_stretchable = true
	sctable.style.column_alignments[2] = "right"
		sctable.add{
            type = "button",
            name = "bio_button",
			style = mod_gui.button_style,
            caption = "Yes, Bring it On!",
			tooltip = {"spacex-bio-tooltip"}
        }	
	local iwmm = sctable.add{
            type = "button",
            name = "iwmm_button",
			style = mod_gui.button_style,
            caption = "No, I want my mummy!",
			tooltip = {"spacex-iwmm-tooltip"}
        }
	else
		gui_spacex.add{
		    type = "button",
            name = "notadmin_button",
			style = mod_gui.button_style,
            caption = "Admins Choice!",
			tooltip = {"spacex-notadmin-tooltip"}
        }
	end
end	

local function get_launch_log()
	storage.launch_log = storage.launch_log or {}
	local seconds = 60
	local minutes = 60 * seconds
	local hours = 60 * minutes
	local days = 24 * hours
	
	local log_tick = game.tick
	local log_days = (log_tick - (log_tick % days)) / days 
	log_tick = log_tick - (log_days * days)
	local log_hours = (log_tick - (log_tick % hours)) / hours 
	log_tick = log_tick - (log_hours * hours)
	local log_minutes = (log_tick - (log_tick % minutes)) / minutes 
	log_tick = log_tick - (log_minutes * minutes)
	local log_seconds = (log_tick - (log_tick % seconds)) / seconds 
	log_entry = log_days .. " Days: " .. log_hours .. " Hours: " .. log_minutes .. " Minutes: " .. log_seconds .. " Seconds" 
	return log_entry
end

local function gui_log_open(player)
	local gui = mod_gui.get_frame_flow(player)
	local llog = gui.spacex_log
	local scroll = llog.add{type = "scroll-pane", name = "scroll"}
	scroll.style.maximal_height = 800	
	local logtable = scroll.add{type = "table", name = "spacex_log_table", column_count = 2, style = "SpaceMod_table_style"}
	for i,launch in pairs(storage.launch_log) do
		logtable.add{type = "label", caption = "#" .. i .. "- " .. launch.log, style = "Launch_label_style"}
		if player.admin then
			logtable.add{type = "textfield", name = "logdetail" .. i, enabled = true, text = launch.detail}
		else
			logtable.add{type = "textfield", name = "logdetail" .. i, enabled = false, text = launch.detail}
		end
	end
end

script.on_event(defines.events.on_gui_text_changed, function(event)
	local element = event.element
	local player = game.players[event.player_index]
	 
	if string.find(element.name, "logdetail") then
		if player.admin then
			local cur_log = tonumber(string.match(element.name, "%d+"))	
			storage.launch_log[cur_log].detail = element.text
		end
	end
		
end)

function createCombinatorFilter(name, amount)
  return {
	value = {
		type = name == "signal-S" and "virtual" or "item",
		name = name,
		quality = "normal",
		comparator = "="
	},
	min = amount,
	max = amount
  }
end

function get_spacex_cb(entity)
	if entity.valid == true then
	local cb = entity.get_or_create_control_behavior()
	-- cb.parameters = cb.parameters or {}
	local satellite = storage.requirements.satellite - storage.launches.satellite
	local dsc = storage.requirements.drydockstructure - storage.launches.drydockstructure
	local dac = storage.requirements.drydockcommand - storage.launches.drydockcommand
	local fusion = storage.requirements.shipfusionreactor - storage.launches.shipfusionreactor
	local fuelcell = storage.requirements.shipfuelcells - storage.launches.shipfuelcells
	local hull = storage.requirements.shipcasings - storage.launches.shipcasings
	local shield = storage.requirements.shiptprotectionfield - storage.launches.shiptprotectionfield
	local thruster = storage.requirements.shipthrusters - storage.launches.shipthrusters
	local habitation = storage.requirements.shiphabitation - storage.launches.shiphabitation
	local life = storage.requirements.shiplifesupport - storage.launches.shiplifesupport
	local command = storage.requirements.shipcommand - storage.launches.shipcommand
	local astro = storage.requirements.shipastrometrics - storage.launches.shipastrometrics
	local ftl = storage.requirements.shipftldrive - storage.launches.shipftldrive
	local params = nil
	
	cb.remove_section(1)
	if satellite > 0 then
		debugp("spacex satellite")
		section = cb.add_section()
		section.filters = {
			createCombinatorFilter("satellite", satellite),
			createCombinatorFilter("signal-S", 1)
		}	
	elseif (dsc > 0) or (dac > 0) then
		debugp("spacex drydock")
		section = cb.add_section()
		section.filters = {
			createCombinatorFilter("drydock-structural", dsc),
			createCombinatorFilter("drydock-assembly", dac),
			createCombinatorFilter("signal-S", 2),
		}		
	elseif (fusion > 0) or
			(fuelcell > 0) or
			(hull > 0) or
			(shield > 0) or
			(thruster > 0) or
			(habitation > 0) or
			(life > 0) or
			(command > 0) or
			(astro > 0) or
			(ftl > 0) then
		debugp("spacex endphase")
		section = cb.add_section()
		section.filters = {
			createCombinatorFilter("fusion-reactor", fusion),
			createCombinatorFilter("hull-component", hull),
			createCombinatorFilter("protection-field", shield),
			createCombinatorFilter("space-thruster", thruster),
			createCombinatorFilter("fuel-cell", fuelcell),
			createCombinatorFilter("habitation", habitation),
			createCombinatorFilter("life-support", life),
			createCombinatorFilter("command", command),
			createCombinatorFilter("astrometrics", astro),
			createCombinatorFilter("ftl-drive", ftl),
			createCombinatorFilter("signal-S", 3)
		}	
	else
		--cb.parameters = {}
	end
		
			-- cb.parameters = {parameters = {
			-- {
				-- signal = {
					-- type = "virtual",
					-- name = "train-counter"
				-- },
				-- count = traincount,
				-- index = 1
			-- }
		-- }}
	end
end

function remove_spacex_com(entity)
	for i, coms in ipairs(storage.spacex_com) do
		if coms.entity == entity then
			table.remove(storage.spacex_com, i)
			break
		end
	end	
end

script.on_event(defines.events.on_built_entity, function(event)
	if event.entity.name == "spacex-combinator" then
		debugp("Spacex combinator built")
		storage.spacex_com = storage.spacex_com or {}
		event.entity.operable = false
		table.insert(storage.spacex_com, {entity = event.entity})
		get_spacex_cb(event.entity)
	end
	-- if event.entity.name == "spacex-combinator" then
		-- debugp("inserting spacex combinator")
		-- table.insert(storage.spacex_com, {entity = event.entity})
	-- end
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
	if event.entity.name == "spacex-combinator" then
		debugp("Spacex combinator built")
		storage.spacex_com = storage.spacex_com or {}
		event.entity.operable = false
		table.insert(storage.spacex_com, {entity = event.entity})
		get_spacex_cb(event.entity)
	end
	-- if event.entity.name == "spacex-combinator" then
		-- table.insert(storage.spacex_com, {entity = event.entity})	
	-- end
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
	if event.entity.name == "spacex-combinator" then
		remove_spacex_com(event.entity)
	end
end)

script.on_event(defines.events.on_robot_pre_mined, function(event)
	if event.entity.name == "spacex-combinator" then
		remove_spacex_com(event.entity)
	end
end)

script.on_event(defines.events.on_entity_died, function(event)
	if event.entity.name == "spacex-combinator" then
		remove_spacex_com(event.entity)
	end
end)

local function updateSpacexCombinators(surface)
--	for _,spacexCom in pairs(surface.find_entities_filtered{type="constant-combinator", name="spacex-combinator"}) do
	storage.spacex_com = storage.spacex_com or {}
	if storage.spacex_com == {} then return end
	for _,spacexCom in pairs(storage.spacex_com) do
		debugp("spacex combinator found")
		get_spacex_cb(spacexCom.entity)
	end
end

local function spacex_continue(surface)
	storage.launches = nil
	glob_init()
	updateSpacexCombinators(surface)
	if storage.spacex == nil then storage.spacex = 0 end
	storage.spacex = storage.spacex + 1
	storage.launch_log = storage.launch_log or {}
	local launch_log = {log = get_launch_log(), detail = "?"}
	-- launch_log.detail = "?"
	table.insert(storage.launch_log, launch_log )
end	

script.on_event(defines.events.on_gui_click, function(event) 

    local element = event.element
    local player = game.players[event.player_index]
    local gui = mod_gui.get_frame_flow(player)
    local frame = gui.space_progress_frame
  	local gui_spacex = gui.spacex_launch
	local spacex_log = gui.spacex_log

    if element.name == "space_toggle_button" then
	    if frame then
			frame.destroy()
			return
		end
		frame = gui.add{
			type = "frame",
			name = "space_progress_frame",
			direction = "vertical",
			caption = {"space-progress-frame-title"},
			style = mod_gui.frame_style
		}		
        gui_open_frame(player)
		
    end
	
	if element.name == "bio_button" then
		for _, player in pairs(game.players) do
			-- Close every launch gui
			gui_open_spacex_launch_gui(player)
		end
		spacex_continue(player.surface, gui)
--[[ 		storage.launches = nil
		glob_init()
		updateSpacexCombinators(player.surface)
		if storage.spacex == nil then storage.spacex = 0 end
		storage.spacex = storage.spacex + 1
		storage.launch_log = storage.launch_log or {}
		local launch_log = {log = get_launch_log(), detail = "?"}
		-- launch_log.detail = "?"
		table.insert(storage.launch_log, launch_log ) ]]
		if frame then
			frame.destroy()
		end
		if gui_spacex then
			gui_spacex.destroy()
		end
		frame = gui.add{
			type = "frame",
			name = "space_progress_frame",
			direction = "vertical",
			caption = {"space-progress-frame-title"},
			style = mod_gui.frame_style
		}
        gui_open_frame(player)
		return
	end
	if element.name == "iwmm_button" then
		for _, player in pairs(game.players) do
			-- Close every launch gui
			gui_open_spacex_launch_gui(player)
		end
		if gui_spacex then
			gui_spacex.destroy()
		end

		local force = game.players[event.player_index].force
		if remote.interfaces["better-victory-screen"] and remote.interfaces["better-victory-screen"]["trigger_victory"] then
			remote.call("better-victory-screen", "trigger_victory", force, true)
		else
			game.set_game_state{game_finished=true, player_won=true, can_continue=true, victorious_force=force}
		end

		storage.finished = true
		return
	end	

	if element.name == "launch_log" then
		if spacex_log then
			spacex_log.destroy()
			return
		end
		log = gui.add{
					type = "frame",
					name = "spacex_log",
					direction = "vertical",
					caption = {"gui-log-title"},
					style = mod_gui.frame_style
		}
		gui_log_open(player)
	end
	
	if element.name == "gnc_button" then
		open_gnc_msg(player)
		return
	end		

	if element.name == "drydock_button" then
		open_drydock_msg(player)
		return
	end	

	if element.name == "notadmin_button" then
		gui_open_spacex_launch_gui(player)
		return
	end
	
--	if player.gui.left["rocket_score"] ~= nil then
--	  player.gui.left["rocket_score"].destroy()
--	end

end)

function open_gnc_msg(player)
	local gui = mod_gui.get_frame_flow(player)
	local gui_gnc = gui.gnc_msg
		if gui_gnc then
			gui_gnc.destroy()
			return
		end	
	gui_gnc = gui.add{
			type = "frame",
			name = "gnc_msg",
			direction = "vertical",
			caption = {"gnc-title"},
			style = mod_gui.frame_style
		}
	gui_gnc.add{type = "label", caption = {"satellite-network-text1"}, style = "Launch_label_style"}
	gui_gnc.add{type = "button",
            name = "gnc_button",
			style = mod_gui.button_style,
            caption = "Great!",
			tooltip = {"gnc-tooltip"}
        }	
end

function open_drydock_msg(player)
	local gui = mod_gui.get_frame_flow(player)
	local gui_drydock = gui.drydock_msg
		if gui_drydock then
			gui_drydock.destroy()
			return
		end	
	gui_drydock = gui.add{
			type = "frame",
			name = "drydock_msg",
			direction = "vertical",
			caption = {"drydock-title"},
			style = mod_gui.frame_style
		}
	gui_drydock.add{type = "label", caption = {"drydock-text1"}, style = "Launch_label_style"}
	gui_drydock.add{type = "button",
            name = "drydock_button",
			style = mod_gui.button_style,
            caption = "Awesome!",
			tooltip = {"drydock-tooltip"}
        }	
end

script.on_event(defines.events.on_research_finished, function(event)

    if event.research.name == 'rocket-silo' then
        for _, player in pairs(game.players) do
            gui_init(player, true)
        end
    end

end)

script.on_init(function()
	better_victory_screen_disable_rocket_victory()
    glob_init()

    for _, player in pairs(game.players) do
        gui_init(player, false)
    end
	
end)

-- script.on_event(defines.events.on_built_entity, function(event)
	-- if event.entity.name == "spacex-combinator" then
		-- debugp("Spacex combinator built")
		-- event.entity.operable = false
		-- get_spacex_cb(event.entity)
	-- end
-- end)

script.on_event(defines.events.on_player_created, on_player_created)


script.on_event(defines.events.on_rocket_launched, function(event)
  local status,err = pcall(function()
	remote.call("silo_script","set_show_launched_without_satellite", false)
	remote.call("silo_script","set_finish_on_launch", false)
  end)
  local force = event.rocket.force
  if event.rocket.cargo_pod.get_item_count("satellite") > 0 then
    if storage.launches.satellite < storage.requirements.satellite then
	  storage.launches.satellite = storage.launches.satellite + 1	
		if storage.launches.satellite == storage.requirements.satellite then

			for _, player in pairs(game.players) do
				player.print({"satellite-network-complete-msg"}) 
				if settings.global['SpaceX-no-popup'].value == false then
					open_gnc_msg(player)
				end
			end
		end	
		updateSpacexCombinators(event.rocket.surface)
	end
	game.set_game_state{game_finished=false, player_won=false, can_continue=true}	

--	for index, player in pairs(force.players) do
--		if player.gui.left["rocket_score"] ~= nil then
--			player.gui.left["rocket_score"].destroy()
--		end
--	end
	for _, player in pairs(game.players) do
		-- frame = player.gui.left["space-progress-frame"]
		local frame = mod_gui.get_frame_flow(player).space_progress_frame
		if frame then
			frame.clear()
			gui_open_frame(player)
		end
	end	

	return
  end
  
	if event.rocket.cargo_pod.get_item_count("drydock-structural") > 0 then
		if storage.launches.drydockstructure < storage.requirements.drydockstructure then
			storage.launches.drydockstructure = storage.launches.drydockstructure + 1
		end

	end
  
	if event.rocket.cargo_pod.get_item_count("drydock-assembly") > 0 then
		if storage.launches.drydockcommand < storage.requirements.drydockcommand then
			storage.launches.drydockcommand = storage.launches.drydockcommand + 1
		end

	end  

--	local condition = (ship == nil) and (storage.launches.drydockstructure = storage.requirements.drydockstructure) and (storage.launches.drydockcommand = globallaunches.drydockcommand)			
						
	if ((event.rocket.cargo_pod.get_item_count("drydock-structural") > 0 or event.rocket.cargo_pod.get_item_count("drydock-assembly") > 0) and
		storage.launches.drydockstructure == storage.requirements.drydockstructure and
		storage.launches.drydockcommand == storage.requirements.drydockcommand) then
		for _, player in pairs(game.players) do
			player.print({"drydock-complete-msg"}) 
			if settings.global['SpaceX-no-popup'].value == false then
				open_drydock_msg(player)
			end
			updateSpacexCombinators(event.rocket.surface)
		end
	end

	if event.rocket.cargo_pod.get_item_count("fusion-reactor") > 0 then
		if storage.launches.shipfusionreactor < storage.requirements.shipfusionreactor then
			storage.launches.shipfusionreactor = storage.launches.shipfusionreactor + 1
		end

	end  

	if event.rocket.cargo_pod.get_item_count("fuel-cell") > 0 then
		if storage.launches.shipfuelcells < storage.requirements.shipfuelcells then
			storage.launches.shipfuelcells = storage.launches.shipfuelcells + 1
		end

	end 	

	if event.rocket.cargo_pod.get_item_count("hull-component") > 0 then
		if storage.launches.shipcasings < storage.requirements.shipcasings then
			storage.launches.shipcasings = storage.launches.shipcasings + 1
		end

	end 

	if event.rocket.cargo_pod.get_item_count("protection-field") > 0 then
		if storage.launches.shiptprotectionfield < storage.requirements.shiptprotectionfield then
			storage.launches.shiptprotectionfield = storage.launches.shiptprotectionfield + 1
		end

	end 

	if event.rocket.cargo_pod.get_item_count("space-thruster") > 0 then
		if storage.launches.shipthrusters < storage.requirements.shipthrusters then
			storage.launches.shipthrusters = storage.launches.shipthrusters + 1
		end

	end 

	if event.rocket.cargo_pod.get_item_count("habitation") > 0 then
		if storage.launches.shiphabitation < storage.requirements.shiphabitation then
			storage.launches.shiphabitation = storage.launches.shiphabitation + 1
		end

	end

	if event.rocket.cargo_pod.get_item_count("life-support") > 0 then
		if storage.launches.shiplifesupport < storage.requirements.shiplifesupport then
			storage.launches.shiplifesupport = storage.launches.shiplifesupport + 1
		end

	end  

	if event.rocket.cargo_pod.get_item_count("command") > 0 then
		if storage.launches.shipcommand < storage.requirements.shipcommand then
			storage.launches.shipcommand = storage.launches.shipcommand + 1
		end

	end 

	if event.rocket.cargo_pod.get_item_count("astrometrics") > 0 then
		if storage.launches.shipastrometrics < storage.requirements.shipastrometrics then
			storage.launches.shipastrometrics = storage.launches.shipastrometrics + 1
		end

	end 

	if event.rocket.cargo_pod.get_item_count("ftl-drive") > 0 then
		if storage.launches.shipftldrive < storage.requirements.shipftldrive then
			storage.launches.shipftldrive = storage.launches.shipftldrive + 1
		end
	end  

	-- Test for victory condition
	storage.finished = storage.finished or false
	
	if  storage.launches.shipfusionreactor == storage.requirements.shipfusionreactor and
		storage.launches.shipcasings == storage.requirements.shipcasings and
		storage.launches.shiptprotectionfield == storage.requirements.shiptprotectionfield and
		storage.launches.shipthrusters == storage.requirements.shipthrusters and
		storage.launches.shiphabitation == storage.requirements.shiphabitation and
		storage.launches.shiplifesupport == storage.requirements.shiplifesupport and
		storage.launches.shipfuelcells == storage.requirements.shipfuelcells and
		storage.launches.shipcommand == storage.requirements.shipcommand and
		storage.launches.shipastrometrics == storage.requirements.shipastrometrics and
		storage.launches.shipftldrive == storage.requirements.shipftldrive and
		storage.finished == false then
		if settings.global['SpaceX-auto-continue'].value == false then
			for _, player in pairs(game.players) do
				player.print({"spaceship-complete-msg"})
				gui_open_spacex_launch_gui(player)
			end
		else
			spacex_continue(event.rocket.surface)
		end
		-- game.set_game_state{game_finished=true, player_won=true, can_continue=true}
		-- storage.finished = true
	end
	for _, player in pairs(game.players) do
		frame = mod_gui.get_frame_flow(player).space_progress_frame
		if frame then
			gui_open_frame(player)
		end
	end	
	updateSpacexCombinators(event.rocket.surface)
--	if (#game.players <= 1) then
--		ipc.keypress(9)
--	end
end)

commands.add_command("resetSpaceX", {"resetSpaceX_help"}, function(event)
	storage.finished = false
end)

commands.add_command("modlist", {"modlist_help"}, function(event)
	for name, version in pairs(script.active_mods) do
		game.player.print(name .. " version " .. version)
	end
end)

commands.add_command("spacex_settings", {"x_settings_help"}, function(event)
	game.player.print("research" .. settings.startup["SpaceX-research"].value)

end)

commands.add_command("Get_log_file", {"get log file help"}, function(event)
	helpers.write_file("spacex_log",serpent.block(storage.launch_log))--,{comment=false}) --TODO : what did this do ?
end)

commands.add_command("spacex_combinators", {"get spacex_combinator help"}, function(event)
	helpers.write_file("spacex_combinator",serpent.block(storage.spacex_com))--,{comment=false})
end)

--Cheat command
--[[ commands.add_command("SpaceX_complete_launch_cycle", {"SpaceX_cheat_help"}, function(event)
		storage.launches.satellite = storage.requirements.satellite
		storage.launches.drydockstructure = storage.requirements.drydockstructure 
		storage.launches.drydockcommand = storage.requirements.drydockcommand
	    storage.launches.shipfusionreactor = storage.requirements.shipfusionreactor
		storage.launches.shipcasings = storage.requirements.shipcasings 
		storage.launches.shiptprotectionfield = storage.requirements.shiptprotectionfield 
		storage.launches.shipthrusters = storage.requirements.shipthrusters 
		storage.launches.shiphabitation = storage.requirements.shiphabitation 
		storage.launches.shiplifesupport = storage.requirements.shiplifesupport 
		storage.launches.shipfuelcells = storage.requirements.shipfuelcells
		storage.launches.shipcommand = storage.requirements.shipcommand 
		storage.launches.shipastrometrics = storage.requirements.shipastrometrics 
		storage.launches.shipftldrive = storage.requirements.shipftldrive - 1
		updateSpacexCombinators(game.player.surface)
end)

commands.add_command("SpaceX_complete_satellite", {"SpaceX_cheat_sat_help"}, function(event)
	storage.launches.satellite = storage.requirements.satellite - 1
	updateSpacexCombinators(game.player.surface)
end)

commands.add_command("SpaceX_complete_drydock", {"SpaceX_cheat_dry_help"}, function(event)
	storage.launches.satellite = storage.requirements.satellite
	storage.launches.drydockstructure = storage.requirements.drydockstructure - 1
	storage.launches.drydockcommand = storage.requirements.drydockcommand
	updateSpacexCombinators(game.player.surface)
end) ]]