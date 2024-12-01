extends Area2D


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body):
		print("You died!")
		body.position = body.initial_position
		
