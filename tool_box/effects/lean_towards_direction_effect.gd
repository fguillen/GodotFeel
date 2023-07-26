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
@export var target: Node2D
@export var max_angle := 15.0
@export var lean_speed := 30.0 # degrees per second


# -- 09 public variables
# -- 10 private variables
var _actual_horizontal_direction: float = 0.0
var _actual_angle: float = 0.0


# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(delta):
	var desired_angle = remap(_actual_horizontal_direction, -1.0, 1.0, -max_angle, max_angle)
	_actual_angle = move_toward(_actual_angle, desired_angle, lean_speed * delta)
	target.rotation = deg_to_rad(_actual_angle)
	
	
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
func on_direction_changed(direction: Vector2):
	_actual_horizontal_direction = direction.x
	
# -- 19 subclasses

