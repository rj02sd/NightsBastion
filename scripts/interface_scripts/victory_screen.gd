extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")
