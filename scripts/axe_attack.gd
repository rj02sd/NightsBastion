extends "res://scripts/attack_base.gd"


func _ready():
	super()

func _attack_animation():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(scale.x+1,scale.y+1),active_time)
