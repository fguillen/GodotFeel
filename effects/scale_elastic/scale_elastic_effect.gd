# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var target: Node
@export var target_scale := Vector2(1.5, 1.5)
@export var time := 0.2
@export var curve: Curve
@export var revert := false


# -- 09 public variables
# -- 10 private variables
var _previous_scale: Vector2
var _is_playing := false
var _tween: Tween

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	if _is_playing:
		return
		
	if not is_inside_tree():
		print("ScaleElasticEffect.perform when not in tree :?")
		return
		
	_is_playing = true
	_previous_scale = target.scale
	
	_tween = get_tree().create_tween()
	_tween.tween_method(_interpolation, 0.0, 1.0, time)
	await _tween.finished
	_is_playing = false
	finished.emit()
	
	
# -- 17 private methods
func _interpolation(t):
	var scale_result = lerp(_previous_scale, target_scale, curve.sample_baked(t))
	target.scale = scale_result
	

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		if _tween is Tween and _tween.is_running():
			_tween.stop()
	
# -- 18 signal listeners
# -- 19 innerclasses

