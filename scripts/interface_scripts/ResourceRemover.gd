extends Control

var reductions = []

func _ready():
	pass


func _process(_delta):
	if visible:
		var total_weight = 0
		total_weight += PlayerData.player_resources.feathers * PlayerData.resource_weight.feathers
		total_weight += PlayerData.player_resources.titanium * PlayerData.resource_weight.titanium
		total_weight += PlayerData.player_resources.cog_wheels * PlayerData.resource_weight.cog_wheels
		total_weight += PlayerData.player_resources.elder_flowers * PlayerData.resource_weight.elder_flowers
		PlayerData.weight = total_weight
		
	if PlayerData.weight <= PlayerData.max_weight:
		%Confirm.disabled = false
	else:
		%Confirm.disabled = true


func _on_down_1_pressed():
	if PlayerData.player_resources.feathers > 0:
		reductions.append(1)
		PlayerData.player_resources.feathers -= 1


func _on_down_2_pressed():
	if PlayerData.player_resources.titanium > 0:
		reductions.append(2)
		PlayerData.player_resources.titanium -= 1


func _on_down_3_pressed():
	if PlayerData.player_resources.cog_wheels > 0:
		reductions.append(3)
		PlayerData.player_resources.cog_wheels -= 1


func _on_down_4_pressed():
	if PlayerData.player_resources.elder_flowers > 0:
		reductions.append(4)
		PlayerData.player_resources.elder_flowers -= 1


func _on_undo_pressed():
	if reductions.size() > 0:
		match reductions[reductions.size()-1]:
			1:
				PlayerData.player_resources.feathers += 1
			2:
				PlayerData.player_resources.titanium += 1
			3:
				PlayerData.player_resources.cog_wheels += 1
			4:
				PlayerData.player_resources.elder_flowers += 1
		reductions.remove_at(reductions.size()-1)


func _on_confirm_pressed():
	visible = false
	reductions = []
