extends CanvasLayer

var basic_attack = preload("res://prefabs/attack_base.tscn")
var attacking = false
var recent_attack = false
var attack_in_queue = false

func _ready():
	%Mana.max_value = PlayerData.max_mana
	%Mana.value = PlayerData.mana
	%ControlProgress.max_value = PlayerData.max_control
	%ControlProgress.value = PlayerData.control

func _process(_delta):
	
	%ControlProgress.value = PlayerData.control
	%Mana.value = PlayerData.mana
	%EnemiesDefeatedText.text = str(PlayerData.enemies_defeated)
	
	if attack_in_queue and not recent_attack:
		_launch_basic_attack()
		attacking = false
		recent_attack = true
		attack_in_queue = false
		_single_attack_delay()
		
	elif Input.is_action_just_pressed("basic_attack") and not recent_attack:
		_launch_basic_attack()
		attacking = true
		recent_attack = true
		attack_in_queue = false
		_single_attack_delay()
	
	elif Input.is_action_just_pressed("basic_attack") and recent_attack:
		attack_in_queue = true
		
	elif Input.is_action_just_released("basic_attack"):
		attacking = false
	
	elif Input.is_action_pressed("basic_attack") and not attacking and not recent_attack:
		_launch_basic_attack()
		attacking = true
		recent_attack = true
		attack_in_queue = false
		_single_attack_delay()

func _single_attack_delay():
	await get_tree().create_timer(PlayerData.attack_speed,false).timeout
	recent_attack = false
	
func _launch_basic_attack():
	var curr_attack = basic_attack.instantiate()
	curr_attack.position = get_viewport().get_mouse_position()
	get_parent().add_child(curr_attack)
	await get_tree().create_timer(PlayerData.attack_speed,false).timeout
	attack_in_queue = false
	if attacking:
		_launch_basic_attack()
		
