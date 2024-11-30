extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	IDLE_TRANSFORMATION,
	STANDUP_IDLE
}
var current_state = State.IDLE

const SPEED = 130.0
const TRANSFORMATION_DELAY = 5 * 60
var stopped_time = 0
var initial_position = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D
var random_animation_time = 0.0

func _physics_process(delta):
	handle_movement(delta)
	state_handler(delta)

func handle_movement(delta):
	if velocity == Vector2.ZERO:
		stopped_time += 1
	else:
		stopped_time = 0
	var direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var direction_y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if Vector2(direction, direction_y) != Vector2.ZERO:
		current_state = State.RUN
	else:
		if current_state != State.IDLE_TRANSFORMATION and current_state != State.STANDUP_IDLE:
			current_state = State.IDLE
		elif current_state == State.IDLE_TRANSFORMATION:
			frameChanged();
		else:
			current_state = State.STANDUP_IDLE
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	velocity.x = direction * SPEED
	velocity.y = direction_y * SPEED
	move_and_slide()

func state_handler(delta):
	match current_state:
		State.IDLE:
			if stopped_time >= TRANSFORMATION_DELAY:
				stopped_time = 0
				current_state = State.IDLE_TRANSFORMATION
			else:
				animated_sprite.play("rat_idle1")
		State.RUN:
			animated_sprite.play("rat_run")
		State.IDLE_TRANSFORMATION:
			if animated_sprite.animation != "IdleTransformation":
				animated_sprite.play("IdleTransformation")
		State.STANDUP_IDLE:
			random_animation_time -= delta
			if animated_sprite.frame == animated_sprite.sprite_frames.get_frame_count(animated_sprite.animation) - 1:
				if randi() % 50 == 1:
					animated_sprite.play("rat_idle3")
				else:
					animated_sprite.play("rat_idle2")
				random_animation_time = 1.0
				
func frameChanged():
	if animated_sprite.frame == animated_sprite.sprite_frames.get_frame_count(animated_sprite.animation) - 1:
		animEnd(animated_sprite.animation)
func animEnd(animation_name):
	if animation_name == "IdleTransformation":
		current_state = State.STANDUP_IDLE;
