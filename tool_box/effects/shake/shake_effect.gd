# -- 01 @tool
# -- 02 class_name
class_name ShakeEffect

# -- 03 extends
extends Node

# -- 04 # docstring
# Inspired by: 
#  - https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html
#  - https://github.com/firebelley/godot-addons/blob/master/node_library/scripts/shaky_camera_2d.gd

#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Main")
@export var target: Node
@export var auto_start := false

@export_group("Shake")
@export var duration := 0.5
@export var max_offset := Vector2(20, 20)
@export var frequency := 10.0
	
@export_group("Noise")
@export var noise: FastNoiseLite


# -- 09 public variables
# -- 10 private variables
var _noise_offset := 0.0
var _current_shake_percentage := 0.0
var _actual_duration: float
var _actual_frequency: float
var _amplitude_multiplier: float = 1.0


# -- 11 onready variables
@onready var _timer = $Timer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	randomize()
	noise.seed = randi()
	
	_actual_duration = duration
	_actual_frequency = frequency
	
	if auto_start:
		perform()


# -- 15 remaining built-in virtual methods
func _process(delta):
	if _current_shake_percentage > 0:
		_shake(delta)
		
		
# -- 16 public methods
func perform(new_duration: float = duration, new_frequency: float = frequency, amplitude_multiplier: float = 1.0):
	_actual_duration = max(_timer.time_left, new_duration)
	_actual_frequency = max(_actual_frequency, new_frequency)
	_amplitude_multiplier = max(_amplitude_multiplier, amplitude_multiplier)
	
	if _actual_duration > 0:
		_timer.start(_actual_duration)
		
	_current_shake_percentage = 1.0
	
	
# -- 17 private methods
func _shake(delta):
	# noise calculations
	_noise_offset = _noise_offset + (delta * _actual_frequency)
	_noise_offset = wrapf(_noise_offset, 0, 100000) 
	var noise_x = noise.get_noise_2d(_noise_offset, 0)
	var noise_y = noise.get_noise_2d(_noise_offset, 1000)
	
	# offset
	var offset_x = noise_x * max_offset.x * _amplitude_multiplier * _current_shake_percentage
	var offset_y = noise_y * max_offset.y * _amplitude_multiplier * _current_shake_percentage
	var offset = Vector2(offset_x, offset_y) 
	target.offset = offset
	
	# decay
	if _actual_duration > 0:
		_current_shake_percentage = remap(_timer.time_left, 0, _actual_duration, 0.0, 1.0)
	
# -- 18 signal listeners
# -- 19 subclasses

	
