moremush = {}

-- place_seed taken from minetest_game/farming/api.lua farming.place_seed, with removal of comments and minor changes.
moremush.place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)
	
	if minetest.is_protected(pt.under, placer:get_player_name()) then
		minetest.record_protection_violation(pt.under, placer:get_player_name())
		return
	end
	if minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.record_protection_violation(pt.above, placer:get_player_name())
		return
	end

	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	--if pt.above.y ~= pt.under.y+1 then
	--	return
	--end
	
	if not minetest.registered_nodes[above.name].buildable_to then
		return
	end
	
	print("UNDER:"..under.name)
	print("ABOVE:"..above.name)
	if under.name == "default:tree" or under.name == "default:mossycobble" then
		local stack = ItemStack(plantname)
		minetest.item_place(stack, placer, pointed_thing)
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end
end

function moremush:register_mushroom(name, def)

    minetest.register_node("moremush:"..name.."_i", {
		tiles = {def.image..".png"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		light_source = def.light or 0,
		drop = def.maindname,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})
	
	minetest.register_node(def.mainname, {
		description = def.description or "Undefined Mushroom",
		tiles = {def.image..".png", def.image..".png^[transformFXR180", def.image..".png^[transformFXR90"},
		inventory_image = def.image..".png",
		wield_image = def.image..".png",
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		on_use = minetest.item_eat(def.hp),
		after_place_node = function(pos, placer, itemstack)
			if( not( pos ) or not( placer )) then
				return;
			end
			local n = minetest.get_node({x = pos.x, y = pos.y-1, z = pos.z-1})
			local node = n.name
			if not minetest.registered_nodes[node].buildable_to then
				minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name="moremush:"..name.."_i"})
			end
        end,
		light_source = def.light or 0,
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	minetest.register_node("moremush:"..name.."_1", {
		tiles = {def.image_1..".png"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_1 or 0,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})
	
	minetest.register_node("moremush:"..name.."_2", {
		tiles = {def.image_2..".png"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_2 or 0,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})
	
	minetest.register_node("moremush:"..name.."_3", {
		tiles = {def.image_3..".png"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_3 or 0,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})
	
	minetest.register_node("moremush:"..name.."_4", {
		tiles = {def.image..".png"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		light_source = def.light or 0,
		drop = {
		max_items = 4,
			items = {
				{items = {'moremush:'..name..'_spores'},rarity = 10},
				{items = {'moremush:'..name..'_spores'},rarity = 7},
				{items = {'moremush:'..name..'_spores'}},
				{items = {def.maindname}},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})
	
	minetest.register_node("moremush:"..name.."_spores", {
		description = def.description.." Spores" or "Undefined Mushroom Spores",
		tiles = {def.image_0..".png"},
		inventory_image = def.image_0..".png",
		wield_image = def.image_0..".png",
		drawtype = "signlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1},
		sounds = default.node_sound_leaves_defaults(),
		light_source = def.light_0 or 0,
		on_place = function(itemstack, placer, pointed_thing)
			return moremush.place_seed(itemstack, placer, pointed_thing, "moremush:"..name.."_spores")
		end,
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	-- opposite nodes & wall nodes
	minetest.register_node("moremush:"..name.."_1_o", {
		tiles = {def.image_1..".png", def.image_1..".png^[transformFXR180", def.image_1..".png^[transformFXR90"},
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_1 or 0,
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	minetest.register_node("moremush:"..name.."_2_o", {
		tiles = {def.image_2..".png", def.image_2..".png^[transformFXR180", def.image_2..".png^[transformFXR90"},
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_2 or 0,
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	minetest.register_node("moremush:"..name.."_3_o", {
		tiles = {def.image_3..".png", def.image_3..".png^[transformFXR180", def.image_3..".png^[transformFXR90"},
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1, mush = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'moremush:'..name..'_spores',
		light_source = def.light_3 or 0,
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	minetest.register_node("moremush:"..name.."_4_o", {
		tiles = {def.image..".png", def.image..".png^[transformFXR180", def.image..".png^[transformFXR90"},
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wallmounted = true,
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 3, flammable = 3, attached_node = 1, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		light_source = def.light or 0,
		drop = {
		max_items = 4,
			items = {
				{items = {'moremush:'..name..'_spores'},rarity = 10},
				{items = {'moremush:'..name..'_spores'},rarity = 7},
				{items = {'moremush:'..name..'_spores'}},
				{items = {def.maindname}},
			}
		},
		selection_box = {
			type = "wallmounted",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		}
	})
	
	minetest.register_craft({
		output = 'moremush:'..name..'_spores',
		recipe = {
			{'moremush:mushroom_brown_spores'},
			{'dye:'..def.dye..''},
		}
	})
	
	minetest.register_abm({
		nodenames = {"group:mush"},
		neighbors = {"default:tree", "default:mossycobble"},
		interval = 90,
		chance = 2,
		action = function(pos, node)
			local n = minetest.get_node({x = pos.x, y = pos.y-1, z = pos.z})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.set_node(pos, {name="moremush:"..name.."_1"})
				elseif n.name == "moremush:"..name.."_1" then
					minetest.set_node(pos, {name="moremush:"..name.."_2"})
				elseif n.name == "moremush:"..name.."_2" then
					minetest.set_node(pos, {name="moremush:"..name.."_3"})
				elseif n.name == "moremush:"..name.."_3" then
					minetest.set_node(pos, {name="moremush:"..name.."_4"})
				end
			end
			
			local n = minetest.get_node({x = pos.x, y = pos.y+1, z = pos.z})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.add_node(pos, {name = "moremush:"..name.."_1_o", param2 = 6})
				elseif n.name == "moremush:"..name.."_1_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_2_o", param2 = 6})
				elseif n.name == "moremush:"..name.."_2_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_3_o", param2 = 6})
				elseif n.name == "moremush:"..name.."_3_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_4_o", param2 = 6})
				end
			end
			
			local n = minetest.get_node({x = pos.x+1, y = pos.y, z = pos.z})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.add_node(pos, {name = "moremush:"..name.."_1_o", param2 = 2})
				elseif n.name == "moremush:"..name.."_1_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_2_o", param2 = 2})
				elseif n.name == "moremush:"..name.."_2_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_3_o", param2 = 2})
				elseif n.name == "moremush:"..name.."_3_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_4_o", param2 = 2})
				end
			end
			
			local n = minetest.get_node({x = pos.x-1, y = pos.y, z = pos.z})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.add_node(pos, {name = "moremush:"..name.."_1_o", param2 = 3})
				elseif n.name == "moremush:"..name.."_1_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_2_o", param2 = 3})
				elseif n.name == "moremush:"..name.."_2_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_3_o", param2 = 3})
				elseif n.name == "moremush:"..name.."_3_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_4_o", param2 = 3})
				end
			end
			
			local n = minetest.get_node({x = pos.x, y = pos.y, z = pos.z+1})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.add_node(pos, {name = "moremush:"..name.."_1_o", param2 = 4})
				elseif n.name == "moremush:"..name.."_1_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_2_o", param2 = 4})
				elseif n.name == "moremush:"..name.."_2_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_3_o", param2 = 4})
				elseif n.name == "moremush:"..name.."_3_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_4_o", param2 = 4})
				end
			end
			
			local n = minetest.get_node({x = pos.x, y = pos.y, z = pos.z-1})
			if n.name == "default:tree" or n.name == "default:mossycobble" then
				local ll = minetest.get_node_light(pos)
				if not ll or ll > 10 or ll < 0 then
					return
				end
				
				local n = minetest.get_node(pos)
				if n.name == "moremush:"..name.."_spores" then
					minetest.add_node(pos, {name = "moremush:"..name.."_1_o", param2 = 5})
				elseif n.name == "moremush:"..name.."_1_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_2_o", param2 = 5})
				elseif n.name == "moremush:"..name.."_2_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_3_o", param2 = 5})
				elseif n.name == "moremush:"..name.."_3_o" then
					minetest.add_node(pos, {name = "moremush:"..name.."_4_o", param2 = 5})
				end
			end
		end
	})
end
