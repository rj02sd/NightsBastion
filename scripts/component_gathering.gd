extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_continue_pressed():
	PlayerData.resources_gathered = true
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_item_list_pressed():
	%item_list.visible = true
