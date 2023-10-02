extends Node

var standard_sword_info = {
	item_name = "Standard Sword",
	attack = "Melee Slash",
	ability1 = "Increase slash attack size and speed for [10 Seconds]",
	ability2 = "N/A",
	weight = 70,
	description = ("The Standard Issue Combat Sword is given to all defenders for free.
	It's a reliable Sword that gets the job done. It's main purpose is to be a budget
	sword for your armory. Many have used this sword and successfully defended our base,
	but can you? Ability has [10 Second Cooldown] and [14 Base Mana Cost]"),
	feather_cost = 0,
	titanium_cost = 0,
	cogwheel_cost = 0,
	elderflower_cost = 0,
	amp_multiplier = 0.5,
	atk_base = 2,
	spd_base = 0.5,
	eff_base = 0.7,
	active_time = 0.15,
	ability_cost = 10,
	ability_cooldown = 10,
	ability_duration = 5
}

var automatic_rifle_info = {
	item_name = "Automatic Rifle",
	attack = "Rapid Fire Projectiles",
	ability1 = "Volley of Projectiles from sides of the screen.",
	ability2 = "N/A",
	weight = 30,
	description = ("The Oscillating Automatic Rifle is a powerful rifle available for use.
	The rifle is known to fill the night with tons of projectiles, to ensure control is achieved.
	It is one of the legendary weapons used by the best heroes of our time. As long as this 
	rifle is in your hands, you can't lose! Ability has [10 Second Cooldown] and [11 Base Mana Cost]"),
	feather_cost = 200,
	titanium_cost = 5,
	cogwheel_cost = 30,
	elderflower_cost = 0,
	amp_multiplier = 0.1,
	atk_base = 1,
	spd_base = 0.2,
	eff_base = 0.9,
	active_time = 3,
	ability_cost = 10,
	ability_cooldown = 10
}

var death_dealer_axe_info = {
	item_name = "Death Dealer Axe",
	attack = "Deadly Axe Throw",
	ability1 = "Slash the entire screen horizontally with the axe.",
	ability2 = "N/A ",
	weight = 50,
	description = ("The Chromatic Death Dealer Axe is a legendary axe only talked about in myths.Due to its extreme power,"+ 
	"it is forbidden for general use. Only the most experienced heroes"+
	"are able to maximize the power of this axe. Auto attacks from this weapon poison the enemy,"+
	"solidifiying this as a powerhouse weapon. Spectral copies emerge from this axe on command of warlords."+
	"\n Ability has [10s Cooldown] and [8 Base Mana Cost]"),
	feather_cost = 0,
	titanium_cost = 20,
	cogwheel_cost = 5,
	elderflower_cost = 100,
	amp_multiplier = 1,
	atk_base = 2,
	spd_base = 0.7,
	eff_base = 1.2,
	active_time = 0.3,
	ability_cost = 10,
	ability_cooldown = 10
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
