extends "res://scripts/attack_base.gd"

var buffed = false

func _ready():
	if buffed:
		scale.x += 0.55
		scale.y += 0.55
		
	super()

func _attack_animation():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(scale.x+1,scale.y+1),active_time)
