extends Node2D

@export var speed = 10
@onready var surface_position = global_position
@onready var DepthCharge = $DepthCharge

enum State{SINKING,RISING}
var state = State.SINKING
var player

func _physics_process(delta):
	match state:
		State.SINKING:
			DepthCharge.position.y +=1*speed*delta
			print(DepthCharge.position)
		State.RISING:
			DepthCharge.position.y -=1*speed*delta
			print(DepthCharge.position)
	
	

