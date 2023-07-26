extends AudioStreamPlayer

@export var random_pitch := false
@export var start_at_random_seek := false
@export var loop := false
@export var samples: Array[AudioStream]
@export var debouce_time := 0.0
@export var reparent_on_ready := false
@export var fade_in_time := 0.0
@export var fade_out_time := 0.0

@onready var _timer = $Timer

var _is_in_debouncing_time := false
var _tween_fade: Tween
var _original_valume: float
var _is_ready := false


func _ready():
	tree_exiting.connect(_exit)
	
	if reparent_on_ready:
		reparent.call_deferred(get_tree().current_scene, true)

	_original_valume = volume_db
	_is_ready = true
	
	if fade_in_time > 0:
		volume_db = -80.0
	

func perform():
	if not _is_ready:
		await ready
		
	if _is_in_debouncing_time:
		return
		
	if debouce_time > 0:
		_is_in_debouncing_time = true
		_timer.start(debouce_time)
		
	if fade_in_time > 0.0:
		_fade_in()
		
	if not samples.is_empty():
		stream = _random_sample()
		
	if random_pitch:
		pitch_scale = randf_range(0.8, 1.2)
	
	var starting_seek = 0.0 if not start_at_random_seek else _random_seek()
	play(starting_seek)
	
	if loop:
		if not finished.is_connected(perform):
			finished.connect(perform)
	else:
		if finished.is_connected(perform):
			finished.disconnect(perform)


func finish():
	if fade_out_time > 0.0:
		await _fade_out()
		
	stop()


func _fade_in():
	if _tween_fade and _tween_fade.is_running():
		_tween_fade.stop()
		
	_tween_fade = get_tree().create_tween()#
	_tween_fade.tween_property(self, "volume_db", _original_valume, fade_in_time).from(-80.0)
	await _tween_fade.finished
	
	
func _fade_out():
	if _tween_fade and _tween_fade.is_running():
		_tween_fade.stop()
		
	_tween_fade = get_tree().create_tween()#
	_tween_fade.tween_property(self, "volume_db", -80.0, fade_out_time)
	await _tween_fade.finished
	

func _random_seek():
	return randf_range(0.0, stream.get_length())

	
func _random_sample() -> AudioStream:
	return samples.pick_random()
	

func _on_timer_timeout():
	_is_in_debouncing_time = false


func _exit():
	if _tween_fade and _tween_fade.is_running():
		_tween_fade.stop()
