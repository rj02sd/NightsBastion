extends Node2D

@export var level_num:int
var rush_side = 1

func _ready():
	PlayerData.in_game = true


func _process(_delta):
	_check_loss_condition()
	_check_win_condition()
	
	"""
	for lantern in get_tree().get_nodes_in_group("Lantern"):
		if lantern.has_meta("lantern_num"):
			if lantern.get_meta("lantern_num") == rush_side:
				lantern.spawn_rate = 0.5
			else:
				lantern.spawn_rate = 10
				
		elif lantern.has_meta("belongs_to"):
			if lantern.get_meta("belongs_to") == rush_side:
				lantern.spawn_rate = 0.5
			else:
				lantern.spawn_rate = 10
	"""

func _change_rush_side():
	await get_tree().create_timer(5,false).timeout
	if rush_side == 0:
		rush_side = 1
	elif rush_side == 1:
		rush_side = 2
	elif rush_side == 2:
		rush_side = 0
	_change_rush_side()
	
func _skip_scene():
	await get_tree().create_timer(5,false).timeout
	if level_num == 1:
		get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
	elif level_num == 2:
		get_tree().change_scene_to_file("res://interface/menus/main_menu.tscn")

func _check_loss_condition():
	var lose = true
	for lantern in get_tree().get_nodes_in_group("Lantern"):
		if lantern.health > 0:
			lose = false
	if lose:
		await get_tree().create_timer(5.5,false).timeout
		_lose()	

func _check_win_condition():
	if PlayerData.control == PlayerData.max_control:
		PlayerData.levels_completed += 1
		_win()

func _lose():
	PlayerData.in_game = false
	get_tree().change_scene_to_file("res://interface/death_screen.tscn")

func _win():
	PlayerData.in_game = false
	if level_num == 0:
		get_tree().change_scene_to_file("res://interface/victory_screen.tscn")
	elif level_num == 1:
		get_tree().change_scene_to_file("res://interface/victory_screen_final.tscn")
