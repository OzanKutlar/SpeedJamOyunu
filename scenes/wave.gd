extends Area2D

@onready var timer = $Timer

var player_inside: CharacterBody2D = null

func _ready():
	connect('body_exited', _on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D: # Check if the body is the player
		print("Body entered")
		player_inside = body # Store the reference to the player

func _on_body_exited(body):
	print("Body exit")
	player_inside = null # Clear the reference

func _physics_process(delta):
	if player_inside != null: # If the player is inside the area
		player_inside.velocity.x = -130

