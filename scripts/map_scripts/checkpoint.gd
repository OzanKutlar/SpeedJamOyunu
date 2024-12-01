extends Area2D



func _on_body_entered(body):
	print("Checkpoint Reached")
	body.initial_position = body.position
