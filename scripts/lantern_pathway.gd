extends Path2D

var enemy = preload("res://prefabs/enemy_base.tscn")

@export var max_health = 100
var health = 100
@export var spawn_rate:float
var spawner_active = true
var spawn_rate_decrease = 0.01
var spawn_rate_minimum = 0.1
@export var ctrl_bleed = 5
var enemy_speed_increase = 0
var enemy_speed_increase_rate = 0.1

func _ready():
	health = max_health
	%Health.max_value = max_health
	%Health.value = max_health
	%HealthTween.max_value = max_health
	%HealthTween.value = max_health
	_spawn_enemies()

func _process(delta):
	enemy_speed_increase = enemy_speed_increase_rate * delta
	if spawn_rate > spawn_rate_minimum:
		spawn_rate -= spawn_rate_decrease * delta
	if health <= 0:
		PlayerData.control -= ctrl_bleed * delta

func _update_health_bar():
	if health <= 0:
		health = 0
		_on_destroyed()
	var tween = create_tween()
	tween.tween_property(%HealthTween,"value",health,1)
	%Health.value = health

func _on_destroyed():
	spawner_active = false
	for alt in get_tree().get_nodes_in_group("AlternatePath"):
		if alt.get_meta("belongs_to") == get_meta("lantern_num"):
			alt.spawner_active = false
	
	for enemy_ref in get_tree().get_nodes_in_group("Enemy"):
		if enemy_ref.get_meta("target") == get_meta("lantern_num"):
			enemy_ref.queue_free()
			
	_darken_lights()
			
func _darken_lights():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(%Lantern/Light1,"energy",0,2)
	tween.tween_property(%Lantern/Light2,"energy",0,2)
	tween.tween_property(%Lantern/Darken,"energy",%Lantern/Darken.energy+10,4)
	tween.connect("finished",_turn_off_lights)

func _turn_off_lights():
	%Lantern/Light1.visible = false
	%Lantern/Light2.visible = false
	%Lantern.modulate = Color(0,0,0,1)
	%Health.visible = false
	%HealthTween.visible = false
	
func _spawn_enemies():
	if PlayerData.activate_spawners:
		var curr_enemy = enemy.instantiate()
		curr_enemy.speed += enemy_speed_increase
		
		if has_meta("lantern_num"):
			curr_enemy.set_meta("target",get_meta("lantern_num"))
		elif has_meta("belongs_to"):
			curr_enemy.set_meta("target",get_meta("belongs_to"))

		add_child(curr_enemy)
	await get_tree().create_timer(spawn_rate).timeout
	if spawner_active:
		_spawn_enemies()
		
func _take_damage(damage):
	health -= damage
	var percent_health = float(health)/float(max_health)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	PlayerData.control -= damage
	tween.tween_property(%Lantern/Light1,"energy",%Lantern/Light1.energy*percent_health+0.2,1)
	tween.tween_property(%Lantern/Light2,"energy",%Lantern/Light2.energy*percent_health+0.2,1)
	_update_health_bar()
