extends CharacterBody2D

@export var speed = 1000
@export var gravity = 30
@export var jump_force = 1200
var max_gravity = 1500
var health = 5

var facingLeft = true
var inHitstun = false


func _physics_process(delta):
	
	
	if !is_on_floor():
		velocity.y += gravity
		
		if velocity.y == max_gravity:
			velocity.y = max_gravity
	
	
	handleMovement()
	
	move_and_slide()
	
	playerAnimation()
	
	
	$AnimatedSprite2D.play()
	
	
func playerAnimation():
	if inHitstun:
		return
	
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
	#var dogBiteAnimatedSprite = $DogBite.get_node("AnimatedSprite2D")
	#dogBiteAnimatedSprite.flip_h = facingLeft
	positionDogBite()
	
func handleMovement():
	if inHitstun:
		return
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
	var horizontal_direction = Input.get_axis("move_left","move_right")
	velocity.x = speed * horizontal_direction 
	
	
func positionDogBite():
	
	$DogBite.scale.x = -1 if facingLeft else 1
	
	#determine if we are in the upward jump
	if $AnimatedSprite2D.animation == "jump_up":
		$DogBite.position.x = -10 if facingLeft else 0
		$DogBite.position.y = 14
	elif $AnimatedSprite2D.animation == "run":
		$DogBite.position.x = -56 if facingLeft else 33
		$DogBite.position.y = 6
	else:
		$DogBite.position.x = -38 if facingLeft else 23
		$DogBite.position.y = 10
	
	
func setHitStun():
	inHitstun = true
	await get_tree().create_timer(0.5).timeout
	inHitstun = false
	
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Slug_Hitbox" || area.name == "Spear_Hitbox":
		setHitStun()
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, 0.1)
		tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.1)
		tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, 0.1)
		tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.2)
		
		#figure out which direction you got hit from
		var loc1 = area.global_position
		if loc1.x >= global_position.x: #you were hit from the right
			facingLeft = true #face the direction you were hit
		else:
			facingLeft = false
		velocity.y = -1000
		velocity.x = -1000 if facingLeft else 1000
		$AnimatedSprite2D.animation = "jump_up"
		
			
		
		health -= 1
		print(health)
