extends Control

@export var mod_name:String
@export var mod_color:Color
@export var index:int

var mod_amp = 1

func _ready():
	%Mod.text = mod_name

func _process(delta):
	for level in range(%Levels.get_child_count()):
		if level < mod_amp:
			%Levels.get_child(level).visible = true
		else:
			%Levels.get_child(level).visible = false
		%Levels.get_child(level).color = mod_color


func _on_add_pressed():
	if get_parent() != null:
		if mod_amp < 5 and (get_parent().weight_preview+PlayerData.combat_weight)<PlayerData.combat_max_weight:
			mod_amp += 1
			get_parent().weight_preview += 5


func _on_subtract_pressed():
	if get_parent() != null:
		if mod_amp > 0:
			mod_amp -= 1
			get_parent().weight_preview -= 5
