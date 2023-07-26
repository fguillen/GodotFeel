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
@export var reparent_on_ready := false
@export var reparent_on_perform := false


# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	if reparent_on_ready:
		reparent.call_deferred(get_tree().current_scene, true)
		
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	if reparent_on_perform:
		reparent(get_tree().current_scene, true)
		
	print("XXX BrickExplosionParticlesEffect.perform()")
	emitting = true
	await get_tree().create_timer(2.0).timeout
	queue_free()
	
	
# -- 17 private methods
#func _reparent():
#	var actual_global_position = global_position
#	var actual_z_index = _get_absolute_z_index()
#	var actual_scene = get_tree().current_scene
#	get_parent().remove_child(self)
#	actual_scene.add_child(self)
#	global_position = actual_global_position
#	z_as_relative = false
#	z_index = actual_z_index
#
#
#func _get_absolute_z_index() -> int:
#	var node = self;
#	var result = 0;
#	while node and node.is_class('Node2D'):
#		result += node.z_index;
#		if !node.z_as_relative:
#			break;
#		node = node.get_parent();
#	return result;
	
# -- 18 signal listeners
# -- 19 subclasses

