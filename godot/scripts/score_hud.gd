extends CanvasLayer

@onready var Player = get_tree().get_nodes_in_group("player")[0]

var score 

func _ready() -> void:
	score = Player.score
		

func _process(delta: float) -> void:
	$Score.text = str(Player.score)
