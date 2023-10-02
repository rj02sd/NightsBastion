extends RigidBody2D

var active_time
var damage
var attack_ready = false

func _ready():
	damage = ItemDefinitions.items[PlayerData.weapon_type_bought][2].atk_base
	active_time = ItemDefinitions.items[PlayerData.weapon_type_bought][2].active_time
	_attack_animation()
	await get_tree().create_timer(active_time,false).timeout
	queue_free()

func _attack_animation():
	pass
