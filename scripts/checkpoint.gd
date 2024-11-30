extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
	print("Checkpoint Reached")
	body.initial_position = body.position
