# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var duration: float = 0.5
@export var particles_life_time: float = 0.4
@export var particles_per_second: float = 10


# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var sprite = $Sprite2D
@onready var _timer_effect = $TimerEffect
@onready var _timer_spawn = $TimerSpawn


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	sprite.visible = false
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	_timer_effect.start(duration)
	_timer_spawn.start(1.0 / particles_per_second)
	
	
# -- 17 private methods
func _spawn():
	var sprite_duplicated = sprite.duplicate()
	get_tree().get_current_scene().add_child(sprite_duplicated)
	sprite_duplicated.global_position = global_position
	sprite_duplicated.visible = true
	
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(sprite_duplicated, "modulate:a", 0.0, particles_life_time)
	tween.tween_callback(sprite_duplicated.queue_free)
	
	
# -- 18 signal listeners
func _on_timer_effect_timeout():
	_timer_spawn.stop()
	
	
func _on_timer_spawn_timeout():
	_spawn()
# -- 19 subclasses






