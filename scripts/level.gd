extends CanvasLayer

@export var level_num:int

func _ready():
	await get_tree().create_timer(5,false).timeout
	if level_num == 1:
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
	elif level_num == 2:
		get_tree().change_scene_to_file("res://interface/menus/main_menu.tscn")


func _process(delta):
	pass
