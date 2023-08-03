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
@export var fish_template : PackedScene
@export var spawn_interval := Vector2(0.1, 1.0)
@export var main_direction := Vector2.RIGHT


# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var marker_1 = $Marker1
@onready var marker_2 = $Marker2

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	if global_position.x < 0:
		main_direction = Vector2.RIGHT
	else: 
		main_direction = Vector2.LEFT
		
	print("XXX: main_direction: ", main_direction)
		
	_spawn_corutine()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _spawn_corutine():
	_spawn()
	await get_tree().create_timer(randf_range(spawn_interval.x, spawn_interval.y)).timeout
	_spawn_corutine()
	
	
func _spawn():
	
	var rand_weight = randf()
	var random_position = marker_1.global_position.lerp(marker_2.global_position, rand_weight);
	
	var fish = fish_template.instantiate() as Fish
	add_child(fish)
	fish.main_direction = main_direction
	fish.global_position = random_position
	
# -- 18 signal listeners
# -- 19 innerclasses

