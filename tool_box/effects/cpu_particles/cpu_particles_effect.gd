
# -- 01 @tool
# -- 02 class_name
class_name CPUParticlesEffect
# -- 03 extends
extends CPUParticles2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var reparent_on_perform := false
@export var replicate_on_perform := false
@export var after_perform_free_delay_time := -1


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
	if replicate_on_perform:
		var replica = _replicate()
		replica.replicate_on_perform = false
		replica.perform()
	else:
		if reparent_on_perform:
			reparent(get_tree().current_scene, true)
			
		emitting = true
		
		if after_perform_free_delay_time > 0:
			await get_tree().create_timer(after_perform_free_delay_time).timeout
			queue_free()
	
	
# -- 17 private methods
func _replicate() -> CPUParticles2D:
	var instance = self.duplicate()
	get_tree().current_scene.add_child(instance)
	instance.global_position = global_position

	return instance
	
# -- 18 signal listeners
# -- 19 subclasses

