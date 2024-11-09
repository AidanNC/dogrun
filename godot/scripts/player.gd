extends CharacterBody2D

@export var speed = 500
@export var gravity = 20
@export var jump_force = 1200

var facingLeft = true


func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y == 1000:
			velocity.y = 1000
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		
	
	var horizontal_direction = Input.get_axis("move_left","move_right")
	velocity.x = speed * horizontal_direction
	
	move_and_slide()
	
	playerAnimation()
	
	
	$AnimatedSprite2D.play()
	
	
func playerAnimation():
	
	var animation: String = "idle"
	if velocity.x != 0:
		animation = "run"
	else:
		animation = "idle"
		
	const jumpTopRange = 100
	#handle the jumping animation
	if !is_on_floor():
		if velocity.y < -jumpTopRange:
			animation = "jump_up"
		elif  velocity.y > jumpTopRange:
			animation = "jump_down"
		else:
			animation = "jump_top"
	
	$AnimatedSprite2D.animation = animation
	
	#determines which way animation should be facing
	facingLeft = velocity.x < 0 || velocity.x == 0 && facingLeft
	$AnimatedSprite2D.flip_h = facingLeft
	var dogBiteAnimatedSprite = $DogBite.get_node("AnimatedSprite2D")
	dogBiteAnimatedSprite.flip_h = facingLeft
	
	
	
