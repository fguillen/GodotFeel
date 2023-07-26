# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	add_to_group("persist")
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func serialize() -> Dictionary:
	return {
		"volume_sfx": get_volume_sfx(),
		"volume_music": get_volume_music()
	}
	
	
func deserialize(data: Dictionary):
	set_volume_sfx(data.volume_sfx)
	set_volume_music(data.volume_music)
	
	
func get_volume(bus_name: String) -> float:
	var bus_index = AudioServer.get_bus_index(bus_name)
	var bus_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(bus_volume)
	
	
func set_volume(bus_name: String, value: float):
	var db = linear_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)
	DataPersister.save_data()
	
	
func get_volume_sfx() -> float:
	return get_volume("sfx")
	
	
func get_volume_music() -> float:
	return get_volume("music")
	
	
func set_volume_sfx(value):
	set_volume("sfx", value)
	
	
func set_volume_music(value):
	set_volume("music", value)
# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses

