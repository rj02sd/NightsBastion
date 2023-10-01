extends Node2D

@export var level_num:int

func _ready():
	#_skip_scene()
	pass


func _process(_delta):
	_check_loss_condition()
	_check_win_condition()

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
		await get_tree().create_timer(8,false).timeout
		_lose()	

func _check_win_condition():
	if PlayerData.control == PlayerData.max_control:
		PlayerData.levels_completed += 1
		_win()

func _lose():
	get_tree().change_scene_to_file("res://interface/death_screen.tscn")

func _win():
	if level_num == 0:
		get_tree().change_scene_to_file("res://interface/victory_screen.tscn")
	elif level_num == 1:
		get_tree().change_scene_to_file("res://interface/victory_screen_final.tscn")
