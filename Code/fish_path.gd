extends Node2D

@onready var path_follow : PathFollow2D = $PathFollow2D
@export var speed:float = 10

func _process(delta):
	path_follow.progress += speed*delta
