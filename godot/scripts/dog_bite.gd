extends Node2D


func _process(delta):
	
	
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play()
		changeBite(false)
		
	
	
func changeBite(status: bool):
	$BigBite.disabled = status
	$SmallBite.disabled = status
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	changeBite(true)
