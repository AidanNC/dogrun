extends CanvasLayer

@export var heart_scene: PackedScene
@onready var Player = get_tree().get_nodes_in_group("player")[0]

var health = 0
var screenDims = [1920, 1080]

func _ready() -> void:
	health = Player.health
	for i in range(Player.health):
		addHeart(i)
		
func addHeart(dex, isInitial=true):
	var heart = heart_scene.instantiate()
	if isInitial:
		heart.frame = dex*2 
	else:
		heart.frame = (get_children()[-1].frame +2) % 15
	heart.play()
	var numacross = floor((screenDims[0]) / 125)
	var loc = Vector2(125 * (dex%numacross) + 60, 65 + 125 * floor(dex/numacross))
	heart.position = loc
	add_child(heart)

func _process(delta: float) -> void:
	if Player.health != health:
		print("new change")
		print(Player.health)
		print(health)
		if Player.health < health:
			#update HUD
			var children = get_children()
			for i in range(len(children)-1, -1, -1):
				if i >= Player.health:
					removeHeart(children[i])
		else:
			addHeart(Player.health-1, false)
		health = Player.health

func removeHeart(heart):
	
	heart.animation = "die"
	heart.play()
	await get_tree().create_timer(0.7).timeout
	if !heart:
		return
	heart.hide()
	heart.queue_free()
			
	
