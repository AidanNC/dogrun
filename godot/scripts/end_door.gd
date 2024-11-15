extends StaticBody2D

@export var nextlevel: PackedScene




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		print("player entered next level")
		get_tree().change_scene_to_packed(nextlevel)
