extends Node2D

@onready var main_menu = "res://Maps/main_menu.tscn"
@onready var game_over_menu = "res://Maps/game_over_menu.tscn"
@onready var victory_menu = "res://Maps/victory_menu.tscn"
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
@onready var fish_name = $"Camera2D/Control/Fish Caught Menu/VBoxContainer/RichTextLabel3"


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

func click():
	$AudioStreamPlayer2.play()

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
		fish_name.add_text("Clown Anemonefish")
		money_text.add_text("and got 10$")
		print(Globals.money)
	elif fish == "pyramid":
		Globals.money = Globals.money + 19
		fish_name.add_text("Pyramid Butterflyfish")
		money_text.add_text("and got 19$")
	elif fish == "seargant":
		Globals.money = Globals.money + 24
		fish_name.add_text("Seargant Major")
		money_text.add_text("and got 24$")
	elif fish == "grubfish":
		Globals.money = Globals.money + 28
		fish_name.add_text("Pink banded Grubfish")
		money_text.add_text("and got 28$")
	elif fish == "moonfish":
		Globals.money = Globals.money + 34
		fish_name.add_text("Silver Moonfish")
		money_text.add_text("and got 34$")
	elif fish == "birdnosed":
		Globals.money = Globals.money + 39
		fish_name.add_text("Bird nosed Wrasse")
		money_text.add_text("and got 39$")
	elif fish == "triggerfish":
		Globals.money = Globals.money + 43
		fish_name.add_text("Pink Tail Triggerfish")
		money_text.add_text("and got 43$")
	elif fish == "lunar":
		Globals.money = Globals.money + 48
		fish_name.add_text("Lunar Fusilier")
		money_text.add_text("and got 48$")
	elif fish == "flyingfish":
		Globals.money = Globals.money + 50
		fish_name.add_text("Tallfin Flyingfish")
		money_text.add_text("and got 50$")
	elif fish == "herring":
		Globals.money = Globals.money + 76
		fish_name.add_text("Dorab Wolf-herring")
		money_text.add_text("and got 76$")
	elif fish == "mahi":
		Globals.money = Globals.money + 92
		fish_name.add_text("Mahi Mahi")
		money_text.add_text("and got 92$")
	elif fish == "spearfish":
		Globals.money = Globals.money + 128
		fish_name.add_text("Shortbill Spearfish")
		money_text.add_text("and got 128$")
	elif fish == "humphead":
		Globals.money = Globals.money + 168
		fish_name.add_text("Humphead Maori Wrasse")
		money_text.add_text("and got 168$")
	elif fish == "yellowfin":
		Globals.money = Globals.money + 193
		fish_name.add_text("Yellowfin Tuna")
		money_text.add_text("and got 193$")
	elif fish == "baracuda":
		Globals.money = Globals.money + 234
		fish_name.add_text("Great Baracuda")
		money_text.add_text("and got 234$")
	elif fish == "shortfin":
		Globals.money = Globals.money + 315
		fish_name.add_text("Shortfin Mako")
		money_text.add_text("and got 315$")
	elif fish == "gemfish":
		Globals.money = Globals.money + 357
		fish_name.add_text("Silver Gemfish")
		money_text.add_text("and got 357$")
	elif fish == "marlin":
		Globals.money = Globals.money + 438
		fish_name.add_text("Black Marlin")
		money_text.add_text("and got 438$")
	elif fish == "tiger":
		Globals.money = Globals.money + 500
		fish_name.add_text("Tiger Shark")
		money_text.add_text("and got 500$")
		SceneSwitcher.switch_scene(victory_menu)
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
	click()


func _on_button_unpause_pressed():
	pause_menu.hide()
	$Camera2D/Control/ButtonPause.visible=true
	get_tree().paused = false
	click()


func _on_button_pressed():
	SceneSwitcher.switch_scene(main_menu)
	click()
	#get_tree().change_scene_to_file(main_menu)


func _on_button_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	click()


func _on_button_main_menu_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)
	click()
	#get_tree().change_scene_to_file(main_menu)


func _on_button_recast_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	click()


func _on_button_main_menu_2_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)
	click()
	#get_tree().change_scene_to_file(main_menu)

# Shop Menu after this
# open shop menu

func check_owned():
	if Globals.hook_2_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Aluminum Hook/TextureRect/Label".visible = false
	else:
		pass
	if Globals.hook_3_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Brass Hook/TextureRect/Label".visible = false
	else:
		pass
	if Globals.sinker_2_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Dipsey/TextureRect/Label".visible = false
	else:
		pass
	if Globals.sinker_3_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Diamond/TextureRect/Label".visible = false
	else:
		pass
	if Globals.line_2_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Line/TextureRect/Label".visible = false
	else:
		pass
	if Globals.line_3_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Premium Line/TextureRect/Label".visible = false
	else:
		pass
	if Globals.line_4_owned == true:
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Hightest Line2/TextureRect/Label".visible = false
	else:
		pass


func _on_shop_button_3_pressed():
	$Camera2D/Control/ButtonPause.visible=false
	fish_caught_screen.hide()
	shop_menu.show()
	money = str(Globals.money)
	purse.add_text(money)
	purse.add_text("$")
	check_owned()
	click()

func _on_shop_button_2_pressed():
	$Camera2D/Control/ButtonPause.visible=false
	game_over_screen.hide()
	shop_menu.show()
	money = str(Globals.money)
	purse.add_text(money)
	purse.add_text("$")
	check_owned()
	click()

# buttons from shop
func _on_button_play_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	click()


func _on_button_menu_pressed():
	get_tree().paused = false
	SceneSwitcher.switch_scene(main_menu)
	click()

# buttons to change equipment
# visual indication that they are still locked & prices

# hooks
func _on_button_iron_hook_pressed():
	Globals.hook_state = 1
	print(Globals.hook_state)
	click()


func _on_button_aluminum_hook_pressed():
	if Globals.hook_2_owned == true:
		Globals.hook_state = 2
		click()
	elif Globals.money >= 300:
		Globals.money = Globals.money -300
		Globals.hook_2_owned = true
		Globals.hook_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Aluminum Hook/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.hook_state)


func _on_button_brass_hook_pressed():
	if Globals.hook_3_owned == true:
		Globals.hook_state = 3
		click()
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.hook_3_owned = true
		Globals.hook_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Brass Hook/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.hook_state)

# sinkers
func _on_button_splitshot_pressed():
	Globals.sinker_state = 1
	print(Globals.sinker_state)
	click()


func _on_button_dipsey_pressed():
	if Globals.sinker_2_owned == true:
		Globals.sinker_state = 2
		click()
	elif Globals.money >= 500:
		Globals.money = Globals.money -500
		Globals.sinker_2_owned = true
		Globals.sinker_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Dipsey/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

func _on_button_diamond_pressed():
	if Globals.sinker_3_owned == true:
		Globals.sinker_state = 3
		click()
	elif Globals.money >= 700:
		Globals.money = Globals.money -700
		Globals.sinker_3_owned = true
		Globals.sinker_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Diamond/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

# lines
func _on_button_string_pressed():
	Globals.line_state = 1
	print(Globals.line_state)
	click()


func _on_button_line_pressed():
	if Globals.line_2_owned == true:
		Globals.line_state = 2
		click()
	elif Globals.money >= 200:
		Globals.money = Globals.money -200
		Globals.line_2_owned = true
		Globals.line_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Line/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_premium_line_pressed():
	if Globals.line_3_owned == true:
		Globals.line_state = 3
		click()
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.line_3_owned = true
		Globals.line_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Premium Line/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_hightest_line_2_pressed():
	if Globals.line_4_owned == true:
		Globals.line_state = 4
		click()
	elif Globals.money >= 800:
		Globals.money = Globals.money -800
		Globals.line_4_owned = true
		Globals.line_state = 4
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Hightest Line2/TextureRect/Label".visible = false
		click()
	else:
		print("broke") #error noise
	print(Globals.line_state)
