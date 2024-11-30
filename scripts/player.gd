extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var initial_position = Vector2(34,37);



@onready var animated_sprite = $AnimatedSprite2D

var stoppedTime = 0

func _physics_process(delta):
	if velocity == Vector2.ZERO:
		stoppedTime += 1
	else:
		stoppedTime = 0

	if(stoppedTime == 5 * 60):
		print("idle2 Launched")
		animated_sprite.play("idle2")
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	if(Vector2(direction, directionY) == Vector2.ZERO):
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 10)

	move_and_slide()
