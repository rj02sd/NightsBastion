extends CanvasLayer


func _ready():
	PlayerData.resources_gathered = true


func _process(_delta):
	if PlayerData.weapon_crafted == false:
		%Continue.disabled = true
		%Misc.visible = false
	else:
		%Continue.disabled = false
		%Misc.visible = true
	%Inventory.text = ("HP Potions: "+str(PlayerData.health_potions)+
	"\nMana Potions: "+str(PlayerData.mana_potions)+"\nWeapon Bought: "+str(PlayerData.weapon_crafted))
	%WeightProgress.max_value = PlayerData.combat_max_weight
	%WeightProgress.value = PlayerData.combat_weight+1
	if PlayerData.combat_weight/PlayerData.combat_max_weight * 100.0 == 100:
		%WeightProgress/Weight.text = "WEIGHT RATING: MAX LOAD"+str(PlayerData.combat_weight)
	elif PlayerData.combat_weight/PlayerData.combat_max_weight * 100.0 >= 80:
		%WeightProgress/Weight.text = "WEIGHT RATING: HEAVYWEIGHT"
	elif PlayerData.combat_weight/PlayerData.combat_max_weight * 100.0 >= 50:
		%WeightProgress/Weight.text = "WEIGHT RATING: NOMINAL"	
	elif PlayerData.combat_weight/PlayerData.combat_max_weight * 100.0 >= 0:
		%WeightProgress/Weight.text = "WEIGHT RATING: LIGHTWEIGHT"

func _on_continue_pressed():
	PlayerData.in_game = true
	get_tree().change_scene_to_file("res://scenes/lvl_dev.tscn")
