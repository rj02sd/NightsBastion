extends CanvasLayer

var item_index = -1
var weight_preview = 0.0
var potions = 0

var mod1_val = 0
var mod2_val = 0
var mod3_val = 0

func _ready():
	
	if not PlayerData.resources_gathered:
		%Craft.disabled = true
	else:
		%Craft.disabled = false
	
	item_index = PlayerData.item_preview_clicked
	
	if item_index != -1:	
		%Name.text = ItemDefinitions.items[item_index][0]
		%Icon.texture = ItemDefinitions.items[item_index][3]
		%Description.text = ItemDefinitions.items[item_index][2].description	
		%Weight.text = "Weight: "+str(ItemDefinitions.items[item_index][2].weight)+" kgs"
		weight_preview = ItemDefinitions.items[item_index][2].weight
		if ItemDefinitions.items[item_index][1] == 1:
			weight_preview = 0
			%AutoAttack.visible = false
			%Ability1.visible = false
			%Ability2.visible = false
			%Mod1.visible = false
			%Mod2.visible = false
			%Mod3.visible = false
			%Mods.visible = false
			%x1.visible = true
			%x3.visible = true
			%x5.visible = true
			%x10.visible = true
			%Potions.visible = true
			%Stats.visible = false
		else:
			%AutoAttack.text = "Attack: "+ItemDefinitions.items[item_index][2].attack
			%Ability1.text = "Ability 1: "+ItemDefinitions.items[item_index][2].ability1
			%Ability2.text = "Ability 2: "+ItemDefinitions.items[item_index][2].ability2


func _process(_delta):
	%WeightProgress.max_value = PlayerData.combat_max_weight
	%WeightProgress.value = PlayerData.combat_weight + weight_preview
	%WeightProgress.get_child(0).text = "POST PURCHASE WEIGHT: "+str(PlayerData.combat_weight + weight_preview)+" kgs"
	%Potions.text = str(potions)
	
	if item_index == 0:	
		mod1_val = %Mod1.mod_amp*ItemDefinitions.items[item_index][2].amp_multiplier * 0.5
		mod2_val = %Mod2.mod_amp*ItemDefinitions.items[item_index][2].amp_multiplier * -0.05
		mod3_val = %Mod3.mod_amp*ItemDefinitions.items[item_index][2].amp_multiplier * 0.1
		%Stats.text = ("ATTACK DAMAGE (ATK): "+str(ItemDefinitions.items[item_index][2].atk_base+mod1_val)+
		"\nATTACK SPEED (SPD): "+str(ItemDefinitions.items[item_index][2].spd_base+mod2_val)+
		"\nMANA EFFECIENCY (EFF): "+str(ItemDefinitions.items[item_index][2].eff_base+mod3_val))
	
	if (PlayerData.combat_weight + weight_preview) > PlayerData.combat_max_weight:
		%Craft.disabled = true
	elif PlayerData.resources_gathered:
		%Craft.disabled = false
	
	if ItemDefinitions.items[item_index][1] == 0:
		if not ((ItemDefinitions.items[item_index][2].feather_cost <= 
		PlayerData.player_resources.feathers + PlayerData.player_stored_resources.feathers) and 
		(ItemDefinitions.items[item_index][2].titanium_cost <= 
		PlayerData.player_resources.titanium + PlayerData.player_stored_resources.titanium) and 
		(ItemDefinitions.items[item_index][2].cogwheel_cost <=
		PlayerData.player_resources.cog_wheels + PlayerData.player_stored_resources.cog_wheels) and 
		(ItemDefinitions.items[item_index][2].elderflower_cost <= 
		PlayerData.player_resources.elder_flowers + PlayerData.player_stored_resources.elder_flowers)):
			%Craft.disabled = true
		elif PlayerData.resources_gathered:
			%Craft.disabled = false
	
	if ItemDefinitions.items[item_index][1] == 1:
		if not ((ItemDefinitions.items[item_index][2].feather_cost*potions <= 
		(PlayerData.player_resources.feathers + PlayerData.player_stored_resources.feathers)) and 
		(ItemDefinitions.items[item_index][2].titanium_cost*potions <= 
		(PlayerData.player_resources.titanium + PlayerData.player_stored_resources.titanium)) and 
		(ItemDefinitions.items[item_index][2].cogwheel_cost*potions <=
		(PlayerData.player_resources.cog_wheels + PlayerData.player_stored_resources.cog_wheels)) and 
		(ItemDefinitions.items[item_index][2].elderflower_cost*potions <= 
		(PlayerData.player_resources.elder_flowers + PlayerData.player_stored_resources.elder_flowers))):
			%Craft.disabled = true
		elif PlayerData.resources_gathered:
			%Craft.disabled = false
	

func _on_back_pressed():
	if not PlayerData.resources_gathered:
		get_tree().change_scene_to_file("res://scenes/component_gathering.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_craft_pressed():
	if ItemDefinitions.items[item_index][1] == 0:
		PlayerData.weapon_crafted = true
		PlayerData.weapon_type_bought = item_index
	elif item_index == 3:
		PlayerData.health_potions += potions
	elif item_index == 4:
		PlayerData.mana_potions += potions
	PlayerData.combat_weight += weight_preview
		
	PlayerData.player_resources.feathers += PlayerData.player_stored_resources.feathers
	PlayerData.player_resources.titanium += PlayerData.player_stored_resources.titanium
	PlayerData.player_resources.cog_wheels += PlayerData.player_stored_resources.cog_wheels
	PlayerData.player_resources.elder_flowers += PlayerData.player_stored_resources.elder_flowers
	
	PlayerData.player_stored_resources.feathers = 0
	PlayerData.player_stored_resources.titanium = 0
	PlayerData.player_stored_resources.cog_wheels = 0
	PlayerData.player_stored_resources.elder_flowers= 0
	
	if ItemDefinitions.items[item_index][1] == 0:
		PlayerData.player_resources.feathers -= ItemDefinitions.items[item_index][2].feather_cost
		PlayerData.player_resources.titanium -= ItemDefinitions.items[item_index][2].titanium_cost
		PlayerData.player_resources.cog_wheels -= ItemDefinitions.items[item_index][2].cogwheel_cost
		PlayerData.player_resources.elder_flowers -= ItemDefinitions.items[item_index][2].elderflower_cost
		ItemDefinitions.items[item_index][2].atk_base += mod1_val
		ItemDefinitions.items[item_index][2].spd_base += mod2_val
		ItemDefinitions.items[item_index][2].eff_base += mod3_val
		
	if ItemDefinitions.items[item_index][1] == 1:
		PlayerData.player_resources.feathers -= ItemDefinitions.items[item_index][2].feather_cost * potions
		PlayerData.player_resources.titanium -= ItemDefinitions.items[item_index][2].titanium_cost * potions
		PlayerData.player_resources.cog_wheels -= ItemDefinitions.items[item_index][2].cogwheel_cost * potions
		PlayerData.player_resources.elder_flowers -= ItemDefinitions.items[item_index][2].elderflower_cost * potions
	
	get_tree().change_scene_to_file("res://scenes/item_crafting.tscn")


func _on_x_3_pressed():
	weight_preview += ItemDefinitions.items[item_index][2].weight * 3
	potions += 3

func _on_x_5_pressed():
	weight_preview += ItemDefinitions.items[item_index][2].weight * 5
	potions += 5

func _on_x_10_pressed():
	weight_preview += ItemDefinitions.items[item_index][2].weight * 10
	potions += 10

func _on_x_1_pressed():
	weight_preview += ItemDefinitions.items[item_index][2].weight
	potions += 1
