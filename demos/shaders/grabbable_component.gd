# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Area2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var node: Node

# -- 09 public variables
# -- 10 private variables
var _is_grabbed := false
var _pointer_offset: Vector2
var _pointer_position: Vector2

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	if _is_grabbed:
		node.global_position = _pointer_position - _pointer_offset
	
	
		
		
# -- 16 public methods
# -- 17 private methods
func _start_grabbing(pointer_position: Vector2):
	_pointer_position = pointer_position
	_pointer_offset = pointer_position - node.global_position 
	_is_grabbed = true
	
	
func _stop_grabbing():
	_is_grabbed = false
	

# -- 18 signal listeners
func _on_input_event(_iewport, event, _shape_idx):
	if event is InputEventMouseMotion and _is_grabbed:
		_pointer_position = event.position

	if event is InputEventMouseButton and event.is_pressed():
		_start_grabbing(event.position)
		
	if event is InputEventMouseButton and not event.is_pressed():
		_stop_grabbing()


# -- 19 innerclasses
