extends Node2D

@export var level1: PackedScene


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("clicked start")
		get_tree().change_scene_to_packed(level1)
