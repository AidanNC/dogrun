extends CanvasLayer

@export var heart_scene: PackedScene
@onready var Player = get_tree().get_nodes_in_group("player")[0]

var health = 0

func _ready() -> void:
	health = Player.health
	for i in range(Player.health):
		var heart = heart_scene.instantiate()
		heart.frame = i*2 % 16
		var loc = Vector2(125 * i + 60, 65)
		heart.position = loc
		add_child(heart)

func _process(delta: float) -> void:
	if Player.health != health:
		health = Player.health
		#update HUD
		var children = get_children()
		for i in range(len(children)-1, -1, -1):
			if i >= health:
				children[i].hide()
				children[i].queue_free()
			
	
