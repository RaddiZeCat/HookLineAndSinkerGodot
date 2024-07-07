extends Node

var hook_state = 1		#max 3
var line_state = 1		#max 4
var sinker_state = 1 	#max 3

var money:int = 200		#currency
var boat_owned = false	#if true disable running costs

var hook_1_owned = true
var hook_2_owned = false
var hook_3_owned = false
var line_1_owned = true
var line_2_owned = false
var line_3_owned = false
var line_4_owned = false
var sinker_1_owned = true
var sinker_2_owned = false
var sinker_3_owned = false

var current_save = normal_save

var normal_save = "user://normal.save"
var casual_save = "user://casual.save"
var settings_save = "user://settings.save"
var masterVolume:float
var musicVolume:float
var soundVolume:float

func save_game():
	var file = FileAccess.open(current_save, FileAccess.WRITE)
	file.store_var(hook_state)
	file.store_var(line_state)
	file.store_var(sinker_state)
	file.store_var(money)
	file.store_var(boat_owned)
	file.store_var(hook_1_owned)
	file.store_var(hook_2_owned)
	file.store_var(hook_3_owned)
	file.store_var(line_1_owned)
	file.store_var(line_2_owned)
	file.store_var(line_3_owned)
	file.store_var(line_4_owned)
	file.store_var(sinker_1_owned)
	file.store_var(sinker_2_owned)
	file.store_var(sinker_3_owned)

func load_game():
	if FileAccess.file_exists(current_save):
		var file = FileAccess.open(current_save, FileAccess.READ)
		hook_state = file.get_var(hook_state)
		line_state = file.get_var(line_state)
		sinker_state = file.get_var(sinker_state)
		money = file.get_var(money)
		boat_owned = file.get_var(boat_owned)
		hook_1_owned = file.get_var(hook_1_owned)
		hook_2_owned = file.get_var(hook_2_owned)
		hook_3_owned = file.get_var(hook_3_owned)
		line_1_owned = file.get_var(line_1_owned)
		line_2_owned = file.get_var(line_2_owned)
		line_3_owned = file.get_var(line_3_owned)
		line_4_owned = file.get_var(line_4_owned)
		sinker_1_owned = file.get_var(sinker_1_owned)
		sinker_2_owned = file.get_var(sinker_2_owned)
		sinker_3_owned = file.get_var(sinker_3_owned)

func save_options():
	masterVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	soundVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"))
	var file = FileAccess.open(settings_save, FileAccess.WRITE)
	file.store_var(masterVolume)
	file.store_var(musicVolume)
	file.store_var(soundVolume)

func load_options():
	var file = FileAccess.open(settings_save, FileAccess.READ)
	masterVolume = file.get_var(masterVolume)
	musicVolume = file.get_var(musicVolume)
	soundVolume = file.get_var(soundVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),masterVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"),soundVolume)
