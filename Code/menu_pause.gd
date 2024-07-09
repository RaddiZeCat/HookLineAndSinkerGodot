extends Control

@onready var scene = $"../.."

func _input(event):
	if Input.is_action_pressed("pause_game"):
		scene.pause_game()
