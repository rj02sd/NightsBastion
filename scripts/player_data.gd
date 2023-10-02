extends Node

var resources_gathered = false
var activate_spawners = true
var in_game = false
var item_preview_clicked = -1
var weapon_crafted = false
var health_potions = 0
var mana_potions = 0
var weapon_type_bought = 0

var levels_completed = 0

var max_mana = 100
var mana = 100
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

func _ready():
	pass 


func _process(delta):
	if in_game:
		attack_speed += attack_speed_decay * delta
		if control <= 0:
			control = 0
		if control >= max_control:
			control = max_control

func _reset_game():
	pass
