extends Area2D

@onready var timer = $Timer

var player_inside: CharacterBody2D = null

func _ready():
	connect('body_exited', _on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D: # Check if the body is the player
		print("Body entered")
		body.externalForce = Vector2.UP * 0.5

func _on_body_exited(body):
	print("Body exit")
	body.externalForce = Vector2(0, 0)
