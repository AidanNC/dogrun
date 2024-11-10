extends CharacterBody2D

func _ready() -> void:
	pass
	
	
func _physics_process(delta):
	visible = true
	if !is_on_floor() && velocity.y != 0:
		velocity.y += 20
		if velocity.y >= 1000:
			velocity.y = 1000
		var theta = atan(velocity.y/velocity.x)
		rotation = PI/2 + theta
		move_and_slide()
	else:
		velocity.x = 0
		velocity.y = 0
		await get_tree().create_timer(0.5).timeout
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$Spear_Hitbox.set_deferred("disabled", true)
		queue_free()
		
		
	
	
