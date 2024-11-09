extends Node2D

@export var platform_scene: PackedScene


func _ready() -> void:
	var loc = get_node("Player").position
	
	var plat1 = platform_scene.instantiate()
	loc[1] += 500
	plat1.position = loc
	add_child(plat1)
	print(loc)
	
