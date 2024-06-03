extends CharacterBody2D

@export var speed:float = 30
@onready var speed_multiplyer = 1.0
@onready var hook = $HookSprite2D
@onready var line = $Control/HBoxContainer
@onready var sinker = $SinkerSprite2D
@export var ocean_scene:Node2D
@export var ocean_code:GDScript
@onready var clownfish = $HookSprite2D/ClownfishSprite2D

var mouse_position:Vector2
var line_strength
var size

func _ready():
	if Globals.hook_state == 1:
		hook.set_frame(0)
		speed = 30
	elif Globals.hook_state == 2:
		hook.set_frame(1)
		speed = 60
	elif Globals.hook_state == 3:
		hook.set_frame(2)
		speed = 90
	
	if Globals.line_state == 1:
		$Control/HBoxContainer/TextureRect.visible = true
		$Control/HBoxContainer/TextureRect2.visible = false
		$Control/HBoxContainer/TextureRect3.visible = false
		$Control/HBoxContainer/TextureRect4.visible = false
		line_strength = 1
	elif Globals.line_state == 2:
		$Control/HBoxContainer/TextureRect.visible = false
		$Control/HBoxContainer/TextureRect2.visible = true
		$Control/HBoxContainer/TextureRect3.visible = false
		$Control/HBoxContainer/TextureRect4.visible = false
		line_strength = 2
	elif Globals.line_state == 3:
		$Control/HBoxContainer/TextureRect.visible = false
		$Control/HBoxContainer/TextureRect2.visible = false
		$Control/HBoxContainer/TextureRect3.visible = true
		$Control/HBoxContainer/TextureRect4.visible = false
		line_strength = 3
	elif Globals.line_state == 4:
		$Control/HBoxContainer/TextureRect.visible = false
		$Control/HBoxContainer/TextureRect2.visible = false
		$Control/HBoxContainer/TextureRect3.visible = false
		$Control/HBoxContainer/TextureRect4.visible = true
		line_strength = 4
	
	if Globals.sinker_state == 1:
		sinker.set_frame(3)
		ocean_scene.speed = 15
	elif Globals.sinker_state == 2:
		sinker.set_frame(4)
		ocean_scene.speed = 20
	elif Globals.sinker_state == 3:
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
	velocity = input.normalized() * speed * speed_multiplyer
	
	move_and_slide()

func fish_caught(fish):
	if fish == "clownfish":
		$HookSprite2D/ClownfishSprite2D.visible = true
	elif fish == "pyramid":
		pass
	elif fish == "seargant":
		pass
	elif fish == "grubfish":
		pass
	elif fish == "moonfish":
		pass
	elif fish == "birdnosed":
		pass
	elif fish == "triggerfish":
		pass
	elif fish == "lunar":
		pass
	elif fish == "flyingfish":
		pass
	elif fish == "herring":
		$HookSprite2D/ClownfishSprite2D.visible = false
		$HookSprite2D/WolfHerringSprite2D.visible = true
	elif fish == "mahi":
		pass
	elif fish == "spearfish":
		pass
	elif fish == "humphead":
		pass
	elif fish == "yellowfin":
		pass
	elif fish == "baracuda":
		pass
	elif fish == "shortfin":
		pass
	elif fish == "gemfish":
		pass
	elif fish == "marlin":
		pass
	elif fish == "tiger":
		pass
	
	print(fish," cught")
	print(size)
	if size == 0:
		speed_multiplyer = 1.0
	elif size == 1:
		speed_multiplyer = 0.9
	elif size == 2:
		speed_multiplyer = 0.8
	elif size == 3:
		speed_multiplyer = 0.7
	elif size == 4:
		speed_multiplyer = 0.6
	elif size == 5:
		speed_multiplyer = 0.5
