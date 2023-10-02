extends "res://scripts/attack_base.gd"

var leftshot = false
var rightshot = false

func _ready():
	if leftshot:
		linear_velocity = Vector2(10,0)
	elif rightshot:
		linear_velocity = Vector2(-10,0)
	else:
		linear_velocity = Vector2(0,-10)
		
	super()

func _physics_process(_delta):
	move_and_collide(linear_velocity)
	
func _attack_animation():
	pass
