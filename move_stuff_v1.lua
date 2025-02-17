-- some spaghetti code by joope1
require("toriui/uielement")
require("system.menu_defines")
require("system.menu_manager")
require("system.mods_manager")

-- UI stuff
local header = UIElement:new({
    pos = { 1500, 0 },
    size = { 420, 40 },
	bgColor = TB_MENU_DEFAULT_DARKER_COLOR,
})

local title = UIElement:new({
	parent = header,
    pos = { 0, 0 },
    size = { 250, 40 },
	interactive = true,
})
title:addAdaptedText(false, "Mod Group Controls")
title:addMouseHandlers(nil, function()
	toggleWindow()
end)

local x = UIElement:new({
	parent = header,
    pos = { 380, 5 },
    size = { 35, 30 },
	bgColor = TB_MENU_DEFAULT_BG_COLOR,
	hoverColor = TB_MENU_DEFAULT_LIGHTER_COLOR,
	shapeType = ROUNDED,
	rounded = 5,
	interactive = true,
})
x:addAdaptedText(false, "x")
x:addMouseHandlers(nil, function()
	killAll()
end)

local window = UIElement:new({
    pos = { 1500, 40 },
    size = { 420, 295 },
    bgColor = TB_MENU_DEFAULT_BG_COLOR,
})

local start_id_label = UIElement:new({
    parent = window,
    pos = { 10, 10 },
    size = { 150, 30 },
})
start_id_label:addAdaptedText(false, "Start Object ID:")

local start_index_input_holder = UIElement:new({
    parent = window,
    pos = { 170, 10 },
    size = { 150, 30 },
	interactive = true,
	textfield = true,
})
local start_index_input = TBMenu:spawnTextField2(start_index_input_holder, start_index_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false,
})

local start_id_label = UIElement:new({
    parent = window,
    pos = { 10, 50 },
    size = { 150, 30 },
})
start_id_label:addAdaptedText(false, "End Object ID:")

local end_index_input_holder = UIElement:new({
    parent = window,
    pos = { 170, 50 },
    size = { 150, 30 },
	interactive = true,
	textfield = true,
})
local end_index_input = TBMenu:spawnTextField2(end_index_input_holder, end_index_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false,
})

local move_sect_label = UIElement:new({
    parent = window,
    pos = { 10, 90 },
    size = { 150, 30 },
})
move_sect_label:addAdaptedText(false, "Offset values")

local offset_x_label = UIElement:new({
    parent = window,
    pos = { 10, 130 },
    size = { 100, 30 },
})
offset_x_label:addAdaptedText(false, "Offset X:")

local offset_x_input_holder = UIElement:new({
    parent = window,
    pos = { 170, 130 },
    size = { 150, 30 },
	interactive = true,
	textfield = true,
})
local offset_x_input = TBMenu:spawnTextField2(offset_x_input_holder, offset_x_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	allowDecimal = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT 
})

local offset_y_label = UIElement:new({
    parent = window,
    pos = { 10, 170 },
    size = { 100, 30 },
})
offset_y_label:addAdaptedText(false, "Offset Y:")

local offset_y_input_holder = UIElement:new({
    parent = window,
    pos = { 170, 170 },
    size = { 150, 30 },
	interactive = true,
	textfield = true,
})
local offset_y_input = TBMenu:spawnTextField2(offset_y_input_holder, offset_y_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	allowDecimal = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT 
})


local offset_z_label = UIElement:new({
    parent = window,
    pos = { 10, 210 },
    size = { 100, 30 },
})
offset_z_label:addAdaptedText(false, "Offset Z:")

local offset_z_input_holder = UIElement:new({
    parent = window,
    pos = { 170, 210 },
    size = { 150, 30 },
	interactive = true,
	textfield = true,
	
})
local offset_z_input = TBMenu:spawnTextField2(offset_z_input_holder, offset_z_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	allowDecimal = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT 
})

local adjust_button = UIElement:new({
    parent = window,
    pos = { 10, 250 },
    size = { 150, 30 },
	interactive = true,
	bgColor = TB_MENU_DEFAULT_DARKER_COLOR,
	hoverColor = TB_MENU_DEFAULT_LIGHTER_COLOR,
	shapeType = ROUNDED,
	rounded = 5,
})

adjust_button:addAdaptedText(false, "Apply")
adjust_button:addMouseHandlers(nil, function()
	apply()
end)

local adjust_button = UIElement:new({
    parent = window,
    pos = { 170, 250 },
    size = { 150, 30 },
	interactive = true,
	bgColor = TB_MENU_DEFAULT_DARKER_COLOR,
	hoverColor = TB_MENU_DEFAULT_LIGHTER_COLOR,
	shapeType = ROUNDED,
	rounded = 5,
})
adjust_button:addAdaptedText(false, "Select Mod")
adjust_button:addMouseHandlers(nil, function()
	Mods:showMain()
end)

function killAll()
	window:kill()
	header:kill()
end

function toggleWindow()
	if window.hidden then
		window:show()
		window.hidden = false
	else
		window:hide()
		window.hidden = true
	end
end

function apply()
	runCmd("clear")
	if (start_index_input.textfieldstr[1] == "") or (end_index_input.textfieldstr[1] == "") then
		echo("Start object and end object ids are required")
	else
		painful_moving()
		-- simple_moving()
	end
end

function painful_moving()
	local modName = find_mod(get_game_rules().mod) --find_mod doesn't have different returns for /lm and gui selected mod
	local path = "../data/mod/" .. modName

	--Read File
	local file = Files.Open(path, FILES_MODE_READONLY)
	if not (file.data) then 
		echo("Mod not found")
		return 
	end
	echo("Mod found")
	echo("owo what is this?")
	local content = file:readAll()
	file:close()
	echo("Read done")

	local i_start = tonumber(start_index_input.textfieldstr[1])
	local i_end = tonumber(end_index_input.textfieldstr[1])
	local offset_x = tonumber(offset_x_input.textfieldstr[1]) or 0
    local offset_y = tonumber(offset_y_input.textfieldstr[1]) or 0
    local offset_z = tonumber(offset_z_input.textfieldstr[1]) or 0

	echo("values set")

	local modified_lines = {}

	for obj_index = i_start, i_end do
		local in_target_obj = false
		for i, line in pairs(content) do
	
			if line:match("^env_obj%s+" .. obj_index .. "%s*$") then
				in_target_obj = true
			end
				
			if in_target_obj == true and line:match("^%s*pos%s+") then
				local x,y,z = get_obj_pos(obj_index - 1)
				local new_x = x + offset_x
				local new_y = y + offset_y
				local new_z = z + offset_z
				modified_lines[i] = string.format("   pos %.2f %.2f %.2f", new_x, new_y, new_z)
				break
			end
		end
	end

	echo("content updated")

	--Update File
	file = Files.Open(path, FILES_MODE_WRITE)
	if (file.data) then
		echo("write started")
		-- Write a simple string to the file
		for i, line in pairs(content) do
			if modified_lines[i] then
				file:writeLine(modified_lines[i])
			else
				file:writeLine(line)
			end
		end
		
		-- Close the file to save changes
		echo("File written successfully.")
	else
		echo("Error: Unable to open file.")
	end
	file:close()

	--reload mod
	runCmd("lm " .. "classic") -- mod swap required to update objects (mby better way exists)
	runCmd("lm " .. modName)
end

-- Simple and efficient, but this approach resets on new game :)))

function simple_moving()
	local i_start = tonumber(start_index_input.textfieldstr[1]) - 1
	local i_end = tonumber(end_index_input.textfieldstr[1]) - 1
	local offset_x = tonumber(offset_x_input.textfieldstr[1]) or 0
    local offset_y = tonumber(offset_y_input.textfieldstr[1]) or 0
    local offset_z = tonumber(offset_z_input.textfieldstr[1]) or 0

    for i = i_start, i_end do
		local x,y,z = get_obj_pos(i)
		x = x + offset_x
		y = y + offset_y
		z = z + offset_z
		set_obj_pos(i, x, y, z)
    end
end