extends Area2D

@export var type: int;

func _ready():
	var rng = RandomNumberGenerator.new()
	const types = ["soda", "pizza","sushi"]
	type = rng.randf_range(0, 3) if type == -1 else type
	$type.animation = types[type]
	$type.play()



func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "PlayerHitbox":
		hide()
		$CollisionShape2D.queue_free()
		$CollisionShape2D.set_deferred("disabled",true)
		queue_free()
		
