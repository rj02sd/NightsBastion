extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass
	

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://interface/menus/main_menu.tscn")


func _on_sell_pressed():
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_retry_pressed():
	if PlayerData.levels_completed == 0:
		get_tree().change_scene_to_file("res://scenes/lvl_dev.tscn")
		PlayerData.control = 0
	elif PlayerData.levels_completed == 1:
		get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")
		PlayerData.control = 0
	
