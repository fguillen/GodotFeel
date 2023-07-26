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
@onready var top_animated = %TopAnimated
@onready var fluid_animated = %FluidAnimated
@onready var animation_player = %AnimationPlayer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func switch_to(scene_path):
	get_tree().paused = true
	_start_animations()
	animation_player.play("curtain_close")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animation_player.play("curtain_open")
	await animation_player.animation_finished
	get_tree().paused = false
	_stop_animations()
	
	
# -- 17 private methods
func _stop_animations():
	top_animated.stop()
	fluid_animated.stop()
	
	
func _start_animations():
	top_animated.play("default")
	fluid_animated.play("default")
	
	
# -- 18 signal listeners
# -- 19 subclasses

