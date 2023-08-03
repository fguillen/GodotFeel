# -- 01 @tool
# -- 02 class_name
class_name Fish
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Noise")
@export var noise : FastNoiseLite
@export var noise_speed := 1.0

@export_group("Fish")
@export var speed_range := Vector2(50.0, 200.0)
@export var max_oscilation_degrees := 45.0
@export var oscilation_speed := 3.0
@export var bubbles_interval := Vector2(2.0, 5.0)
@export var bubbles_time := Vector2(0.5, 1.5)

@export_group("Sprites")
@export var textures: Array[Texture]


# -- 09 public variables
var main_direction := Vector2.RIGHT


# -- 10 private variables
var _direction := main_direction
var _noise_index := 0.0
var _oscilation_degrees := 0.0
var _viewport_size: Vector2
var _speed: float


# -- 11 onready variables
@onready var body = $Body
@onready var sprite: Sprite2D = $Body/Sprite2D
@onready var bubles_particles: CPUParticles2D = $Body/BublesParticles


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_choose_random_texture()
	noise.seed = int(randf() * 1000)
	_viewport_size = get_viewport().get_visible_rect().size
	_shoot_bubbles_on_intervals()
	
	
# -- 15 remaining built-in virtual methods
func _process(delta):
	_direction_oscilation(delta)
	_speed_change()
	_update_rotation()
	_move(delta)
	_check_self_destroy()
	_direction_flip()
	
	
# -- 16 public methods
# -- 17 private methods
func _direction_oscilation(delta):
	_noise_index += delta * noise_speed
	var noise_value = noise.get_noise_1d(_noise_index)
	var desired_oscilation_degrees = remap(noise_value, -1.0, 1.0, -max_oscilation_degrees, max_oscilation_degrees)
	_oscilation_degrees = move_toward(_oscilation_degrees, desired_oscilation_degrees, delta * oscilation_speed)
	_direction = main_direction.rotated(deg_to_rad(_oscilation_degrees))
	
	
func _speed_change():
	var noise_value = noise.get_noise_1d(_noise_index + 10000)
	_speed = remap(noise_value, -1.0, 1.0, speed_range.x, speed_range.y)
	

func _update_rotation():
	if _direction.x < 0:
		rotation = _direction.angle() + (PI)
	else:
		rotation = _direction.angle()
	
	
func _move(delta: float):
	global_position += _direction * _speed * delta


func _check_self_destroy():
	if global_position.x < -400 or global_position.x > (_viewport_size.x + 400):
		queue_free()


func _choose_random_texture():
	sprite.texture = textures.pick_random()
	
	
func _direction_flip():
	if _direction.x < 0:
		body.scale = Vector2(-1, 1)
	else:
		body.scale = Vector2(1, 1)
		

func _shoot_bubbles_on_intervals():
	await get_tree().create_timer(randf_range(bubbles_interval.x, bubbles_interval.y)).timeout
	_shoot_bubbles()
	_shoot_bubbles_on_intervals()


func _shoot_bubbles():
	if bubles_particles.emitting:
		return
		
	bubles_particles.emitting = true
	await get_tree().create_timer(randf_range(bubbles_time.x, bubbles_time.y)).timeout
	bubles_particles.emitting = false
		
# -- 18 signal listeners
# -- 19 innerclasses

