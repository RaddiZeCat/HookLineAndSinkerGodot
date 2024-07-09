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
@onready var depth_text = $Camera2D/Control/DepthText


enum State{SINKING,RISING}
var state = State.SINKING
var players
var fish
var money
var depth
var volume
var paused:bool = false

func _ready():
	SceneSwitcher.reload()
	money = str(Globals.money)
	ingame_purse.add_text(money)
	ingame_purse.add_text("$")
	reel()

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
	
	if DepthCharge.position.y >= 0:
		depth = int(DepthCharge.position.y / 20)
		depth_text.set_text(str(depth,"m"))
	else:
		depth_text.set_text(str(0,"m"))

func click():
	$AudioStreamPlayer2.play()

func clack():
	$AudioStreamPlayer3.play()

func rustle():
	$AudioStreamPlayer4.play()

func reel():
	$AudioStreamPlayer5.play()

func _on_audio_stream_player_5_finished():
	$AudioStreamPlayer5.play()

func _on_goal_area_2d_body_entered(body):
	$AudioStreamPlayer5.stop()
	fish_caught()

func _on_deathzone_area_2d_body_entered(body):
	game_over()

func quicksave():
	Globals.save_game()

# Win and Loose

func fish_caught():
	print(fish)
	fish_caught_screen.show()
	$Camera2D/Control/ButtonPause.visible = false
	$Camera2D/Control/DepthText.visible = false
	$Hook.visible = false
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
		if Globals.money <= 0:
			print("Broke")
			SceneSwitcher.switch_scene(game_over_menu)
	else:
		pass
	ingame_purse.visible = false


func game_over():
	get_tree().paused = true
	if Globals.boat_owned == false:
		Globals.money = Globals.money - 30
		boat_text_1.visible = true
		if Globals.money <= 0:
			print("Broke")
			SceneSwitcher.switch_scene(game_over_menu)
	else:
		pass
	game_over_screen.show()
	$Camera2D/Control/DepthText.visible = false
	$Camera2D/Control/ButtonPause.visible = false
	$Hook.visible = false
	ingame_purse.visible = false

# UI Screens after this
# ingame pause button
func _on_button_pause_pressed():
	paused = true
	$Camera2D/Control/ButtonPause.visible=false
	$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMaster".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMusic".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderSound".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound")))
	get_tree().paused = true
	pause_menu.show()
	click()


func _on_button_unpause_pressed():
	paused = false
	pause_menu.hide()
	Globals.save_options()
	$Camera2D/Control/ButtonPause.visible=true
	get_tree().paused = false
	click()

func pause_game():
	if paused == false:
		paused = true
		$"Camera2D/Control/Menu Paused/Button".grab_focus()
		$Camera2D/Control/ButtonPause.visible=false
		$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMaster".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
		$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMusic".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
		$"Camera2D/Control/Menu Paused/VBoxContainer/HSliderSound".set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound")))
		get_tree().paused = true
		pause_menu.show()
		click()
		print("Pause",paused)
	elif paused == true:
		paused = false
		pause_menu.hide()
		Globals.save_options()
		$Camera2D/Control/ButtonPause.visible=true
		get_tree().paused = false
		click()
		print("Pause",paused)

func _on_button_pressed():
	quicksave()
	Globals.save_options()
	SceneSwitcher.switch_scene(main_menu)
	click()
	#get_tree().change_scene_to_file(main_menu)


func _on_button_retry_pressed():
	get_tree().paused = false
	quicksave()
	get_tree().reload_current_scene()
	click()


func _on_button_main_menu_pressed():
	get_tree().paused = false
	quicksave()
	SceneSwitcher.switch_scene(main_menu)
	click()
	#get_tree().change_scene_to_file(main_menu)


func _on_button_recast_pressed():
	get_tree().paused = false
	quicksave()
	get_tree().reload_current_scene()
	click()


func _on_button_main_menu_2_pressed():
	get_tree().paused = false
	quicksave()
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
	quicksave()
	get_tree().reload_current_scene()
	click()


func _on_button_menu_pressed():
	get_tree().paused = false
	quicksave()
	SceneSwitcher.switch_scene(main_menu)
	click()

# buttons to change equipment
# visual indication that they are still locked & prices

# hooks
func _on_button_iron_hook_pressed():
	Globals.hook_state = 1
	print(Globals.hook_state)
	rustle()


func _on_button_aluminum_hook_pressed():
	if Globals.hook_2_owned == true:
		Globals.hook_state = 2
		rustle()
	elif Globals.money >= 300:
		Globals.money = Globals.money -300
		Globals.hook_2_owned = true
		Globals.hook_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Aluminum Hook/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.hook_state)


func _on_button_brass_hook_pressed():
	if Globals.hook_3_owned == true:
		Globals.hook_state = 3
		rustle()
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.hook_3_owned = true
		Globals.hook_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerHooks/Button Brass Hook/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.hook_state)

# sinkers
func _on_button_splitshot_pressed():
	Globals.sinker_state = 1
	print(Globals.sinker_state)
	rustle()


func _on_button_dipsey_pressed():
	if Globals.sinker_2_owned == true:
		Globals.sinker_state = 2
		rustle()
	elif Globals.money >= 500:
		Globals.money = Globals.money -500
		Globals.sinker_2_owned = true
		Globals.sinker_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Dipsey/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

func _on_button_diamond_pressed():
	if Globals.sinker_3_owned == true:
		Globals.sinker_state = 3
		rustle()
	elif Globals.money >= 700:
		Globals.money = Globals.money -700
		Globals.sinker_3_owned = true
		Globals.sinker_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerSinkers/Button Diamond/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.sinker_state)

# lines
func _on_button_string_pressed():
	Globals.line_state = 1
	print(Globals.line_state)
	rustle()


func _on_button_line_pressed():
	if Globals.line_2_owned == true:
		Globals.line_state = 2
		rustle()
	elif Globals.money >= 200:
		Globals.money = Globals.money -200
		Globals.line_2_owned = true
		Globals.line_state = 2
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Line/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_premium_line_pressed():
	if Globals.line_3_owned == true:
		Globals.line_state = 3
		rustle()
	elif Globals.money >= 600:
		Globals.money = Globals.money -600
		Globals.line_3_owned = true
		Globals.line_state = 3
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Premium Line/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_button_hightest_line_2_pressed():
	if Globals.line_4_owned == true:
		Globals.line_state = 4
		rustle()
	elif Globals.money >= 800:
		Globals.money = Globals.money -800
		Globals.line_4_owned = true
		Globals.line_state = 4
		$"Camera2D/Control/Shop Menu/VBoxContainer/HBoxContainerLines/Button Hightest Line2/TextureRect/Label".visible = false
		rustle()
	else:
		print("broke") #error noise
	print(Globals.line_state)


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()

func _on_h_slider_master_drag_started():
	clack()


func _on_h_slider_music_drag_started():
	clack()


func _on_h_slider_sound_drag_started():
	clack()


func _on_h_slider_master_changed():
	volume = $"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMaster".get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),volume)


func _on_h_slider_music_changed():
	volume = $"Camera2D/Control/Menu Paused/VBoxContainer/HSliderMusic".get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),volume)


func _on_h_slider_sound_changed():
	volume = $"Camera2D/Control/Menu Paused/VBoxContainer/HSliderSound".get("value")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),volume)
