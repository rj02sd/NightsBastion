extends "res://scripts/attack_base.gd"

func _ready():
	damage = 10
	active_time = ItemDefinitions.items[PlayerData.weapon_type_bought][2].active_time
	_attack_animation()
	await get_tree().create_timer(active_time+0.5,false).timeout
	queue_free()

func _physics_process(_delta):
	move_and_collide(linear_velocity)
	
func _attack_animation():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self,"scale",Vector2(scale.x+0.75,scale.y+0.75),active_time+0.5)
