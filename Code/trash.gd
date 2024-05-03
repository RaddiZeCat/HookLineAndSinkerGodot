extends Sprite2D

@onready var ocean_scene = $"../.."
@onready var zero = global_position.y
@export var speed = 1
@export var deviation = 2

enum State{RISE,SINK}
@export var state = State.RISE


func _physics_process(delta):
	match state:
		State.RISE:
			if position.y <= zero-deviation:
				state = State.SINK
			else:
				position.y -=deviation*speed*delta
		State.SINK:
			if position.y >= zero+deviation:
				state =State.RISE
			else:
				position.y +=deviation*speed*delta


func _on_area_2d_body_entered(body):
	ocean_scene.game_over()
