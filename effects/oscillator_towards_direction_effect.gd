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
@export var intensity: float = 0.5
@export var spring: float = 500.0
@export var damp: float = 5.0
#@export var speed: float = 10.0 


# -- 09 public variables
# -- 10 private variables
var _actual_horizontal_direction: float = 0.0
var _displacement: float = 0.0
var _velocity: float = 0.0



# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(delta):
	_velocity += _actual_horizontal_direction * intensity
	var force = (-spring * _displacement) + (damp * _velocity)
	_velocity -= force * delta
	_displacement -= _velocity * delta
	target.rotation = -_displacement
	
	
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
func on_direction_changed(direction: Vector2):
	_actual_horizontal_direction = direction.x
	
# -- 19 subclasses

