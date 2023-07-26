# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends CPUParticles2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var timer: Timer = $Timer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform(collision: KinematicCollision2D):
	var collision_position = collision.get_position()
	var collision_rotation = collision.get_normal().angle()
	
	var instance: CPUParticles2D = _replicate()
	instance.global_position = collision_position
	instance.global_rotation = collision_rotation
	instance.emitting = true
	instance.timer.start(instance.lifetime + 1.0)
	

# -- 17 private methods
func _replicate() -> Variant:
	var instance = self.duplicate()
	get_tree().get_current_scene().add_child(instance)
	return instance
	
	
# -- 18 signal listeners
func _on_timer_timeout():
	queue_free()


# -- 19 subclasses

