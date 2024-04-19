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


func _rerady():
	match hook_sprite:
		Hook.IRON:
			hook.frame(0)
		Hook.ALUMINIUM:
			hook.frame(1)
		Hook.BRONCE:
			hook.frame(2)
	
	match line_sprite:
		Line.STRING:
			$Control/HBoxContainer/TextureRect.visibile = true
			$Control/HBoxContainer/TextureRect2.visible = false
			$Control/HBoxContainer/TextureRect3.visible = false
			$Control/HBoxContainer/TextureRect4.visible = false
		Line.NORMAL:
			pass
		Line.HIGHTEST:
			pass
		Line.REINFORCED:
			pass
	
	match sinker_sprite:
		Sinker.SPLITSHOT:
			sinker.frame(3)
		Sinker.DIPSEY:
			sinker.frame(4)
		Sinker.DIAMOND:
			sinker.frame(5)


func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	
	velocity = input.normalized() * speed
	
	move_and_slide()
