# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal impact_with_coco_occurred()
signal impact_with_brick_occurred()
signal frogy_died()
signal frogy_detached()
signal brick_ready(brick: Brick)
signal brick_freed(brick: Brick)
signal level_started(level_num: int)
signal level_clear(level_num: int)
signal bump_early_performed()
signal bump_late_performed()
signal bump_perfect_performed()
signal bump_performed()
signal bounce_performed()
signal game_over()
signal score_changed(previous: int, actual: int)
signal brick_impacted(brick: Brick)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
	
	
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func emit_impact_with_coco_occurred():
	impact_with_coco_occurred.emit()
	

func emit_impact_with_brick_occurred():
	impact_with_brick_occurred.emit()
	
	
func emit_frogy_died():
	frogy_died.emit()
	

func emit_brick_ready(brick: Brick):
	brick_ready.emit(brick)


func emit_brick_freed(brick: Brick):
	brick_freed.emit(brick)


func emit_level_started(level_num: int):
	level_started.emit(level_num)
		
	
func emit_level_clear(level_num: int):
	level_clear.emit(level_num)
	
	
func emit_bump_early_performed():
	bump_early_performed.emit()
	
	
func emit_bump_late_performed():
	bump_late_performed.emit()
	
	
func emit_bump_perfect_performed():
	bump_perfect_performed.emit()
	
	
func emit_bounce_performed():
	bounce_performed.emit()
	
	
func emit_game_over():
	game_over.emit()
	

func emit_score_changed(previous: int, actual: int):
	score_changed.emit(previous, actual)
	
	
func emit_brick_impacted(brick: Brick):
	brick_impacted.emit(brick)
	
	
	
	

# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

