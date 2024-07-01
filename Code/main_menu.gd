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
