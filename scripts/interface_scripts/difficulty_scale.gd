extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://interface/tutorial.tscn")


func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/component_gathering.tscn")
