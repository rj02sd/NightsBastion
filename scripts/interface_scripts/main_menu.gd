extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	if PlayerData.levels_completed == 2:
		%Credits.disabled = false


func _on_play_pressed():
	get_tree().change_scene_to_file("res://interface/tutorial.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://interface/tutorial.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://interface/controls.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://interface/credits.tscn")
