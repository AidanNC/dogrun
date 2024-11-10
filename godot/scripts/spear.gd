extends CharacterBody2D

func _ready() -> void:
	pass
	
	
func _physics_process(delta):
	
	visible = true
	if !is_on_floor():
		velocity.y += 20
	else:
		velocity.x = 0
		velocity.y = 0
		
		
	var theta = atan(velocity.y/velocity.x)
	rotation = PI/2 + theta
	move_and_slide()
	
