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
@export var factor := 1.0
@export var duration := 1.0
@export var auto_start := false

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var _timer = $Timer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	if auto_start:
		start()
		
		
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func start():
	Engine.time_scale = factor
	
	if duration > 0.0:
		_timer.start(factor)
	
	
func stop():
	_timer.stop()
	Engine.time_scale = 1.0
	
	
# -- 17 private methods
# -- 18 signal listeners
func _on_timer_timeout():
	stop()

# -- 19 subclasses



