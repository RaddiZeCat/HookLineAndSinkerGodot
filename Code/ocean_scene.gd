extends Node2D

@onready var main_menu = "res://Maps/main_menu.tscn"
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

func _ready():
	SceneSwitcher.reload()

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


func _on_button_pressed():
	SceneSwitcher.switch_scene(main_menu)
	#get_tree().change_scene_to_file(main_menu)


func _on_button_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_main_menu_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)
	#get_tree().change_scene_to_file(main_menu)


func _on_button_recast_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_main_menu_2_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)
	#get_tree().change_scene_to_file(main_menu)
