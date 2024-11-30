extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	IDLE_TRANSFORMATION
}
var current_state = State.IDLE

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var initial_position = Vector2(34, 37)
const TRANSFORMATION_DELAY = 5 * 60

@onready var animated_sprite = $AnimatedSprite2D

var stopped_time = 0

func _physics_process(delta):
	handle_movement(delta)
	state_handler(delta)

func handle_movement(delta):
	if velocity == Vector2.ZERO:
		stopped_time += 1
	else:
		stopped_time = 0
		
	var direction = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	
	if Vector2(direction, direction_y) != Vector2.ZERO:
		current_state = State.RUN
	else:
		current_state = State.IDLE
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 10)
	move_and_slide()

func state_handler(delta):
	match current_state:
		State.IDLE:
			if stopped_time >= TRANSFORMATION_DELAY:
				current_state = State.IDLE_TRANSFORMATION
			else:
				animated_sprite.play("rat_idle")
		State.RUN:
			animated_sprite.play("rat_run")
		State.IDLE_TRANSFORMATION:
			if not animated_sprite.is_playing():
				animated_sprite.play("IdleTransformation")
			elif animated_sprite.animation == "IdleTransformation" and not animated_sprite.is_playing():
				current_state = State.IDLE
				if randi() % 100 < 5:
					animated_sprite.play("rat_idle3")
				else:
					animated_sprite.play("rat_idle2")
