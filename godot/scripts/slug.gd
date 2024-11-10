extends CharacterBody2D


@export var speed = 500
@export var gravity = 20

var movingLeft = false


func _physics_process(delta):
	
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
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$Slug_Hitbox.set_deferred("disabled",true)
		queue_free()
	
