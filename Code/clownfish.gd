extends CharacterBody2D

@export var speed:float = 10
@export var PathPoint:PathFollow2D
@export var fish = "clownfish"
@export var size:int = 1
@onready var animation_player = $Sprite2D/AnimationPlayer
@onready var path_point = PathPoint
@onready var ocean_scene = $"../../.."
@onready var visualization = $Sprite2D2/AnimationPlayer

enum State{PATROL,CHASE}
var state = State.PATROL
var hook

func _ready():
	visualization.play("none")

func _physics_process(delta):
	animation_player.play("Swim")
	match state:
		State.PATROL:
			position = position.move_toward(path_point.position,speed*delta)
			if position.x - path_point.position.x < 0.0000:
				$Sprite2D.flip_h = true
			elif position.x - path_point.position.x > 0.0000:
				$Sprite2D.flip_h = false
		State.CHASE:
			position = position.move_toward(hook.position,speed*1.5*delta)
			if position.x - hook.position.x < 0.0000:
				$Sprite2D.flip_h = true
			elif position.x - hook.position.x > 0.0000:
				$Sprite2D.flip_h = false
	#print(fish," ",position.x - path_point.position.x)
	move_and_slide()

func _on_eyes_area_2d_body_entered(body):
	if size > 1:
		if ocean_scene.catch_size == size-1:
			hook = body
			state = State.CHASE
			$Sprite2D2.visible = true
			visualization.play("attack")
		else:
			visualization.play("bored")
	else:
		if ocean_scene.hook_empty == true:
			hook = body
			state = State.CHASE
			$Sprite2D2.visible = true
			visualization.play("attack")
		else:
			visualization.play("bored")

func _on_eyes_area_2d_body_exited(body):
	if state == State.CHASE:
		visualization.play("anger")
	hook = null
	state = State.PATROL



func _on_catch_area_2d_body_entered(body): 
	if ocean_scene.catch_size == size-1:
		if body.line_strength >= size:
			body.size = size
			body.fish_caught(fish)
			ocean_scene.fish = fish
			ocean_scene.hook_empty = false
			ocean_scene.catch_size = size
			queue_free()
		else:
			ocean_scene.game_over()
	else:
		visualization.play("anger")
