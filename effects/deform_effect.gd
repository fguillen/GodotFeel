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
@export var shader_material: ShaderMaterial
@export var bulge: float = 0.3
@export var durantion: float = 0.3


# -- 09 public variables
# -- 10 private variables
var _tween: Tween
var _previous_material: Material
var _is_active = false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	print("DeformEffect._ready()")
#	_tween = get_tree().create_tween()
	
	
# -- 15 remaining built-in virtual methods
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		perform()
		
		
# -- 16 public methods
func perform():
	if _is_active:
		_reset()
	
	_is_active = true	
	_tween = create_tween()
	_previous_material = target.material
	target.material = shader_material
#	_tween.tween_property(target, "position", Vector2(1, 2), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	_tween.tween_method(_set_shader_value, 0.0, bulge, durantion).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	_tween.tween_method(_set_shader_value, bulge, 0.0, durantion * 1.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	_tween.tween_callback(_reset)
	
	
# -- 17 private methods
func _reset():
	_tween.kill()
	target.material = _previous_material
	_is_active = false
	

func _set_shader_value(value: float):
#	print("DeformEffect._set_shader_value(%f)" % value)
	shader_material.set_shader_parameter("bulge", value);
	
	
# -- 18 signal listeners
# -- 19 subclasses

