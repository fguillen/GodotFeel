# 01. @tool
# 02. class_name
class_name BlinkEffect
# 03. extends
extends Node

# 04. # docstring
#
# 05. signals
# 06. enums
# 07. constants
# 08. exported variables
@export var canvas_item: CanvasItem
@export var time: float = 0.3
@export var material: ShaderMaterial

# 09. public variables
# 10. private variables
var _tween: Tween
var _previous_material: Material

# 11. onready variables
#
# 12. optional built-in virtual _init method
# 13. optional built-in virtual _enter_tree() method
# 14. built-in virtual _ready method
# 15. remaining built-in virtual methods
# 16. public methods
func perform():
	if _tween != null and _tween.is_valid():
		_tween.kill()
		_recover_material()
	
	_previous_material = canvas_item.material
	canvas_item.material = material
	(canvas_item.material as ShaderMaterial).set_shader_parameter("percent", 1.0)
	_tween = create_tween()
	_tween.tween_property(canvas_item.material, "shader_parameter/percent", 0.0, time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await _tween.finished
	_recover_material()

	
# 17. private methods
func _recover_material():
	canvas_item.material = _previous_material
# 18. signal listeners
# 19. subclasses
