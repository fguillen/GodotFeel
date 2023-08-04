extends Sprite2D

signal direction_changed(value: Vector2)

var _speed := 300.0
var _direction := Vector2.RIGHT : set = _set_direction

func _ready():
	_direction = Vector2.RIGHT
	

func _process(delta):
	if global_position.x < 705:
		_direction = Vector2.RIGHT
	elif global_position.x > 1213:
		_direction = Vector2.LEFT
		
	global_position += _direction * _speed * delta


func _set_direction(value: Vector2):
	print("XXX _set_direction: ", value)
	_direction = value
	direction_changed.emit(_direction)
	
