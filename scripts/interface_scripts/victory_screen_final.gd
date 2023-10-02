extends CanvasLayer


func _ready():
	PlayerData.levels_completed = 2


func _process(_delta):
	%Difficulty.text = "BEAT ON DIFFICULTY: "+str(PlayerData.player_difficulty)
	%Enemies_Defeated.text = "ENEMIES DEFEATED: "+str(PlayerData.enemies_defeated)

func _on_continue_pressed():
	PlayerData.control = 0
	get_tree().change_scene_to_file("res://interface/credits.tscn")
