extends Control

@export var weight_mode = false
func _ready():
	_update_resources()


func _process(delta):
	_update_resources()

func _update_resources():
	if not weight_mode:
		%R1.get_child(0).text = str(PlayerData.player_resources.feathers+PlayerData.player_stored_resources.feathers)
		%R2.get_child(0).text = str(PlayerData.player_resources.titanium+PlayerData.player_stored_resources.titanium)
		%R3.get_child(0).text = str(PlayerData.player_resources.cog_wheels+PlayerData.player_stored_resources.cog_wheels)
		%R4.get_child(0).text = str(PlayerData.player_resources.elder_flowers+PlayerData.player_stored_resources.elder_flowers)
	else:
		%R1.get_child(0).text = str(snappedf(PlayerData.player_resources.feathers*PlayerData.resource_weight.feathers,0.01))
		%R2.get_child(0).text = str(snappedf(PlayerData.player_resources.titanium*PlayerData.resource_weight.titanium,0.01))
		%R3.get_child(0).text = str(snappedf(PlayerData.player_resources.cog_wheels*PlayerData.resource_weight.cog_wheels,0.01))
		%R4.get_child(0).text = str(snappedf(PlayerData.player_resources.elder_flowers*PlayerData.resource_weight.elder_flowers,0.01))
