--[[
	**********************************************
	***                        Lettuce                        ***
	**********************************************
	
]]--

local farming_default = true

-- looking if farming_redo is activ?
if(farming.mod ~= nil and farming.mod == "redo") then

	farming_default = false

end

if (farming_default) then

	print("[MOD] " .. minetest.get_current_modname() .. " set to default mode.")
	
	-- lettuce
	farming.register_plant("lettuce:lettuce", {
		description = "Lettuce",
		inventory_image = "lettuce_seed.png",
		steps = 5,
		minlight = 12,
		maxlight = default.LIGHT_MAX,
		fertility = {"grassland"},
		groups = {flammable = 4},
	})
	
	-- Register for Mapgen
	minetest.register_node("lettuce:wild_lettuce", {
		description = "Wild Lettuce",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"lettuce:seed_lettuce 3"}},
						{items = {"lettuce:lettuce"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"lettuce_lettuce_5.png"},
		groups = {snappy = 3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})

else

	print("[MOD] " .. minetest.get_current_modname() .. " set to redo mode.")
	
	-- lettuce
	minetest.register_node("lettuce:seed", {
		description = "Lettuce Seed",
		tiles = {"lettuce_seed.png"},
		inventory_image = "lettuce_seed.png",
		wield_image = "lettuce_seed.png",
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1, dig_immediate=1, flammable = 4},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, "lettuce:lettuce_1")
		end,
	})

	minetest.register_craftitem("lettuce:lettuce", {
		description = "Lettuce",
		inventory_image = "lettuce_lettuce.png",
		groups = {flammable = 4},
		})
	
	-- lettuce definition
	local crop_def = {
		drawtype = "plantlike",
		tiles = {"lettuce_lettuce_1.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop =  "",
		selection_box = farming.select,
		groups = {
			flammable = 4, snappy=3, dig_immediate=1, plant = 1, attached_node = 1,
			not_in_creative_inventory = 1, growing = 1
		},
		sounds = default.node_sound_leaves_defaults()
	}

	-- stage 1
	minetest.register_node("lettuce:lettuce_1", table.copy(crop_def))

	-- stage 2
	crop_def.tiles = {"lettuce_lettuce_2.png"}
	minetest.register_node("lettuce:lettuce_2", table.copy(crop_def))

	-- stage 3
	crop_def.tiles = {"lettuce_lettuce_3.png"}
	minetest.register_node("lettuce:lettuce_3", table.copy(crop_def))

	-- stage 4
	crop_def.tiles = {"lettuce_lettuce_4.png"}
	crop_def.drop = {
		items = {
			{items = {"lettuce:seed"}, rarity = 2},
		}
	}
	minetest.register_node("lettuce:lettuce_4", table.copy(crop_def))

	-- stage 5
	crop_def.tiles = {"lettuce_lettuce_5.png"}
	crop_def.drop = {
		items = {
			{items = {"lettuce:lettuce"}, rarity = 1},
			{items = {"lettuce:lettuce"}, rarity = 3},
			{items = {"lettuce:seed"}, rarity = 1},
			{items = {"lettuce:seed"}, rarity = 1},
			{items = {"lettuce:seed"}, rarity = 3},

		}
	}
	minetest.register_node("lettuce:lettuce_5", table.copy(crop_def))

	-- Register for Mapgen
	minetest.register_node("lettuce:wild_lettuce", {
		description = "Wild Lettuce",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"lettuce:seed 3"}},
						{items = {"lettuce:lettuce"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"lettuce_lettuce_5.png"},
		groups = {snappy=3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})
	
end -- if( default ....)


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.02,
		spread = {x = 100, y = 100, z = 100},
		seed = 7133,
		octaves = 3,
		persist = 0.6
	},
	y_min = 0,
	y_max = 150,
	decoration = "lettuce:wild_lettuce",
})

minetest.register_craft({
	type = "fuel",
	recipe = "lettuce:lettuce",
	burntime = 2,
})

minetest.register_craftitem("lettuce:lettuce", {
	description = "lettuce",
	inventory_image = "lettuce_lettuce.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(1),
})

minetest.register_node("lettuce:bowl", {
	description = "Glass Bowl",
	drawtype = "plantlike",
	tiles = {"lettuce_bowl.png"},
	inventory_image = "lettuce_bowl.png",
	wield_image = "lettuce_bowl.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, food_bowl=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "lettuce:bowl",
	recipe = {	{"default:glass", "", "default:glass"},
				{"default:glass", "default:glass", "default:glass"}
			}
})

minetest.register_node("lettuce:oil", {
	description = "Salad Oil",
	drawtype = "plantlike",
	tiles = {"lettuce_oil.png"},
	inventory_image = "lettuce_oil.png",
	wield_image = "lettuce_oil.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(2, "vessels:glass_bottle"),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_oil=1},
	sounds = default.node_sound_glass_defaults(),
})

if(farming_default) then
	minetest.register_craft({
		output = "lettuce:oil",
		recipe = {	{"lettuce:seed_lettuce", "lettuce:seed_lettuce", "lettuce:seed_lettuce"},
					{"lettuce:seed_lettuce", "lettuce:seed_lettuce", "lettuce:seed_lettuce"},
					{"", "vessels:glass_bottle", ""}

				}
		})
else
	minetest.register_craft({
		output = "lettuce:oil",
		recipe = {	{"lettuce:seed", "lettuce:seed", "lettuce:seed"},
					{"lettuce:seed", "lettuce:seed", "lettuce:seed"},
					{"", "vessels:glass_bottle", ""}

				}
		})
end
	

minetest.register_craft({
	type = "fuel",
	recipe = "lettuce:oil",
	burntime = 20,
	replacements = {{ "lettuce:oil", "vessels:glass_bottle"}}
})

minetest.register_node("lettuce:salad_bowl", {
	description = "Glass Salad Bowl",
	drawtype = "plantlike",
	tiles = {"lettuce_salad_bowl.png"},
	inventory_image = "lettuce_salad_bowl.png",
	wield_image = "lettuce_salad_bowl.png",
	on_use = minetest.item_eat(4, "lettuce:bowl"),
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "lettuce:salad_bowl",
	recipe = {	{"lettuce:lettuce", "lettuce:lettuce", "lettuce:lettuce"},
				{"", "group:food_oil", ""},
				{"", "group:food_bowl", ""}
			}
})

print("[MOD] " .. minetest.get_current_modname() .. " loaded.")