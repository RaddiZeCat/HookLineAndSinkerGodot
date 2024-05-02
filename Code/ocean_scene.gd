extends Node2D

@export var speed = 15
@onready var surface_position = global_position
@onready var DepthCharge = $DepthCharge
@onready var hook_empty = true
@onready var death_zone = $Deathzone_Area2D
@onready var catch_size:int = 0
@onready var pause_menu = $"Camera2D/Control/Menu Paused"
@onready var game_over_screen = $"Camera2D/Control/Game Over Menu"
@onready var fish_caught_screen = $"Camera2D/Control/Fish Caught Menu"
@onready var fish_cught_text = $"Camera2D/Control/Fish Caught Menu/RichTextLabel"

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
	get_tree().paused = true
	fish_caught_screen.show()
	$Camera2D/Control/ButtonPause.visible = false
	fish_cught_text.add_text("The fish has been caught")


func game_over():
	get_tree().paused = true
	game_over_screen.show()
	$Camera2D/Control/ButtonPause.visible = false


func _on_button_pause_pressed():
	$Camera2D/Control/ButtonPause.visible=false
	get_tree().paused = true
	pause_menu.show()


func _on_button_unpause_pressed():
	pause_menu.hide()
	$Camera2D/Control/ButtonPause.visible=true
	get_tree().paused = false
