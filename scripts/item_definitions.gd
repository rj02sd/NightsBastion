extends Node

var standard_sword_info = {
	item_name = "Standard Sword",
	attack = "testing1 attack",
	ability1 = "testing1 ability1",
	ability2 = "testing1 ability2",
	weight = 70,
	description = "testing1 description",
	feather_cost = 0,
	titanium_cost = 0,
	cogwheel_cost = 0,
	elderflower_cost = 0
}

var automatic_rifle_info = {
	item_name = "Standard Sword",
	attack = "testing2 attack",
	ability1 = "testing2 ability1",
	ability2 = "testing2 ability2",
	weight = 30,
	description = "testing2 description",
	feather_cost = 200,
	titanium_cost = 5,
	cogwheel_cost = 30,
	elderflower_cost = 0
}

var death_dealer_axe_info = {
	item_name = "Standard Sword",
	attack = "testing3 attack",
	ability1 = "testing3 ability1",
	ability2 = "testing3 ability2",
	weight = 50,
	description = "testing3 description",
	feather_cost = 0,
	titanium_cost = 20,
	cogwheel_cost = 5,
	elderflower_cost = 100
}

var health_potion_info = {
	item_name = "Health Potion",
	weight = 2,
	description = "testing4 description",
	feather_cost = 10,
	titanium_cost = 0,
	cogwheel_cost = 0,
	elderflower_cost = 20
}

var mana_potion_info = {
	item_name = "Mana Potion",
	weight = 2,
	description = "testing5 description",
	feather_cost = 20,
	titanium_cost = 0,
	cogwheel_cost = 0,
	elderflower_cost = 10
}

var icons = [
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png")
]

var items = [
	["Standard Sword",0,standard_sword_info,icons[0]],
	["Automatic Rifle",0,automatic_rifle_info,icons[1]],
	["Death Dealer Axe",0,death_dealer_axe_info,icons[2]],
	["Health Potion",1,health_potion_info,icons[3]],
	["Mana Potion",1,mana_potion_info,icons[4]]
]
