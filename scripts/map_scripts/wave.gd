extends Area2D



var player_inside: CharacterBody2D = null
@export var parent: Node2D = null

func _ready():
	connect('body_exited', _on_body_exited)


var processed_bodies = []

func get_direction(node: Node2D) -> Vector2:
	match int(round(node.rotation_degrees)):
		0:
			return Vector2.RIGHT
		90:
			return Vector2.DOWN
		180:
			return Vector2.LEFT
		270:
			return Vector2.UP
		_:
			match int(round(node.rotation_degrees + 360)):
				0:
					return Vector2.RIGHT
				90:
					return Vector2.DOWN
				180:
					return Vector2.LEFT
				270:
					return Vector2.UP
				_:
					return Vector2.ZERO


# The signal handler for when a body enters the Area2D
func _on_body_entered(body):
	print("Something entered.")
	if body is CharacterBody2D:  # Check if the body is the player
		print("Body entered (CharacterBody2D)")
		body.externalForce = get_direction(parent) * (0.25 * parent.speed)
		body.externalNum += 1
	if body is AnimatableBody2D:  # Check if it's a RigidBody2D
		print("Block entered (AnimatableBody2D)")
		body.externalForce = get_direction(parent) * (0.25 * parent.speed)
		body.externalNum += 1

	# Mark this body as processed to avoid reapplying the force every frame
	processed_bodies.append(body)

# The signal handler for when a body exits the Area2D
func _on_body_exited(body):
	print("Body exit")
	body.externalNum -= 1
	if(body.externalNum == 0):
		body.externalForce = Vector2(0, 0)
	# Remove the body from the list of processed bodies when it exits
	processed_bodies.erase(body)
	
func _process(_delta):
	# Get all bodies that are currently inside the Area2D
	var bodies = get_overlapping_areas()
	for body in processed_bodies:
		if body not in bodies:
			processed_bodies.erase(body)
			
	for body in bodies:
		# Apply force only to bodies that are not already processed
		if body not in processed_bodies:
			if body is CharacterBody2D:  # Check if the body is the player
				print("Body entered (CharacterBody2D - process)")
				body.externalForce = get_direction(parent) * (0.25 * parent.speed)
			if body is AnimatableBody2D:  # Check if it's a RigidBody2D
				print("Block entered (AnimatableBody2D - process)")
				body.externalForce = get_direction(parent) * (0.25 * parent.speed)
			processed_bodies.append(body)  # Mark it as processed
