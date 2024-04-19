extends CharacterBody2D

@export var speed:float = 30

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	
	velocity = input.normalized() * speed
	
	move_and_slide()
