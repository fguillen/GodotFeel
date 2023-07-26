# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var bricks_destroyed := 0
var bumps_early := 0
var bumps_late := 0
var bumps_perfect := 0
var bounces := 0
var time := 0
var score := 0 : set = _set_score
var total_score := 0

# -- 10 private variables
var _started_time := 0.0

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	GlobalEvents.brick_freed.connect(_increase_bricks_destroyed)
	GlobalEvents.bump_early_performed.connect(_increase_bumps_early)
	GlobalEvents.bump_late_performed.connect(_increase_bumps_late)
	GlobalEvents.bump_perfect_performed.connect(_increase_bumps_perfect)
	GlobalEvents.bounce_performed.connect(_increase_bounces)
	GlobalEvents.level_started.connect(_reset_level.unbind(1))
	GlobalEvents.level_clear.connect(_calculate_stats.unbind(1))
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func get_stat_by_name(stat_name: String) -> int:
	match (stat_name):
		"bricks_destroyed":
			return bricks_destroyed
		"bumps_early":
			return bumps_early
		"bumps_late":
			return bumps_late
		"bumps_perfect":
			return bumps_perfect
		"bounces":
			return bounces
		"time":
			return time
		"score":
			return score
		"total_score":
			return total_score
		_:
			push_error("StatsManager.get_stat_by_name(), name no supported: '%s'" % name)
			return 0
	
	
func reset_total_score():
	total_score = 0
	
	
# -- 17 private methods
func _reset_level():
	bricks_destroyed = 0
	bumps_early = 0
	bumps_late = 0
	bumps_perfect = 0
	bounces = 0
	time = 0
	score = 0
	_started_time = Time.get_unix_time_from_system()
	
	
func _increase_bricks_destroyed(brick: Brick):
	bricks_destroyed += 1
	score += brick.score
	
	
func _increase_bumps_early():
	bumps_early += 1
	score += 5
	
	
func _increase_bumps_late():
	bumps_late += 1
	score += 5
	
	
func _increase_bumps_perfect():
	bumps_perfect += 1
	score += 10
	

func _increase_bounces():
	bounces += 1
	score += 1
	
	
func _calculate_stats():
	time = int(Time.get_unix_time_from_system() - _started_time)
	total_score += score


func _set_score(value: int):
	var previous_score = score
	score = value
	GlobalEvents.emit_score_changed(previous_score, score)
	
	
# -- 18 signal listeners
func _on_game_over():
	reset_total_score()
# -- 19 subclasses

