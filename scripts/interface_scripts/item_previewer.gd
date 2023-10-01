extends CanvasLayer

func _ready():
	pass


func _process(_delta):
	pass


func _on_back_pressed():
	if not PlayerData.resources_gathered:
		get_tree().change_scene_to_file("res://scenes/component_gathering.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")
