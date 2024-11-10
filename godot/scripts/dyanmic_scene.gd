extends Node2D

@export var platform_scene: PackedScene


func _ready() -> void:
	
	#var loc = get_node("Player").position
	#print(loc)
	for i in range(20):
		
		var plat = platform_scene.instantiate()
		var collision_shape = plat.get_node("CollisionShape2D")
		var shape = collision_shape.shape
		var width = shape.extents.x * 2
		var loc = Vector2(width*i, 1900)
		plat.position = loc
		add_child(plat)
		print(loc)
	
	
