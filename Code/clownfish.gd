extends CharacterBody2D

@export var speed:float = 10
@export var PathPoint:PathFollow2D
@onready var animation_player = $Sprite2D/AnimationPlayer
@onready var path_point = PathPoint

enum State{PATROL,CHASE}
var state = State.PATROL
var hook

func _physics_process(delta):
	animation_player.play("Swim")
	match state:
		State.PATROL:
			position = position.move_toward(path_point.position,speed*delta)
			pass
		State.CHASE:
			position = position.move_toward(hook.position,speed*1.5*delta)
			pass
	move_and_slide()

func _on_eyes_area_2d_body_entered(body):
	hook = body
	state = State.CHASE


func _on_eyes_area_2d_body_exited(body):
	hook = null
	state = State.PATROL



func _on_catch_area_2d_body_entered(body):
	pass # Replace with function body.
