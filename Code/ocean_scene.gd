extends Node2D

@export var speed = 15
@onready var surface_position = global_position
@onready var DepthCharge = $DepthCharge
@onready var hook_empty = true
@onready var death_zone = $Deathzone_Area2D
@onready var catch_size:int = 0

enum State{SINKING,RISING}
var state = State.SINKING
var players

func _physics_process(delta):
	match state:
		State.SINKING:
			DepthCharge.position.y +=1*speed*delta
		State.RISING:
			DepthCharge.position.y -=1*speed*delta
	
	if hook_empty:
		state = State.SINKING
	else:
		state = State.RISING

func _on_goal_area_2d_body_entered(body):
	fish_caught()


func _on_deathzone_area_2d_body_entered(body):
	game_over()

func fish_caught():
	print("Fish Caught")


func game_over():
	print("Game Over")
	
