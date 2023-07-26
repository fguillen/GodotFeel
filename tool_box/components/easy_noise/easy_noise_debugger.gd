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
@export var easy_noise: EasyNoise

@export_group("Visuals")
@export var origin_y := 300
@export var point_radius := 4.0
@export var points_distance := 10.0

# -- 09 public variables
# -- 10 private variables
var _values: Array[float]
var _screen_size: Vector2

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_screen_size = get_viewport().get_visible_rect().size
	
	
# -- 15 remaining built-in virtual methods
func _process(_delta):
	_values.append(easy_noise.noise_value)
	
	if (_values.size() * points_distance) > _screen_size.x:
		_values.remove_at(0)
		
	queue_redraw()
	
	
func _draw():
	if not easy_noise.debug:
		return
		
	draw_line(Vector2(0, origin_y + easy_noise.output_min), Vector2(_screen_size.x, origin_y + easy_noise.output_min), Color.DARK_GRAY, 2.0)
	draw_line(Vector2(0, origin_y + easy_noise.output_max), Vector2(_screen_size.x, origin_y + easy_noise.output_max), Color.DARK_GRAY, 2.0)
	
	for i in _values.size():
		var point_position = Vector2(i * points_distance, origin_y + _values[i])
		draw_circle(point_position, point_radius, Color.DARK_SEA_GREEN)

	
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

