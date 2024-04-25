extends CharacterBody2D

@export var speed:float = 30
@onready var hook = $HookSprite2D
@onready var line = $Control/HBoxContainer
@onready var sinker = $SinkerSprite2D

enum Hook{IRON,ALUMINIUM,BRONCE}
enum Line{STRING,NORMAL,HIGHTEST,REINFORCED}
enum Sinker{SPLITSHOT,DIPSEY,DIAMOND}
var hook_sprite = Hook.IRON
var line_sprite = Line.STRING
var sinker_sprite = Sinker.SPLITSHOT
var mouse_position:Vector2


func _ready():
	match hook_sprite:
		Hook.IRON:
			hook.set_frame(0)
		Hook.ALUMINIUM:
			hook.set_frame(1)
		Hook.BRONCE:
			hook.set_frame(2)
	
	match line_sprite:
		Line.STRING:
			$Control/HBoxContainer/TextureRect.visible
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = false
		Line.NORMAL:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = false
		Line.HIGHTEST:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible
			$Control/HBoxContainer/TextureRect4.visible = false
		Line.REINFORCED:
			$Control/HBoxContainer/TextureRect.visible = false
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible
	
	match sinker_sprite:
		Sinker.SPLITSHOT:
			sinker.set_frame(3)
		Sinker.DIPSEY:
			sinker.set_frame(4)
		Sinker.DIAMOND:
			sinker.set_frame(5)

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
