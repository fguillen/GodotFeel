# -- 01 @tool
# -- 02 class_name
class_name MovementManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal direction_changed(direction: Vector2)
signal speed_changed(speed: float)
signal collision_found(collision: KinematicCollision2D)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var max_speed := 150.0
@export var speed := 100.0 : set = _set_speed
@export var direction_scale := Vector2(1.0, 1.0)
@export var acceleration := 50
@export var infinite_acceleration := false
@export var decceleration := 80
@export var infinite_decceleration := false
@export var character: CharacterBody2D
@export_enum("Slide", "Collide") var collision_mode: String = "Slide" 
@export var direction := Vector2.ZERO : set = _set_direction
@export var initial_speed := 0.0


# -- 09 public variables


# -- 10 private variables
var _is_stoped := false
var _is_bursting := false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	initial_speed = speed
	
	
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	if _is_stoped: 
		return
		
	_accelerate_deccelerate(delta)
	_move(delta)
			
	
# -- 16 public methods
func stop():
	_is_stoped = true
	
	
func resume():
	_is_stoped = false
	

func reset():
	self.speed = initial_speed
	
	
func speed_burst_ini(value: float):
	_is_bursting = true
	character.velocity = value * direction
	
	
func speed_burst_end():
	_is_bursting = false
	
	
# -- 17 private methods
func _accelerate_deccelerate(delta: float):
	if _is_bursting:
		return
		
	var desired_velocity = speed * direction
	
	# If moving
	if desired_velocity != Vector2.ZERO:
		if infinite_acceleration:
			character.velocity = desired_velocity
		else:
			character.velocity = character.velocity.move_toward(desired_velocity, acceleration * delta)
			
	# If no moving
	else: 
		if infinite_decceleration:
			character.velocity = desired_velocity
		else:
			character.velocity = character.velocity.move_toward(desired_velocity, decceleration * delta)


func _move(delta):
	if collision_mode == "Slide":
		character.move_and_slide()
	else:
		var collision = character.move_and_collide(character.velocity * delta)
		if collision:
			collision_found.emit(collision)
			
			
func _set_direction(value: Vector2):
	var previous_direction = Vector2(direction)
	direction = value.normalized()
	direction *= direction_scale
	
	if previous_direction != direction:
		# print("MovementManager.direction_changed: ", previous_direction, ", ", direction)
		direction_changed.emit(direction)


func _set_speed(value: float):
	var previous_speed = speed
	
	if value > max_speed:
		print("MovememtManager._set_speed() clamped %d -> %d" % [value, max_speed])
		
	speed = min(value, max_speed)
	
	if previous_speed != speed:
		speed_changed.emit(speed)
	
		
# -- 18 signal listeners
func on_direction_changed(new_direction: Vector2):
	direction = new_direction

# -- 19 subclasses

