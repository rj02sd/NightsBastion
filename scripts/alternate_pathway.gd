extends "res://scripts/lantern_pathway.gd"

func _ready():
	_spawn_enemies()

func _process(delta):
	super(delta)

func _take_damage(damage):
	for lantern in get_tree().get_nodes_in_group("Lantern"):
		if lantern.get_meta("lantern_num") == get_meta("belongs_to"):
			lantern._take_damage(damage)
