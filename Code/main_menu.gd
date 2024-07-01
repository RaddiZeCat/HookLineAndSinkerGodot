extends Node2D

@export var ocean_scene = "res://Maps/ocean_scene.tscn"

var normal_save = "user://normal.save"
var casual_save = "user://casual.save"

func _ready():
	get_tree().paused = false

func _on_button_pressed(): #play normal
	click()
	Globals.current_save = normal_save
	Globals.load_game()
	Globals.boat_owned = false
	SceneSwitcher.switch_scene(ocean_scene)
	#get_tree().change_scene_to_file(ocean_scene)
	print(ocean_scene)

func _on_button_2_pressed(): #play casual
	click()
	Globals.current_save = casual_save
	Globals.load_game()
	Globals.boat_owned = true
	SceneSwitcher.switch_scene(ocean_scene)
	#get_tree().change_scene_to_file(ocean_scene)
	print(ocean_scene)


func _on_button_3_pressed(): #quit
	get_tree().quit()

func click():
	$AudioStreamPlayer2.play()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_button_4_pressed(): #reset normal
	reset()
	Globals.current_save = normal_save
	Globals.save_game()
	click()


func _on_button_5_pressed(): #reset casual
	reset()
	Globals.current_save = casual_save
	Globals.save_game()
	click()

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
