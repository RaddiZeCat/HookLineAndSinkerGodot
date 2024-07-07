extends Node2D

@export var ocean_scene = "res://Maps/ocean_scene.tscn"

var normal_save = "user://normal.save"
var casual_save = "user://casual.save"
var volume

func _ready():
	get_tree().paused = false
	Globals.load_options()
	

func _on_button_pressed(): #play normal
	click()
	Globals.current_save = normal_save
	Globals.load_game()
	Globals.boat_owned = false
	SceneSwitcher.switch_scene(ocean_scene)
	#get_tree().change_scene_to_file(ocean_scene)
	print(ocean_scene)

func _on_button_2_pressed(): #play casual
	if FileAccess.file_exists(casual_save):
		pass
	else:
		Globals.money = 0
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
	Globals.current_save = normal_save
	reset()
	Globals.save_game()
	click()


func _on_button_5_pressed(): #reset casual
	Globals.current_save = casual_save
	reset()
	Globals.money=0
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


func _on_button_6_pressed(): #Options
	click()
	$Camera2D/ControlOptions/VBoxContainer/HSliderMaster.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$Camera2D/ControlOptions/VBoxContainer/HSliderMusic.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$Camera2D/ControlOptions/VBoxContainer/HSliderSound.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound")))
	$Camera2D/Control.visible = false
	$Camera2D/ControlOptions.visible = true


func _on_h_slider_master_drag_ended(value_changed):
	volume = $Camera2D/ControlOptions/VBoxContainer/HSliderMaster.get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),volume)


func _on_h_slider_music_drag_ended(value_changed):
	volume = $Camera2D/ControlOptions/VBoxContainer/HSliderMusic.get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),volume)


func _on_h_slider_sound_drag_ended(value_changed):
	volume = $Camera2D/ControlOptions/VBoxContainer/HSliderSound.get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),volume)


func _on_button_back_pressed():
	click()
	$Camera2D/Control.visible = true
	$Camera2D/ControlOptions.visible = false
	Globals.save_options()
