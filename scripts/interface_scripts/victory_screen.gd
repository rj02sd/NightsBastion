extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_continue_pressed():
	PlayerData.control = 0
	PlayerData.in_game = true
	get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")
