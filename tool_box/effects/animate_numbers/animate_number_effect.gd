# -- 01 @tool
# -- 02 class_name
class_name AnimateNumberEffect

# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var target: Label
@export var duration := 0.5
@export var time_format := false

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform(to: int):
	var tween = get_tree().create_tween()
	tween.tween_method(_update_number, int(target.text), to, duration)
	await tween.finished
	finished.emit()
	
	
# -- 17 private methods
func _update_number(number: int):
	if time_format:
		var time_dictionary = Time.get_time_dict_from_unix_time(number)
		target.text = "%02d:%02d" % [time_dictionary.minute, time_dictionary.second]
	else:
		target.text = str(number)
	
# -- 18 signal listeners
# -- 19 subclasses

