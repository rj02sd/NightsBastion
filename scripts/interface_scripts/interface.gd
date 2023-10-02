extends CanvasLayer

var sword_attack = preload("res://prefabs/sword_attack.tscn")
var rifle_attack = preload("res://prefabs/rifle_attack.tscn")
var axe_attack = preload("res://prefabs/axe_attack.tscn")
var heavy_slash = preload("res://prefabs/heavy_slash.tscn")

var attacking = false
var recent_attack = false
var attack_in_queue = false

var sword_buff = false

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
	
	if Input.is_action_just_pressed("ability1"):
		_use_ability()
		
	if Input.is_action_just_pressed("health_potion"):
		_use_health_potion()
		
	if Input.is_action_just_pressed("mana_potion"):
		_use_mana_potion()
	
	if PlayerData.ability_ready:
		%AbilityCD.visible = false
		%Ability.disabled = false
	else:
		%AbilityCD.visible = true
		%AbilityCD.text = str(PlayerData.ability_cooldown)
		%Ability.disabled = true

func _use_ability():
	var mana_cost = (ItemDefinitions.items[PlayerData.weapon_type_bought][2].ability_cost/
		ItemDefinitions.items[PlayerData.weapon_type_bought][2].eff_base)
	if PlayerData.ability_ready and PlayerData.mana >= mana_cost:
		PlayerData.mana -= mana_cost
		PlayerData.ability_ready = false
		match PlayerData.weapon_type_bought:
			0:
				_ability_sword()
			1:
				_ability_rifle()
			2:
				_ability_axe()
					
func _single_attack_delay():
	await get_tree().create_timer(PlayerData.attack_speed,false).timeout
	recent_attack = false

func _ability_sword():
	sword_buff = true
	ItemDefinitions.items[0][2].spd_base -= 0.15
	await get_tree().create_timer(ItemDefinitions.items[0][2].ability_duration,false).timeout
	ItemDefinitions.items[0][2].spd_base += 0.15
	sword_buff = false

func _ability_rifle():
	for y in range(5):
		for x in range(5):
			var projectile = rifle_attack.instantiate()
			projectile.position = Vector2(-50-(200*x),y*150+100)
			projectile.leftshot = true
			get_parent().add_child(projectile)
		
	for y in range(5):
		for x in range(5):
			var projectile = rifle_attack.instantiate()
			projectile.position = Vector2(1200+(200*x),y*150+50)
			projectile.rightshot = true
			get_parent().add_child(projectile)
		
func _ability_axe():
	var curr_attack = heavy_slash.instantiate()
	curr_attack.position = Vector2(600,300)
	get_parent().add_child(curr_attack)
		
func _launch_basic_attack():
	var curr_attack = null
	
	match PlayerData.weapon_type_bought:
		0:
			curr_attack = sword_attack.instantiate()
			curr_attack.position = get_viewport().get_mouse_position()
			if sword_buff:
				curr_attack.buffed = true
		1:
			curr_attack = rifle_attack.instantiate()
			curr_attack.position = Vector2(get_viewport().get_mouse_position().x,700)
		2:
			curr_attack = axe_attack.instantiate()
			curr_attack.position = get_viewport().get_mouse_position()
			
	get_parent().add_child(curr_attack)
	await get_tree().create_timer(ItemDefinitions.items[PlayerData.weapon_type_bought][2].spd_base,false).timeout
	attack_in_queue = false
	if attacking:
		_launch_basic_attack()
		


func _on_ability_pressed():
	_use_ability()

func _use_health_potion():
	if PlayerData.health_potions > 0:
		var lowest = null
		var lowest_hp = 9999
		for lantern in get_tree().get_nodes_in_group("Lantern"):
			if lantern.health < lowest_hp:
				lowest_hp = lantern.health
				lowest = lantern
		lowest.health = lowest.max_health
		lowest._update_health_bar()
		PlayerData.health_potions -= 1

func _use_mana_potion():
	if PlayerData.mana < PlayerData.max_mana and PlayerData.mana_potions > 0:
		PlayerData.mana += 15
		PlayerData.mana_potions -= 1
	
func _on_health_potion_pressed():
	_use_health_potion()

func _on_mana_potion_pressed():
	_use_mana_potion()
