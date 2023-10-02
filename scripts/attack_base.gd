extends RigidBody2D

var active_time = 0.15
var damage = 3
var attack_ready = false

func _ready():
	_attack_animation()
	await get_tree().create_timer(active_time,false).timeout
	queue_free()


func _process(_delta):
	pass

func _attack_animation():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(scale.x+1,scale.y+1),active_time)
