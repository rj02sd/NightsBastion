extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	%Scale.text = str(snapped(float(%Difficulty.value)/10.0,0.1))
	PlayerData.player_difficulty = snapped(float(%Difficulty.value)/10.0,0.1)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://interface/tutorial.tscn")


func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/component_gathering.tscn")
