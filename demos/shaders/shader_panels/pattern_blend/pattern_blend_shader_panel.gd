# -- 01 @tool
# -- 02 class_name
class_name PatternBlendShaderPanel

# -- 03 extends
extends ShaderPanel

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
const BLEND_MODES = {
	"Multiply" : 1,
	"Screen" : 2,
	"Darken" : 3,
	"Lighten" : 4,
	"Difference" : 5,
	"Exclusion" : 6,
	"Overlay" : 7,
	"Hard light" : 8,
	"Soft light" : 9,
	"Color dodge" : 10,
	"Linear dodge" : 11,
	"Color burn" : 12,
	"Linear burn" : 13 
}

# -- 08 exported variables
@export var named_patterns: Array[NamedPattern]
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var shader_color_rect = %ShaderColorRect

@onready var patterns_select: OptionButton = %PatternsSelect

@onready var alpha_slider = %AlphaSlider
@onready var alpha_value_label = %AlphaValueLabel

@onready var scale_slider = %ScaleSlider
@onready var scale_value_label = %ScaleValueLabel

@onready var offset_slider = %OffsetSlider
@onready var offset_value_label = %OffsetValueLabel

@onready var invert_button: CheckButton = %InvertButton

@onready var blend_modes_select: OptionButton = %BlendModesSelect

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_set_patterns()
	_set_blend_modes()

	patterns_select.item_selected.connect(_on_pattern_selected)
	patterns_select.select(0)
	_on_pattern_selected(0)
	
	alpha_slider.value_changed.connect(_on_alpha_slider_value_changed)
	alpha_slider.value = shader_color_rect.material.get_shader_parameter("modulate_color").a
	
	scale_slider.value_changed.connect(_on_scale_slider_value_changed)
	scale_slider.value = shader_color_rect.material.get_shader_parameter("pattern_scale")

	offset_slider.value_changed.connect(_on_offset_slider_value_changed)
	offset_slider.value = shader_color_rect.material.get_shader_parameter("pattern_offset").x

	invert_button.toggled.connect(_on_invert_button_toggled)
	invert_button.button_pressed = shader_color_rect.material.get_shader_parameter("inverted")

	blend_modes_select.item_selected.connect(_on_blend_mode_selected)
	blend_modes_select.select(0)
	_on_blend_mode_selected(0)

# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _set_patterns():
	for i in named_patterns.size():
		patterns_select.add_item(named_patterns[i].name, i)
		
		
func _set_blend_modes():
	for i in BLEND_MODES.size():
		blend_modes_select.add_item(BLEND_MODES.keys()[i], BLEND_MODES.values()[i])


# -- 18 signal listeners
func _on_alpha_slider_value_changed(value: float):
	alpha_value_label.text = "%.3f" % value
	shader_color_rect.material.set_shader_parameter("modulate_color", Color(1, 1, 1, value))
	
	
func _on_scale_slider_value_changed(value: float):
	scale_value_label.text = "%02.1f" % value
	shader_color_rect.material.set_shader_parameter("pattern_scale", value)


func _on_offset_slider_value_changed(value: float):
	offset_value_label.text = "%.3f" % value
	shader_color_rect.material.set_shader_parameter("pattern_offset", Vector2(value, 0))


func _on_invert_button_toggled(value: bool):
	shader_color_rect.material.set_shader_parameter("inverted", value)


func _on_pattern_selected(index: int):
	print("XXX: _on_pattern_selected(index: int)", index)
	var texture = named_patterns[index].pattern
	shader_color_rect.material.set_shader_parameter("pattern_texture", texture)
	

func _on_blend_mode_selected(index: int):
	shader_color_rect.material.set_shader_parameter("blend_mode", BLEND_MODES.values()[index])

# -- 19 innerclasses

