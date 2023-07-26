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
@export var materials: Array[Material]

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_load_materials()
	

func _load_materials():
	var sprites = []
	print("PreloadMaterials._ready(): INI")
	for material in materials:
		print("PreloadMaterials._ready().material:", material)
		var sprite = Sprite2D.new()
		sprite.texture = PlaceholderTexture2D.new()
		sprite.material = material
		add_child(sprite)
		sprites.append(sprite)
	print("PreloadMaterials._ready(): END")
	
	await get_tree().create_timer(0.2).timeout
	for sprite in sprites:
		sprite.queue_free()
	
#
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses

