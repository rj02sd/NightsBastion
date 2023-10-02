extends Control

@export var index:int
@export var disabled = false
@export var icon:CompressedTexture2D
@export var weapon_name:String
@export var feather_cost:int
@export var titanium_cost:int
@export var cogwheel_cost:int
@export var elderflower_cost:int

var is_valid = false
var num_resources_required = 4

func _ready():
		
	if ((feather_cost <= PlayerData.player_resources.feathers
		+PlayerData.player_stored_resources.feathers) and 
		(titanium_cost <= PlayerData.player_resources.titanium
		+PlayerData.player_stored_resources.titanium) and
		(cogwheel_cost <= PlayerData.player_resources.cog_wheels
		+PlayerData.player_stored_resources.cog_wheels) and
		(elderflower_cost <= PlayerData.player_resources.elder_flowers
		+PlayerData.player_stored_resources.elder_flowers)):
		is_valid = true
	else:
		is_valid = false
	
	if is_valid:
		%IsValid.color = Color(0,255,0,1)
	else:
		%IsValid.color = Color(255,0,0,1)
	%IsValid/Name.text = weapon_name
	%Icon.texture = icon
	
	%Icon/ResourceIcons/R1/Label1.text = str(feather_cost)
	%Icon/ResourceIcons/R2/Label2.text = str(titanium_cost)
	%Icon/ResourceIcons/R3/Label3.text = str(cogwheel_cost)
	%Icon/ResourceIcons/R4/Label4.text = str(elderflower_cost)
	
	if feather_cost == 0:
		%Icon/ResourceIcons/R1.visible = false
		num_resources_required -= 1
	if titanium_cost == 0:
		%Icon/ResourceIcons/R2.visible = false
		num_resources_required -= 1
	if cogwheel_cost == 0:
		%Icon/ResourceIcons/R3.visible = false
		num_resources_required -= 1
	if elderflower_cost == 0:
		%Icon/ResourceIcons/R4.visible = false
		num_resources_required -= 1
	
	%Icon/ResourceIcons.size.y = num_resources_required * 25
	if num_resources_required == 0 and not disabled:
		%Free.visible = true
	if disabled:
		%Unknown.visible = true
		%Icon.modulate = Color(0.1,0.1,0.1,0.5)
		%Item_Preview.visible = false
		%IsValid.color = Color(0.1,0.1,0.1,1)


func _on_item_preview_pressed():
	PlayerData.item_preview_clicked = index
	get_tree().change_scene_to_file("res://scenes/item_previewer.tscn")
