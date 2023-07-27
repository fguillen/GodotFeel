# -- 01 @tool
# -- 02 class_name
class_name HitStopEffect
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var node: Node
@export var animation_player: AnimationPlayer
@export var time := 0.1


# -- 09 public variables
# -- 10 private variables
var _is_animation_player_paused := false

# -- 11 onready variables
@onready var timer = $Timer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	await get_tree().process_frame
	
	if node: 
		node.set_process(false)
		node.set_physics_process(false)
	
	if animation_player and animation_player.is_playing():
		animation_player.pause()
		_is_animation_player_paused = true
		
	timer.start(time)
	
# -- 17 private methods
# -- 18 signal listeners
func _on_timer_timeout():
	if node: 
		node.set_process(true)
		node.set_physics_process(true)
	
	if animation_player and _is_animation_player_paused:
		animation_player.play()
# -- 19 subclasses

