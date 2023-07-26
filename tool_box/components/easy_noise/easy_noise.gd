# -- 01 @tool
# -- 02 class_name
class_name EasyNoise
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Output value")
@export var output_min := -100.0
@export var output_max := 100.0

@export_group("Noise")
## The frequency for all noise types. Low frequency results in smooth noise while high frequency results in rougher, more granular noise.
@export var frequency := 0.01 : set = _set_frequency
## Frequency multiplier between subsequent octaves. Increasing this value results in higher octaves producing noise with finer details and a rougher appearance.
@export var fractal_lacunarity := 2.0 : set = _set_fractal_lacunarity
## Determines the strength of each subsequent layer of noise in fractal noise. A low value places more emphasis on the lower frequency base layers, while a high value puts more emphasis on the higher frequency layers.
@export var fractal_gain := 0.5 : set = _set_fractal_gain
@export var noise_speed := 10.0

@export_group("Debug")
@export var debug := false : set = _set_debug


# -- 09 public variables
var noise_value : get = _get_noise_value

# -- 10 private variables
var _noise := FastNoiseLite.new()
var _noise_offset := 0.0

# -- 11 onready variables
@onready var easy_noise_debugger = $EasyNoiseDebugger

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	_update_noise()
	_update_debug_process()
	

# -- 15 remaining built-in virtual methods
func _process(delta):
	_noise_offset += noise_speed * delta
	

# -- 16 public methods
# -- 17 private methods
func _get_noise_value() -> float:
	var pre_noise_value = _noise.get_noise_1d(_noise_offset)
	var result = remap(pre_noise_value, -1.0, 1.0, output_min, output_max)
	return result


func _set_frequency(value: float):
	frequency = value
	_update_noise()
	
	
func _set_fractal_lacunarity(value: float):
	fractal_lacunarity = value
	_update_noise()
	
	
func _set_fractal_gain(value: float):
	fractal_gain = value
	_update_noise()
	
	
func _set_debug(value: bool):
	debug = value
	_update_debug_process()
	

func _update_noise():
	_noise.frequency = frequency
	_noise.fractal_lacunarity = fractal_lacunarity
	_noise.fractal_gain = fractal_gain


func _update_debug_process():
	if not easy_noise_debugger:
		return
		
	easy_noise_debugger.set_process(debug)
