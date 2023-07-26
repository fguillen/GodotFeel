# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal coco_ready_finished()
signal frogy_ready_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var coco: Coco
var frogy: Frogy
var cleaned_levels: Array[int]
var last_level_played := 0
var last_level_cleaned := 0
var lifes := 3
var levels_cleaned_in_a_row := 0
var immunity := false
var see_final_scene_backdoor := false

# -- 10 private variables
# -- 11 onready variables


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	add_to_group("persist")
	GlobalEvents.level_started.connect(_on_level_started)
	GlobalEvents.level_clear.connect(_on_level_cleared)
	GlobalEvents.game_over.connect(_on_game_over)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func coco_ready(_coco: Coco):
	self.coco = _coco
	coco_ready_finished.emit()
	

func frogy_ready(_frogy: Frogy):
	self.frogy = _frogy
	frogy_ready_finished.emit()
	
	
func serialize() -> Dictionary:
	return {
		"cleaned_levels": cleaned_levels,
		"last_level_played": last_level_played
	}
	
	
func deserialize(data: Dictionary):
	cleaned_levels.assign(data.cleaned_levels)
	last_level_played = data.last_level_played
	

func remove_life():
	if immunity:
		return 
		
	lifes -= 1
	
	
func is_lifes_empty() -> bool:
	return lifes == 0
	

func reset_data():
	cleaned_levels.clear()
	last_level_played = 0
	last_level_cleaned = 0
	levels_cleaned_in_a_row = 0
	

func has_finished_all_leveles_in_a_row() -> bool:
	if levels_cleaned_in_a_row >= 5 or see_final_scene_backdoor:
		return true
	else:
		return false
		

func mark_all_levels_as_cleared():
	for i in 6:
		cleaned_levels.append(i)
	
	DataPersister.save_data()	
	
# -- 17 private methods

# -- 18 signal listeners
func _on_level_cleared(level_num: int):
	levels_cleaned_in_a_row += 1
	last_level_cleaned = level_num
	print("XXX: levels_cleaned_in_a_row: ", levels_cleaned_in_a_row)
		
	if not cleaned_levels.has(level_num):
		cleaned_levels.append(level_num)
		DataPersister.save_data()
		
	

func _on_level_started(level_num: int):
	last_level_played = level_num
	DataPersister.save_data()


func _on_game_over():
	lifes = 3	
	levels_cleaned_in_a_row = 0
	DataPersister.save_data()
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
		
# -- 19 subclasses

