# -- 01 @tool
# -- 02 class_name
class_name PixelateShaderPanel

# -- 03 extends
extends ShaderPanel

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var slider: Slider = %HSlider
@onready var color_rect: ColorRect = %ShaderColorRect
@onready var value_label = %ValueLabel

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	slider.value_changed.connect(_on_slider_value_changed)
	slider.value = color_rect.material.get_shader_parameter("pixel_size")
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _on_slider_value_changed(value: int):
	value_label.text = "%03d" % value
	color_rect.material.set_shader_parameter("pixel_size", value)
	
	
# -- 18 signal listeners
# -- 19 innerclasses

