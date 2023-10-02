extends Node

var resources_gathered = false
var activate_spawners = true
var in_game = false
var item_preview_clicked = -1
var weapon_crafted = false
var health_potions = 0
var mana_potions = 0
var weapon_type_bought = 0
var player_difficulty = 5
var standard_difficulty = 5
var difficulty_multiplier = 1

var levels_completed = 0

var max_mana = 30
var mana = 30
var control = 0
var max_control = 1000
var base_attack_speed = 0.5
var attack_speed = 0.5
var attack_speed_decay = 0.01

var combat_max_weight = 100.0
var combat_weight = 0.0

var enemies_defeated_already = 0
var enemies_defeated = 0

var initial_time = 12*60
var time_left = 12*60
var max_energy = 100
var energy = 100
var max_weight = 30.0
var weight = 0.0

var amp_atk = 0
var amp_spd = 0
var amp_mana = 0

var ability_ready = true
var ability_cooldown = 0
var ability_max_cooldown = 10

var resource_weight = {
	feathers = 0.008,
	titanium = 2,
	cog_wheels = 0.5,
	elder_flowers = 0.02
}

var player_resources = {
	feathers = 300,
	titanium = 300,
	cog_wheels = 300,
	elder_flowers = 300
}

var player_stored_resources = {
	feathers = 0,
	titanium = 0,
	cog_wheels = 0,
	elder_flowers = 0
}

func _ready():
	pass 

func _cooldown(curr_cooldown):
	await get_tree().create_timer(1,false).timeout
	ability_cooldown = curr_cooldown - 1
	
	if ability_cooldown == 0:
		ability_ready = true
	else:
		_cooldown(ability_cooldown)

func _process(delta):
	if in_game:
		attack_speed += attack_speed_decay * delta
		if control <= 0:
			control = 0
		if control >= max_control:
			control = max_control
		if mana > max_mana:
			mana = max_mana
				
	if ability_cooldown == 0 and ability_ready == false:
		ability_cooldown = ability_max_cooldown
		_cooldown(ability_max_cooldown)
	
	#player difficulty of 1 means multiplier is 0.2, diff 10 means multiplier is 2
	if player_difficulty == standard_difficulty:
		difficulty_multiplier = 1
	if player_difficulty < standard_difficulty:
		difficulty_multiplier = 0.2 * player_difficulty
	if player_difficulty > standard_difficulty:
		difficulty_multiplier = 1+(player_difficulty-standard_difficulty) * 0.2

func _reset_game():
	resources_gathered = false
	activate_spawners = true
	in_game = false
	item_preview_clicked = -1
	weapon_crafted = false
	health_potions = 0
	mana_potions = 0
	weapon_type_bought = 0
	player_difficulty = 5
	standard_difficulty = 5
	difficulty_multiplier = 1

	levels_completed = 0

	max_mana = 30
	mana = 30
	control = 0
	max_control = 1000
	base_attack_speed = 0.5
	attack_speed = 0.5
	attack_speed_decay = 0.01

	combat_max_weight = 100.0
	combat_weight = 0.0

	enemies_defeated_already = 0
	enemies_defeated = 0

	initial_time = 12*60
	time_left = 12*60
	max_energy = 100
	energy = 100
	max_weight = 30.0
	weight = 0.0

	amp_atk = 0
	amp_spd = 0
	amp_mana = 0

	ability_ready = true
	ability_cooldown = 0
	ability_max_cooldown = 10

	var resource_weight = {
		feathers = 0.008,
		titanium = 2,
		cog_wheels = 0.5,
		elder_flowers = 0.02
	}

	var player_resources = {
		feathers = 0,
		titanium = 0,
		cog_wheels = 0,
		elder_flowers = 0
	}

	var player_stored_resources = {
		feathers = 0,
		titanium = 0,
		cog_wheels = 0,
		elder_flowers = 0
	}
