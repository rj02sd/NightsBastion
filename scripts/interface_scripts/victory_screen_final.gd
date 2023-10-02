extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_continue_pressed():
	PlayerData.control = 0
	get_tree().change_scene_to_file("res://interface/credits.tscn")
