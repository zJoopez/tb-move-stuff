-- some spaghetti code by joope1
require("toriui/uielement")
require("system.menu_defines")
require("system.menu_manager")
require("system.mods_manager")
require("system.iofiles")

-- UI stuff
local header = UIElement:new({
	pos = { 1590, 0 },
	size = { 330, 40 },
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
	pos = { 285, 5 },
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
	pos = { 1590, 40 },
	size = { 330, 365 },
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
local start_index_input = TBMenu:spawnTextField2(start_index_input_holder, start_index_input_holder.size, "1", "1", {
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
local end_index_input = TBMenu:spawnTextField2(end_index_input_holder, end_index_input_holder.size, "256", "256", {
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
move_sect_label:addAdaptedText(false, "Position offset")

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

local color_sect_label = UIElement:new({
	parent = window,
	pos = { 10, 250 },
	size = { 150, 30 },
	textAlign = LEFTMID,
})
color_sect_label:addAdaptedText(false, "Color")

local color_r_input_holder = UIElement:new({
	parent = window,
	pos = { 10, 290 },
	size = { 75, 30 },
	interactive = true,
	textfield = true,

})

local color_r_input = TBMenu:spawnTextField2(color_r_input_holder, color_r_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false,
})

local color_g_input_holder = UIElement:new({
	parent = window,
	pos = { 90, 290 },
	size = { 75, 30 },
	interactive = true,
	textfield = true,

})

local color_g_input = TBMenu:spawnTextField2(color_g_input_holder, color_g_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false,
})

local color_b_input_holder = UIElement:new({
	parent = window,
	pos = { 170, 290 },
	size = { 75, 30 },
	interactive = true,
	textfield = true,

})

local color_b_input = TBMenu:spawnTextField2(color_b_input_holder, color_b_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false,
})

local color_a_input_holder = UIElement:new({
	parent = window,
	pos = { 250, 290 },
	size = { 75, 30 },
	interactive = true,
	textfield = true,

})

local color_a_input = TBMenu:spawnTextField2(color_a_input_holder, color_a_input_holder.size, nil, "0", {
	fontId = FONTS.MEDIUM,
	textAlign = LEFTMID,
	isNumeric = true,
	returnKeyType = KEYBOARD_RETURN.SEND,
	inputType = KEYBOARD_INPUT.DEFAULT,
	allowNegative = false
})

local adjust_button = UIElement:new({
	parent = window,
	pos = { 10, 330 },
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
	pos = { 170, 330 },
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
	painful_moving()
	-- simple_moving()
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

	local i_start = (tonumber(start_index_input.textfieldstr[1]) or 1)
	local i_end = tonumber(end_index_input.textfieldstr[1]) or 256
	local offset_x = tonumber(offset_x_input.textfieldstr[1]) or 0
	local offset_y = tonumber(offset_y_input.textfieldstr[1]) or 0
	local offset_z = tonumber(offset_z_input.textfieldstr[1]) or 0

	local modified_lines = {} --tmp solution hopefully
	local environment_objects = {}

	local reader_env_obj_id
	local reader_env_obj_tracked = false

	echo("values set")

	for i, line in pairs(content) do
		
		while true do --allows continue like behaviour
			local match
			match = tonumber(string.match(line, "^env_obj%s+(%d+)$"))
			if match then
				reader_env_obj_id = match
				environment_objects[reader_env_obj_id] = {}
				reader_env_obj_tracked = reader_env_obj_id >= i_start and reader_env_obj_id <= i_end
				break
			end

			if line:match("^%s*pos%s+") then
				local x, y, z = get_obj_pos(reader_env_obj_id - 1)
				environment_objects[reader_env_obj_id].pos = {}
				environment_objects[reader_env_obj_id].pos.x = x + offset_x
				environment_objects[reader_env_obj_id].pos.y = y + offset_y
				environment_objects[reader_env_obj_id].pos.z = z + offset_z

				if reader_env_obj_tracked == true then
					modified_lines[i] = string.format(
						"   pos %.2f %.2f %.2f",
						environment_objects[reader_env_obj_id].pos.x,
						environment_objects[reader_env_obj_id].pos.y,
						environment_objects[reader_env_obj_id].pos.z
					)
				end
				break
			end

			if line:match("^%s*color%s+") then
				environment_objects[reader_env_obj_id].color = get_obj_color(reader_env_obj_id - 1)
				if reader_env_obj_tracked == true then
					modified_lines[i] = string.format(
						"   color %.8f %.8f %.8f %.8f",
						environment_objects[reader_env_obj_id].color[1],
						environment_objects[reader_env_obj_id].color[2],
						environment_objects[reader_env_obj_id].color[3],
						environment_objects[reader_env_obj_id].color[4]
					)
					echo(modified_lines[i])
				end
				break
			end
			break
		end
	end

	echo("content updated")

	--Update File
	file = Files.Open(path, FILES_MODE_WRITE)
	if (file.data) then
		echo("write started")
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
	local i_start = tonumber(start_index_input.textfieldstr[1]) or 1
	local i_end = tonumber(end_index_input.textfieldstr[1]) or 256
	local offset_x = tonumber(offset_x_input.textfieldstr[1]) or 0
	local offset_y = tonumber(offset_y_input.textfieldstr[1]) or 0
	local offset_z = tonumber(offset_z_input.textfieldstr[1]) or 0

	for i = i_start, i_end do
		local x, y, z = get_obj_pos(i - 1)
		x = x + offset_x
		y = y + offset_y
		z = z + offset_z
		set_obj_pos(i, x, y, z)
	end
end
