extends Control

var action1_icon
var action2_icon
var action3_icon

var action1_description
var action2_description
var action3_description

var action_nums
var disabled_actions = 0

var no_actions = false

var icons = [
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png"),
	preload("res://art/ui/white_square_sprite.png")
]

var priority_actions = 6

var action_variants = [
	#[Icon number, Description, Energy, Minutes, #item1, #item2]
	[0,"Gain [color=green]+120 feathers[/color]",10,30,120,null], #1
	[1,"Gain [color=green]+10 pieces of titanium[/color]",10,150,10,null], #2
	[2,"Gain [color=green]+15 cogwheels[/color]",10,90,15,null], #3
	[3,"Gain [color=green]+80 Elderflowers[/color]",10,50,80,null], #4
	[4,"Gain [color=green]+60 feather[/color] and [color=green]+40 elderflowers[/color]",10,40,60,40,null,null], #5
	[4,"Gain [color=green]+5 titanium pieces[/color] and [color=green]+10 cogwheels[/color]",10,120,5,10,null,null], #6
	[4,"Multiply all current resources by [color=orange]1.2[/color]",10,60,null,null], #7
	[0,"Multiply [color=green]feather[/color] count by [color=orange]3[/color]",15,60,null,null], #8
	[3,"Multiply [color=green]Elder Flowers[/color] count by [color=orange]3[/color]",15,60,null,null], #9
	[1,"Compress all [color=green]titanium[/color] by a factor of [color=orange]1.5[/color]",25,150,null,null], #10
	[4,"Increase [color=orange]Storage Capacity[/color] by [color=orange]10kg[/color]",30,90,null,null], #11
	[4,"Store Current [color=green]Resources[/color]",0,150,null,null], #12
	[4,"Reroll",5,0,null,null], #13
	[4,"Gain [color=cyan]30 Energy[/color]",-30,0,null,null], #14
	[3,"Convert All Unstored Resources to [color=green]Elderflowers[/color]",15,30,null,null] #15
]

func _ready():
	action1_icon = %Action1.get_child(0)
	action2_icon = %Action2.get_child(0)
	action3_icon = %Action3.get_child(0)
	
	action1_description = %Action1.get_child(1)
	action2_description = %Action2.get_child(1)
	action3_description = %Action3.get_child(1)
	
	_set_actions()

func _process(delta):
	pass

func _choose_random_numbers():
	var curr_nums = []
	while curr_nums.size() < 3:
		var rand_num = randi_range(0,action_variants.size()-1+priority_actions)
		if curr_nums.count(rand_num) < 1:
			if rand_num >= action_variants.size():
				if curr_nums.count(rand_num-action_variants.size()) < 1:
					curr_nums.append(rand_num-action_variants.size())
			else:
				curr_nums.append(rand_num)
	return curr_nums

func _calculate_weight_text(number_of_item1, number_of_item2, action_index):
	match action_index:
		0:
			return "Total Weight: "+str(PlayerData.resource_weight.feathers*number_of_item1)+" kgs"
		1:
			return "Total Weight: "+str(PlayerData.resource_weight.titanium*number_of_item1)+" kgs"
		2:
			return "Total Weight: "+str(PlayerData.resource_weight.cog_wheels*number_of_item1)+" kgs"
		3:
			return "Total Weight: "+str(PlayerData.resource_weight.elder_flowers*number_of_item1)+" kgs"
		4:
			return "Total Weight: "+(str(PlayerData.resource_weight.feathers*number_of_item1
			+PlayerData.resource_weight.elder_flowers*number_of_item2))+" kgs"
		5:
			return "Total Weight: "+(str(PlayerData.resource_weight.titanium*number_of_item1
			+PlayerData.resource_weight.cog_wheels*number_of_item2))+" kgs"
		_:
			return ""

func _recalculate_weight():
	var total_weight = 0
	total_weight += PlayerData.player_resources.feathers * PlayerData.resource_weight.feathers
	total_weight += PlayerData.player_resources.titanium * PlayerData.resource_weight.titanium
	total_weight += PlayerData.player_resources.cog_wheels * PlayerData.resource_weight.cog_wheels
	total_weight += PlayerData.player_resources.elder_flowers * PlayerData.resource_weight.elder_flowers
	return snappedf(total_weight,0.01)

func _init_action_info(index):
	var icon = icons[action_variants[action_nums[index]][0]]
	var text = (action_variants[action_nums[index]][1]
	+"\n\n[color=cyan]"+str(action_variants[action_nums[index]][2])+"[/color] Energy"
	+"\n[color=red]"+str(action_variants[action_nums[index]][3])+"[/color] Minutes"
	+"\n[color=orange]"+_calculate_weight_text(action_variants[action_nums[index]][4],action_variants[action_nums[index]][5],action_nums[index]))+"[/color]"
	
	match index:
		0:
			%Border1.modulate = Color(1,1,1,1)
			%Action1.disabled = false
			if (PlayerData.energy < action_variants[action_nums[index]][2] or
			 PlayerData.time_left < action_variants[action_nums[index]][3]):
				%Action1.disabled = true
				%Border1.modulate = Color(0.1,0.1,0.1,0.1)
				disabled_actions += 1
		1:
			%Border2.modulate = Color(1,1,1,1)
			%Action2.disabled = false
			if (PlayerData.energy < action_variants[action_nums[index]][2] or
			 PlayerData.time_left < action_variants[action_nums[index]][3]):
				%Action2.disabled = true
				%Border2.modulate = Color(0.1,0.1,0.1,0.1)
				disabled_actions += 1
		2:
			%Border3.modulate = Color(1,1,1,1)
			%Action3.disabled = false
			if (PlayerData.energy < action_variants[action_nums[index]][2] or
			 PlayerData.time_left < action_variants[action_nums[index]][3]):
				%Action3.disabled = true
				%Border3.modulate = Color(0.1,0.1,0.1,0.1)
				disabled_actions += 1

	return [icon,text] 
	
func _set_actions():
	
	action_nums = _choose_random_numbers()
	
	disabled_actions = 0
	var action1_info = _init_action_info(0)
	var action2_info = _init_action_info(1)
	var action3_info = _init_action_info(2)
	
	action1_icon.texture = action1_info[0]
	action1_description.text = action1_info[1]
	
	action2_icon.texture = action2_info[0]
	action2_description.text = action2_info[1]
	
	action3_icon.texture = action3_info[0]
	action3_description.text = action3_info[1]
	
	if disabled_actions == 3:
		no_actions = true

func _animate_background():
	var tween = create_tween()
	#tween.set_ease()
	#tween.set_trans()
	tween.tween_property(%Animation,"color",Color(103,0,197,0.3),1)
	tween.chain().tween_property(%Animation,"color",Color(103,0,197,0),1)
	
func _update_player_stats(energy,time):
	PlayerData.weight = _recalculate_weight()
	PlayerData.energy -= energy
	PlayerData.time_left -= time
	
func _evaluate_action(action_index):
	
	match action_index:
		0:
			PlayerData.player_resources.feathers = PlayerData.player_resources.feathers+120
		1:
			PlayerData.player_resources.titanium = PlayerData.player_resources.titanium+10
		2:
			PlayerData.player_resources.cog_wheels = PlayerData.player_resources.cog_wheels+15
		3:
			PlayerData.player_resources.elder_flowers = PlayerData.player_resources.elder_flowers+80
		4:
			PlayerData.player_resources.feathers = PlayerData.player_resources.feathers+60
			PlayerData.player_resources.elder_flowers = PlayerData.player_resources.elder_flowers+40
		5:
			PlayerData.player_resources.titanium = PlayerData.player_resources.titanium+5
			PlayerData.player_resources.cog_wheels = PlayerData.player_resources.cog_wheels+10
		6:
			PlayerData.player_resources.feathers = floor(PlayerData.player_resources.feathers*1.2)
			PlayerData.player_resources.titanium = floor(PlayerData.player_resources.titanium*1.2)
			PlayerData.player_resources.cog_wheels = floor(PlayerData.player_resources.cog_wheels*1.2)
			PlayerData.player_resources.elder_flowers = floor(PlayerData.player_resources.elder_flowers*1.2)
		7:
			PlayerData.player_resources.feathers = PlayerData.player_resources.feathers*3
		8:
			PlayerData.player_resources.elder_flowers = PlayerData.player_resources.elder_flowers*3
		9:
			PlayerData.player_stored_resources.titanium += floor(PlayerData.player_resources.titanium * 0.333)
			PlayerData.player_resources.titanium = floor(PlayerData.player_resources.titanium*0.667)
			_update_weight()
		10:
			PlayerData.max_weight += 10
		11:
			PlayerData.player_stored_resources.feathers += PlayerData.player_resources.feathers
			PlayerData.player_stored_resources.titanium += PlayerData.player_resources.titanium
			PlayerData.player_stored_resources.cog_wheels += PlayerData.player_resources.cog_wheels
			PlayerData.player_stored_resources.elder_flowers += PlayerData.player_resources.elder_flowers
			PlayerData.player_resources.feathers = 0
			PlayerData.player_resources.titanium = 0
			PlayerData.player_resources.cog_wheels = 0
			PlayerData.player_resources.elder_flowers = 0
			_update_weight()
		12:
			_set_actions()
		13:
			PlayerData.max_energy += 30
		14:
			PlayerData.player_resources.elder_flowers = floor(PlayerData.player_resources.feathers+
			PlayerData.player_resources.titanium+PlayerData.player_resources.cog_wheels+
			PlayerData.player_resources.elder_flowers)
			PlayerData.player_resources.feathers = 0
			PlayerData.player_resources.titanium = 0
			PlayerData.player_resources.cog_wheels = 0
			
	_update_player_stats(action_variants[action_index][2],action_variants[action_index][3])

func _update_weight():
	var total_weight = 0
	total_weight += PlayerData.player_resources.feathers * PlayerData.resource_weight.feathers
	total_weight += PlayerData.player_resources.titanium * PlayerData.resource_weight.titanium
	total_weight += PlayerData.player_resources.cog_wheels * PlayerData.resource_weight.cog_wheels
	total_weight += PlayerData.player_resources.elder_flowers * PlayerData.resource_weight.elder_flowers
	PlayerData.weight = total_weight
			
func _on_action_1_pressed():
	_animate_background()
	_evaluate_action(action_nums[0])
	_set_actions()


func _on_action_2_pressed():
	_animate_background()
	_evaluate_action(action_nums[1])
	_set_actions()


func _on_action_3_pressed():
	_animate_background()
	_evaluate_action(action_nums[2])
	_set_actions()
