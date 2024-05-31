extends Node2D


@export var ocean_scene = "res://Maps/ocean_scene.tscn"
@export var main_menu = "res://Maps/main_menu.tscn"

func _ready():
	get_tree().paused = false

func _on_button_pressed():
	reset()
	SceneSwitcher.switch_scene(ocean_scene)
	print(ocean_scene)


func _on_button_2_pressed():
	reset()
	SceneSwitcher.switch_scene(main_menu)
	print(main_menu)

func reset():
	Globals.hook_state = 1		#max 3
	Globals.line_state = 1		#max 4
	Globals.sinker_state = 1 	#max 3

	Globals.money = 200		#currency
	Globals.boat_owned = false	#if true disable running costs
	
	Globals.hook_2_owned = false
	Globals.hook_3_owned = false
	Globals.line_2_owned = false
	Globals.line_3_owned = false
	Globals.line_4_owned = false
	Globals.sinker_2_owned = false
	Globals.sinker_3_owned = false
	print("reset")