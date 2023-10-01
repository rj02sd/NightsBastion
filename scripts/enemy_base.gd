extends PathFollow2D

var speed = 5
var damage_multiplier = 1

var max_health = 5
var health = 5

func _ready():
	_transform_color()
	if get_parent() is Path2D:
		progress_ratio = 0

func _process(_delta):
	
	if health <= 0:
		health = 0
		
	if health == 0:
		PlayerData.enemies_defeated += 1
		queue_free()
		
	if get_parent() is Path2D:
		if progress_ratio <= 0.95:
			progress_ratio += 0.001 * speed
		else:
			_self_destruct()


func _transform_color():
	match health:
		1:
			%enemy.modulate = Color(255,0,0)
		2:
			%enemy.modulate = Color(0,200,200)
		3:
			%enemy.modulate = Color(0,255,0)
		4:
			%enemy.modulate = Color(100,100,0)
		5:
			%enemy.modulate = Color(255,0,255)
		
func _self_destruct():
	get_parent()._take_damage(health*damage_multiplier)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.get_groups()[0] == "Attack":
		health -= body.damage
		_transform_color()
