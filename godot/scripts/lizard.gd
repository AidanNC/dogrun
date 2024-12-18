extends CharacterBody2D


@onready var Player = get_tree().get_nodes_in_group("player")[0]
@export var spear_scene: PackedScene
@export var throw_power: int

var lookLeft = true
var dead = false

func _ready():
	var rng = RandomNumberGenerator.new()
	$AnimatedSprite2D.frame = rng.randf_range(0, 32)

func _physics_process(_delta):
	if dead:
		return
	if !is_on_floor():
		velocity.y += 20
		if velocity.y >= 1000:
			velocity.y = 1000
	move_and_slide()
	
	lookLeft = Player.global_position.x < global_position.x
	$AnimatedSprite2D.animation = "throw"
	$AnimatedSprite2D.flip_h = !lookLeft
	$AnimatedSprite2D.play()

	
func throwSpear():
	
	
	#calculate the angle and corresponding velocities for throwing
	#this didn't make any sense coding it, so idk I will need to redo this at some point
	var distance = abs(Player.global_position.x - global_position.x)
	
	if distance > 5000:
		return
	
	var g = 20 # should be consistent with spear gravity
	var inner = distance * g /(throw_power * throw_power)
	var theta = 0.5 * asin(inner)
	
	var v = 1.1
	var y_velo = sin(theta) * distance * v
	var x_velo = cos(theta) * distance * v
	#end section that neeeds to be redone
	
	var spear = spear_scene.instantiate()
	
	spear.position = Vector2(-50,-100)
	spear.velocity.x = -x_velo if lookLeft else x_velo
	spear.velocity.y = -y_velo
	spear.rotation = PI /2
	spear.scale.y = -1 if lookLeft else 1
	add_child(spear)
	


func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.frame == 15:
		throwSpear()
		$Throw.play()
		


func _on_lizard_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "DogBite":
		
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
		$CollisionShape2D.hide()
		$Lizard_Hitbox.set_deferred("disabled",true)
		$Lizard_Hitbox.hide()
		
		$AnimatedSprite2D.animation = "die"
		$AnimatedSprite2D.play()
		$Die.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
