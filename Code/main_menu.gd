extends Node2D

@export var ocean_scene = "res://Maps/ocean_scene.tscn"


func _on_button_pressed():
	SceneSwitcher.switch_scene(ocean_scene)
	#get_tree().change_scene_to_file(ocean_scene)
	print(ocean_scene)