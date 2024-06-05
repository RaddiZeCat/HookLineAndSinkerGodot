extends Node2D

@onready var main_menu = "res://Maps/main_menu.tscn"
@onready var game_over_menu = "res://Maps/game_over_menu.tscn"
@onready var win_menu
@export var speed = 15
@onready var surface_position = global_position
@onready var DepthCharge = $DepthCharge
@onready var hook_empty = true
@onready var death_zone = $Deathzone_Area2D
@onready var catch_size:int = 0
@onready var pause_menu = $"Camera2D/Control/Menu Paused"
@onready var game_over_screen = $"Camera2D/Control/Game Over Menu"
@onready var shop_menu = $"Camera2D/Control/Shop Menu"
@onready var fish_caught_screen = $"Camera2D/Control/Fish Caught Menu"
@onready var fish_cught_text = $"Camera2D/Control/Fish Caught Menu/VBoxContainer/RichTextLabel2"
@onready var money_text = $"Camera2D/Control/Fish Caught Menu/VBoxContainer/RichTextLabel2"
@onready var purse = $"Camera2D/Control/Shop Menu/Shop Purse"
@onready var ingame_purse = $"Camera2D/Control/Ingame Purse"
@onready var boat_text_1 = $"Camera2D/Control/Game Over Menu/Boat Cost Text"
@onready var boat_text_2 = $"Camera2D/Control/Fish Caught Menu/VBoxContainer/Boat Cost Text2"


enum State{SINKING,RISING}
var state = State.SINKING
var players
var fish
var money

func _ready():
	SceneSwitcher.reload()
	money = str(Globals.money)
	ingame_purse.add_text(money)
	ingame_purse.add_text("$")
	

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

# Win and Loose

func fish_caught():
	print(fish)
	fish_caught_screen.show()
	$Camera2D/Control/ButtonPause.visible = false
	#use fish to dertermine money gathered and declare fish values here (exmp. clownfish = 10)
	if fish == "clownfish":
		Globals.money = Globals.money + 10
		money_text.add_text("and got 10$")
		print(Globals.money)
	elif fish == "pyramid":
		Globals.money = Globals.money + 19
		money_text.add_text("and got 19$")
	elif fish == "seargant":
		Globals.money = Globals.money + 24
		money_text.add_text("and got 24$")
	elif fish == "grubfish":
		Globals.money = Globals.money + 28
		money_text.add_text("and got 28$")
	elif fish == "moonfish":
		Globals.money = Globals.money + 34
		money_text.add_text("and got 34$")
	elif fish == "birdnosed":
		Globals.money = Globals.money + 39
		money_text.add_text("and got 39$")
	elif fish == "triggerfish":
		Globals.money = Globals.money + 43
		money_text.add_text("and got 43$")
	elif fish == "lunar":
		Globals.money = Globals.money + 48
		money_text.add_text("and got 48$")
	elif fish == "flyingfish":
		Globals.money = Globals.money + 50
		money_text.add_text("and got 50$")
	elif fish == "herring":
		Globals.money = Globals.money + 60
		money_text.add_text("and got 60$")
	elif fish == "mahi":
		Globals.money = Globals.money + 72
		money_text.add_text("and got 72$")
	elif fish == "spearfish":
		Globals.money = Globals.money + 86
		money_text.add_text("and got 86$")
	elif fish == "humphead":
		Globals.money = Globals.money + 98
		money_text.add_text("and got 98$")
	elif fish == "yellowfin":
		Globals.money = Globals.money + 109
		money_text.add_text("and got 109$")
	elif fish == "baracuda":
		Globals.money = Globals.money + 121
		money_text.add_text("and got 121$")
	elif fish == "shortfin":
		Globals.money = Globals.money + 138
		money_text.add_text("and got 138$")
	elif fish == "gemfish":
		Globals.money = Globals.money + 146
		money_text.add_text("and got 146$")
	elif fish == "marlin":
		Globals.money = Globals.money + 165
		money_text.add_text("and got 165$")
	elif fish == "tiger":
		Globals.money = Globals.money + 200
		money_text.add_text("and got 200$")
	else:
		print("No fish found. Check if the fish is spelled correctly.")
	get_tree().paused = true
	if Globals.boat_owned == false:
		Globals.money = Globals.money - 30
		boat_text_2.visible = true
	else:
		pass
	ingame_purse.visible = false
	if Globals.money <= 0:
		print("Broke")
		SceneSwitcher.switch_scene(game_over_menu)


func game_over():
	get_tree().paused = true
	if Globals.boat_owned == false:
		Globals.money = Globals.money - 30
		boat_text_1.visible = true
	else:
		pass
	game_over_screen.show()
	$Camera2D/Control/ButtonPause.visible = false
	ingame_purse.visible = false
	if Globals.money <= 0:
		print("Broke")
		SceneSwitcher.switch_scene(game_over_menu)

# UI Screens after this
# ingame pause button
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

# Shop Menu after this
# open shop menu

func _on_shop_button_2_pressed():
	$Camera2D/Control/ButtonPause.visible=false
	game_over_screen.hide()
	shop_menu.show()
	money = str(Globals.money)
	purse.add_text(money)
	purse.add_text("$")


func _on_shop_button_3_pressed():
	$Camera2D/Control/ButtonPause.visible=false
	fish_caught_screen.hide()
	shop_menu.show()
	money = str(Globals.money)
	purse.add_text(money)
	purse.add_text("$")

# buttons from shop
func _on_button_play_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_menu_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)

# buttons to change equipment
# visual indication that they are still locked & prices

# hooks
func _on_button_iron_hook_pressed():
	Globals.hook_state = 1
	print(Globals.hook_state)


func _on_button_aluminum_hook_pressed():
	if Globals.hook_2_owned == true:
		Globals.hook_state = 2
	elif Globals.money >= 300:
		Globals.money = Globals.money -300
		Globals.hook_2_owned = true
		Globals.hook_state = 2
	else:
		print("broke") #error noise
	print(Globals.hook_state)


func _on_button_brass_hook_pressed():
	if Globals.hook_3_owned == true:
		Globals.hook_state = 3
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.hook_3_owned = true
		Globals.hook_state = 3
	else:
		print("broke") #error noise
	print(Globals.hook_state)

# sinkers
func _on_button_splitshot_pressed():
	Globals.sinker_state = 1
	print(Globals.sinker_state)


func _on_button_dipsey_pressed():
	if Globals.sinker_2_owned == true:
		Globals.sinker_state = 2
	elif Globals.money >= 500:
		Globals.money = Globals.money -500
		Globals.sinker_2_owned = true
		Globals.sinker_state = 2
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

func _on_button_diamond_pressed():
	if Globals.sinker_3_owned == true:
		Globals.sinker_state = 3
	elif Globals.money >= 700:
		Globals.money = Globals.money -700
		Globals.sinker_3_owned = true
		Globals.sinker_state = 3
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

# lines
func _on_button_string_pressed():
	Globals.line_state = 1
	print(Globals.line_state)


func _on_button_line_pressed():
	if Globals.line_2_owned == true:
		Globals.line_state = 2
	elif Globals.money >= 200:
		Globals.money = Globals.money -200
		Globals.line_2_owned = true
		Globals.line_state = 2
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_premium_line_pressed():
	if Globals.line_3_owned == true:
		Globals.line_state = 3
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.line_3_owned = true
		Globals.line_state = 3
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_hightest_line_2_pressed():
	if Globals.line_4_owned == true:
		Globals.line_state = 4
	elif Globals.money >= 800:
		Globals.money = Globals.money -800
		Globals.line_4_owned = true
		Globals.line_state = 4
	else:
		print("broke") #error noise
	print(Globals.line_state)
