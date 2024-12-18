extends Node2D

func _ready():
	$AnimatedSprite2D.visible = false

var biting = false
func _process(_delta):
	
	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play()
		if !biting:
			$BiteSound.play()
		changeBite(false)
	
	
func changeBite(status: bool):
	biting = !status
	$BigBite.disabled = status
	$SmallBite.disabled = status
	$AnimatedSprite2D.visible = !status
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	changeBite(true)
