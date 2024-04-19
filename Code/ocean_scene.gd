extends Node2D

@export var speed = 15
@onready var surface_position = global_position
@onready var DepthCharge = $DepthCharge
@onready var hook_empty = true

enum State{SINKING,RISING}
var state = State.SINKING
var player

func _physics_process(delta):
	match state:
		State.SINKING:
			DepthCharge.position.y +=1*speed*delta
		State.RISING:
			DepthCharge.position.y -=1*speed*delta
	
	if hook_empty:
		State.SINKING
	else:
		State.RISING

