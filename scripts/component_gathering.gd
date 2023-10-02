extends CanvasLayer

var phase = 0

func _ready():
	_update_values()
	_change_phase()


func _process(_delta):
	_update_values()
	_update_background()
	
	if phase != 0:
		if %Actions.no_actions and PlayerData.weight <= PlayerData.max_weight:
			phase = 3
			_change_phase()
			
		elif PlayerData.weight > PlayerData.max_weight:
			phase = 2
			_change_phase()
		
		elif not %ResourceRemover.visible:
			phase = 1
			_change_phase()

func _update_background():
	var tween = create_tween()
	if PlayerData.time_left/60 >= 12:
		tween.tween_property(%Background,"color",Color(0,0.17,1),1)
	elif PlayerData.time_left/60 >= 10:
		tween.tween_property(%Background,"color", Color(0,0,0.95),1)
	elif PlayerData.time_left/60 >= 6:
		tween.tween_property(%Background,"color",Color(0,0,0.6),1)
	elif PlayerData.time_left/60 >= 2:
		tween.tween_property(%Background,"color",Color(0,0,0.2),1)
	elif PlayerData.time_left/60 >= 0:
		tween.tween_property(%Background,"color",Color(0.01,0,0.1),1)
	
func _format_time(mins):
	var hours = mins/60
	var mins_left = mins%60
	return (str(hours)+" hrs "+str(mins_left)+" mins")
	
func _update_values():
	%WeightProgress.max_value = PlayerData.max_weight
	%WeightProgress.value = PlayerData.weight+1
	%WeightProgress/Weight.text = "Space Left: "+str(snappedf(PlayerData.max_weight-PlayerData.weight,0.01))+" kgs"
	%EnergyProgress.max_value = PlayerData.max_energy
	%EnergyProgress.value = PlayerData.energy
	%EnergyProgress/Energy.text = "Energy: "+str(PlayerData.energy)
	%Time_left.text = "TIME TILL NIGHT: "+_format_time(PlayerData.time_left)
	
func _on_continue_pressed():
	PlayerData.resources_gathered = true
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_item_list_pressed():
	%item_list.visible = true


func _on_skip_pressed():
	PlayerData.resources_gathered = true
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")
	

func _on_start_gathering_pressed():
	phase = 1
	_change_phase()

func _change_phase():
	match phase:
		0:
			%Info.visible = true
			%StartGathering.visible = true
			%Actions.visible = false
			%NightApproaches.visible = false
			%Continue.visible = false
			%ResourceRemover.visible = false
		1:
			%Info.visible = false
			%StartGathering.visible = false
			%Actions.visible = true
			%NightApproaches.visible = false
			%Continue.visible = false
			%ResourceRemover.visible = false
		2:
			%Actions.visible = false
			%NightApproaches.visible = false
			%Continue.visible = false
			%ResourceRemover.visible = true
		3:
			%Actions.visible = false
			%NightApproaches.visible = true
			%Continue.visible = true
			%ResourceRemover.visible = false
