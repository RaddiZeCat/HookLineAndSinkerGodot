extends CharacterBody2D

@export var speed:float = 30
@onready var hook = $HookSprite2D
@onready var line = $Control/HBoxContainer
@onready var sinker = $SinkerSprite2D
@export var ocean_scene:Node2D
@onready var clownfish = $HookSprite2D/ClownfishSprite2D

enum Hook{IRON,ALUMINIUM,BRONCE}
enum Line{STRING,NORMAL,HIGHTEST,REINFORCED}
enum Sinker{SPLITSHOT,DIPSEY,DIAMOND}
var hook_sprite = Hook.IRON
var line_sprite = Line.STRING
var sinker_sprite = Sinker.SPLITSHOT
var mouse_position:Vector2
var line_strength

func _ready():
	match hook_sprite:
		Hook.IRON:
			hook.set_frame(0)
		Hook.ALUMINIUM:
			hook.set_frame(1)
			speed = 60
		Hook.BRONCE:
			hook.set_frame(2)
			speed = 90
	
	match line_sprite:
		Line.STRING:
			$Control/HBoxContainer/TextureRect.visible = true
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = false
			line_strength = 1
		Line.NORMAL:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible = true
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = false
			line_strength = 2
		Line.HIGHTEST:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = true
			$Control/HBoxContainer/TextureRect4.visible = false
			line_strength = 3
		Line.REINFORCED:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = true
			line_strength = 4
	
	match sinker_sprite:
		Sinker.SPLITSHOT:
			sinker.set_frame(3)
		Sinker.DIPSEY:
			sinker.set_frame(4)
			ocean_scene.speed = 20
		Sinker.DIAMOND:
			sinker.set_frame(5)
			ocean_scene.speed = 30

#func _input(event):
	#if event.is_action_pressed("click_mouse"):
		#mouse_position = get_global_mouse_position()


func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	#position = position.move_toward(mouse_position,speed*delta)
	velocity = input.normalized() * speed
	
	move_and_slide()

func fish_caught(fish):
	if fish == "clownfish":
		$HookSprite2D/ClownfishSprite2D.visible = true
	elif fish == "wolf_herring":
		$HookSprite2D/ClownfishSprite2D.visible = false
		$HookSprite2D/WolfHerringSprite2D.visible = true
	else:
		pass
	print(fish," cught")
