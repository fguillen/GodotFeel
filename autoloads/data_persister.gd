# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
const DATA_PATH = "user://savegame.json"

# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _is_saving := false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
#	save_data.call_deferred()
	load_data.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func save_data():
	print("DataPersister.save_data(%s)" % DATA_PATH)
	
	if _is_saving:
		push_warning("DataPersister.saving blocked because already in saving")
		return
		
	_is_saving = true
	var result = []
	
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		if not node.has_method("serialize"):
			print("DataPersister: node '%s' is missing a serialize() method, skipped" % node.name)
			continue

		var node_path = node.get_path()
		var node_data = node.call("serialize")
		print("DataPersister.save_data().node_path: %s" % node_path)
		result.append({
			"node_path": node_path,
			"data": node_data
		})
		
	var file = FileAccess.open(DATA_PATH, FileAccess.WRITE)
	file.store_line(JSON.stringify(result, "  "))
	_is_saving = false
	
	
func load_data():
	print("DataPersister.load_data(%s)" % DATA_PATH)
	if not FileAccess.file_exists(DATA_PATH):
		print("DataPersister.load_data() path not found: %s" % DATA_PATH)
		return 
		
	var file = FileAccess.open(DATA_PATH, FileAccess.READ)
	var game_data = JSON.parse_string(file.get_as_text())
	if game_data == null:
		push_error("Error parsing user data: %s" % DATA_PATH)
		return
		
	print("DataPersister.game_data: ", game_data)
	
	for node_data in game_data:
		var node = get_node_or_null(node_data.node_path)
		if not node:
			print("DataPersister: node '%s' not found, skipped" % node_data.node_path)
			continue
			
		if not node.has_method("deserialize"):
			print("DataPersister: node '%s' is missing a deserialize() method, skipped" % node.name)
			continue
		
		print("DataPersister.load_data().node_path: %s" % node_data.node_path)	
		node.call("deserialize", node_data.data)
		

func reset_persisted_data():
	print("DataPersister.reset_persisted_data()")
	DirAccess.remove_absolute(DATA_PATH)
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses

