extends Area2D

func _ready():
	var rng = RandomNumberGenerator.new()
	const types = ["soda", "pizza","sushi"]
	$type.animation = types[rng.randf_range(0, 3)]
	$type.play()
