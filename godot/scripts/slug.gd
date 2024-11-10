extends CharacterBody2D


@export var speed = 500
@export var gravity = 20

var movingLeft = false
var dead = false

func _physics_process(delta):
	if dead:
		return
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y >= 1000:
			velocity.y = 1000
	if is_on_wall():
		movingLeft = !movingLeft 
		
	
	var horizontal_direction =  -1 if movingLeft else 1
	velocity.x = speed * horizontal_direction
	
	move_and_slide()
	
	$AnimatedSprite2D.animation = "move"
	$AnimatedSprite2D.flip_h = movingLeft
	
	$AnimatedSprite2D.play()
	

	
	
	


func _on_slug_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "DogBite":
		dead = true
		
		$CollisionShape2D.queue_free()
		$CollisionShape2D.set_deferred("disabled",true)
		$CollisionShape2D.hide()
		$Slug_Hitbox.queue_free()
		$Slug_Hitbox.set_deferred("disabled",true)
		$Slug_Hitbox.hide()
		
		$AnimatedSprite2D.animation = "die"
		$AnimatedSprite2D.play()
		$Die.play()
		
	


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
