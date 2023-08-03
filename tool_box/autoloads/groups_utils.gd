# 01. @tool
# 02. class_name
# 03. extends
extends Node

# 04. # docstring
#
# 05. signals
# 06. enums
# 07. constants
# 08. exported variables
# 09. public variables
# 10. private variables
var _cache = {}

# 11. onready variables
#
# 12. optional built-in virtual _init method
# 13. optional built-in virtual _enter_tree() method
# 14. built-in virtual _ready method
# 15. remaining built-in virtual methods
# 16. public methods
# 17. private methods		
func _get_first_node_in_group(group_name: String) -> Node:
	if _cache.has(group_name) and is_instance_valid(_cache[group_name]):
		return _cache[group_name]
		
	var node = get_tree().get_first_node_in_group(group_name) as Node
	
	if node:
		print("GroupsUtils.caching_group: ", group_name)
		_cache[group_name] = node
		return node
	else:
		push_warning("No any Node in group '%s'" % group_name)
		return null
	
# 18. signal listeners
# 19. subclasses

