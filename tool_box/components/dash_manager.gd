# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal dash_started_no_arguments()
signal dash_started(value: float)
signal dash_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var dash_speed := 2000.0
@export var dash_duration := 0.2


# -- 09 public variables
# -- 10 private variables
var _is_active := false

# -- 11 onready variables
@onready var timer = $Timer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _input(event):
	if _is_active:
		return
		
	if event is InputEventAction or event is InputEventKey:
		if event.is_action_pressed("dash"):
			print("XXX: DashManager.dash_received()")
			_dash_start()
	
		
func _dash_start():
	print("DashManager._dash_start()")
	_is_active = true
	timer.start(dash_duration)
	dash_started.emit(dash_speed)
	dash_started_no_arguments.emit()
	
	
func _dash_finish():
	print("DashManager._dash_finish()")
	_is_active = false
	dash_finished.emit()
	
		
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
func _on_timer_timeout():
	_dash_finish()
	
	
# -- 19 subclasses




