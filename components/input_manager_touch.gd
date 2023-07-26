# -- 01 @tool
# -- 02 class_name
class_name InputManagerTouch
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var bumping_sensitivity := 1000.0
@export var dashing_sensitivity := 3000.0
@export var moving_sensitivity := 100.0

# -- 09 public variables
# -- 10 private variables
var _character: Node2D
var _last_drag_position := Vector2.ZERO
var _last_drag_time := 0.0

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_character = owner
	
	
# -- 15 remaining built-in virtual methods
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true:
			_touch_position_changed(event.position)
		
		if event.pressed == false:
			_last_drag_position = Vector2.ZERO
			
	if event is InputEventScreenDrag:
		_calculate_direction_based_on_drag(event.relative)
		
		var drag_velocity = _calculate_drag_velocity(event.position)
		_check_if_bumping(drag_velocity)
		_check_if_dashing(drag_velocity)
		
		
# -- 16 public methods
# -- 17 private methods
func _calculate_drag_velocity(event_position: Vector2) -> Vector2:
	var result = Vector2.ZERO
		
	if _last_drag_position != Vector2.ZERO:
		var drag_positions_interval = Time.get_unix_time_from_system() - _last_drag_time
		var drag_distance = event_position - _last_drag_position
		result = drag_distance / drag_positions_interval
		
	_last_drag_position = event_position
	_last_drag_time = Time.get_unix_time_from_system()
	
	return result
	
	
func _calculate_direction_based_on_drag(drag_direction: Vector2):
	_emit_input_action_directions(drag_direction.normalized())
	
	
	
func _touch_position_changed(touch_position: Vector2):
	var direction = touch_position - _character.position
	
	if abs(direction.x) < moving_sensitivity:
		direction.x = 0
		
	if abs(direction.y) < moving_sensitivity:
		direction.y = 0
		
	direction = direction.normalized()
		
	_emit_input_action_directions(direction)


func _check_if_bumping(velocity: Vector2):
	if velocity.y < -bumping_sensitivity:
		_emit_input_action_bump()
		
		
func _check_if_dashing(velocity: Vector2):
	if abs(velocity.x) > dashing_sensitivity:
		_emit_input_action_dash()
		
	
func _emit_input_action_directions(direction: Vector2):
	Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	
	
	# ui_left
	var event_ui_left = InputEventAction.new()
	event_ui_left.action = "ui_left"
	event_ui_left.pressed = direction.x < 0
	Input.parse_input_event(event_ui_left)
	
	# ui_right
	var event_ui_right = InputEventAction.new()
	event_ui_right.action = "ui_right"
	event_ui_right.pressed = direction.x > 0
	Input.parse_input_event(event_ui_right)
	
	# ui_up
	var event_ui_up = InputEventAction.new()
	event_ui_up.action = "ui_up"
	event_ui_up.pressed = direction.y < 0
	Input.parse_input_event(event_ui_up)
	
	# ui_down
	var event_ui_down = InputEventAction.new()
	event_ui_down.action = "ui_down"
	event_ui_down.pressed = direction.y > 0
	Input.parse_input_event(event_ui_down)
	
	
func _emit_input_action_bump():
	print("InputManagerTouch._emit_input_action_bump(%s)" % Input.is_action_pressed("bump"))
	if Input.is_action_pressed("bump"):
		return
	
	var event = InputEventAction.new()
	event.action = "bump"
	
	# Press
	event.pressed = true
	Input.parse_input_event(event)
	
	# Relase in next frame
	await get_tree().create_timer(0.2).timeout
	event.pressed = false
	Input.parse_input_event(event)
	
	
func _emit_input_action_dash():
	print("InputManagerTouch._emit_input_action_dash(%s)" % Input.is_action_pressed("dash"))
	if Input.is_action_pressed("dash"):
		return
		
	var event = InputEventAction.new()
	event.action = "dash"
	
	# Press
	event.pressed = true
	Input.parse_input_event(event)
	
	# Relase in next frame
	await get_tree().create_timer(0.2).timeout
	event.pressed = false
	Input.parse_input_event(event)
	
	
# -- 18 signal listeners
# -- 19 subclasses

