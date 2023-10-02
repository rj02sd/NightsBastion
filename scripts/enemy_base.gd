extends PathFollow2D

var speed = 5
var damage_multiplier = 1.0

var max_health = 5.0
var health = 5.0

func _ready():
	health *= PlayerData.difficulty_multiplier
	_transform_color()
	if get_parent() is Path2D:
		progress_ratio = 0

func _process(_delta):
	
	if health <= 0.0:
		health = 0.0
		
	if health == 0.0:
		PlayerData.enemies_defeated += 1
		queue_free()
		
	if get_parent() is Path2D:
		if progress_ratio <= 0.95:
			progress_ratio += 0.001 * speed
		else:
			_self_destruct()


func _transform_color():
	var tween = create_tween()
	if health >= 4.5:
		tween.tween_property(%enemy,"modulate",Color(1,0,1),0.1)
	elif health >= 3.5:
		tween.tween_property(%enemy,"modulate",Color(0.3,0.3,0),0.1)
	elif health >= 2.5:
		tween.tween_property(%enemy,"modulate",Color(0,1,0),0.1)
	elif health >= 1.5:
		tween.tween_property(%enemy,"modulate",Color(0,0.5,0.5),0.1)
	elif health >= 0.1:
		tween.tween_property(%enemy,"modulate",Color(1,0,0),0.1)
		
func _self_destruct():
	get_parent()._take_damage(health*damage_multiplier)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.get_groups()[0] == "Attack":
		health -= float(body.damage)
		PlayerData.control += body.damage
		_transform_color()
