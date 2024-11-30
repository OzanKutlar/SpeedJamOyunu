extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var initial_position = Vector2(34,37);



@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = velocity.x * 0.6
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = velocity.y * 0.6

	move_and_slide()
