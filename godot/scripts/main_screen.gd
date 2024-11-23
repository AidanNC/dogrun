extends Node2D

@export var level1: PackedScene


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("clicked start")
		get_tree().change_scene_to_packed(level1)


func _on_area_2d_mouse_entered() -> void:
	$Start_Hover.visible = true;
	$Start.visible = false;
	


func _on_area_2d_mouse_exited() -> void:
	$Start_Hover.visible = false;
	$Start.visible = true;
