extends Node

var resources_gathered = false
var activate_spawners = true

var levels_completed = 0

var max_mana = 100
var mana = 100
var control = 0
var max_control = 100
var attack_speed = 0.4

var enemies_defeated = 0

func _ready():
	pass 



func _process(_delta):
	control = enemies_defeated - levels_completed * max_control
	
	if control >= max_control:
		control = max_control
