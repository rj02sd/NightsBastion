extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_item_list_pressed():
	%item_list.visible = true
