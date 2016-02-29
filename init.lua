-- moremush 1.0
minetest.register_alias("flowers:mushroom_red", "moremush:mushroom_red")

--Simple API
dofile(minetest.get_modpath("moremush").."/api.lua")

moremush:register_mushroom("mushroom_red", {
	mainname = ":flowers:mushroom_red",
	maindname = "flowers:mushroom_red",
	description = "Red Mushroom",
	image = "flowers_mushroom_red",
	image_0 = "moremush_red_spores",
	image_1 = "moremush_red_1",
	image_2 = "moremush_red_2",
	image_3 = "moremush_red_3",
	hp = -5,
})

moremush:register_mushroom("mushroom_brown", {
	mainname = ":flowers:mushroom_brown",
	maindname = "flowers:mushroom_brown",
	description = "Brown Mushroom",
	image = "flowers_mushroom_brown",
	image_0 = "moremush_brown_spores",
	image_1 = "moremush_brown_1",
	image_2 = "moremush_brown_2",
	image_3 = "moremush_brown_3",
	hp = 1,
})

moremush:register_mushroom("mushroom_green", {
	mainname = "moremush:mushroom_green",
	maindname = "moremush:mushroom_green",
	description = "Ghostly Green Mushroom",
	image = "moremush_green",
	image_0 = "moremush_green_spores",
	image_1 = "moremush_green_1",
	image_2 = "moremush_green_2",
	image_3 = "moremush_green_3",
	hp = 2,
	light = 6,
	light_0 = 1,
	light_1 = 2,
	light_2 = 3,
	light_3 = 4
})

moremush:register_mushroom("mushroom_blue", {
	mainname = "moremush:mushroom_blue",
	maindname = "moremush:mushroom_blue",
	description = "Ghostly Blue Mushroom",
	image = "moremush_blue",
	image_0 = "moremush_blue_spores",
	image_1 = "moremush_blue_1",
	image_2 = "moremush_blue_2",
	image_3 = "moremush_blue_3",
	hp = 2,
	light = 6,
	light_0 = 1,
	light_1 = 2,
	light_2 = 3,
	light_3 = 4
})

moremush:register_mushroom("mushroom_boom", {
	mainname = "moremush:mushroom_boom",
	maindname = "moremush:mushroom_boom",
	description = "Fire Mushroom",
	image = "moremush_boom",
	image_0 = "moremush_boom_spores",
	image_1 = "moremush_boom_1",
	image_2 = "moremush_boom_2",
	image_3 = "moremush_boom_3",
	hp = -20,
	light = 8,
	light_0 = 1,
	light_1 = 2,
	light_2 = 4,
	light_3 = 6
})

