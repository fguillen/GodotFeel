# -- 01 @tool
# -- 02 class_name
class_name DeviceVibrationEffect
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var device := 0
@export var weak_maginitude := 0.2
@export var strong_maginitude := 0.1
@export var duration := 0.15
@export var times := 1
@export var time_in_between := 0.2

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	print("DeviceVibrationEffect.perform()")
	for i in times:
		Input.start_joy_vibration(device, weak_maginitude, strong_maginitude, duration)
		Input.vibrate_handheld(int(duration * 1000))
		await get_tree().create_timer(duration + time_in_between).timeout
	
	
# -- 17 private methods
# -- 18 signal listeners	
# -- 19 innerclasses




