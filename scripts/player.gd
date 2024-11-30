extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpTimer = 0


@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		jumpTimer = jumpTimer + 1
		#velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (jumpTimer < 10):
		velocity.y = JUMP_VELOCITY

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
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
