# -- 01 @tool
# -- 02 class_name
class_name InputManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal bump_received()
signal dash_received()
signal direction_changed(direction: Vector2)


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _last_direction := Vector2.ZERO

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	var actual_direction = _get_input_vector()
	if _last_direction != actual_direction:
		direction_changed.emit(actual_direction)
		_last_direction = actual_direction
	
	if _get_bump():
		print("XXX: InputManager.bump_received")
		bump_received.emit()
		
	if _get_dash():
		print("XXX: InputManager.dash_received")
		dash_received.emit()
		
	
# -- 16 public methods
# -- 17 private methods
func _get_input_vector() -> Vector2:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return input_vector.normalized()
	

func _get_bump() -> bool:
	return Input.is_action_just_pressed("bump")


func _get_dash() -> bool:
	return Input.is_action_just_pressed("dash")
	
# -- 18 signal listeners
# -- 19 subclasses

