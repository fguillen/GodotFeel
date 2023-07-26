# -- 01 @tool
# -- 02 class_name
class_name CollisionDebugger
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var normal_length := 100
@export var angle_length := 100

# -- 09 public variables
# -- 10 private variables
var _collision: KinematicCollision2D

# -- 11 onready variables
@onready var normal_line = $NormalLine
@onready var angle_line = $AngleLine
@onready var impact = $Impact
@onready var timer = $Timer


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	visible = false
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func setup(collision: KinematicCollision2D):
	global_position = collision.get_position()
	_collision = collision
	_update_visuals()
	visible = true
	timer.start()
	
	
# -- 17 private methods
func _replicate() -> CollisionDebugger:
	var instance = self.duplicate()
	get_tree().current_scene.add_child(instance)
	
	return instance
	
	
func _update_visuals():
	normal_line.set_point_position(1, _collision.get_normal() * normal_length)
	angle_line.set_point_position(1, Vector2.UP.rotated(_collision.get_angle()) * angle_length)
	
	
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	var instance = _replicate()
	instance.setup(collision)
	
	
func _on_timer_timeout():
	queue_free()
	
# -- 19 subclasses




