extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
	print("You died!")
	body.position = body.initial_position

func _on_timer_timeout():
	Engine.time_scale = 1.0
	
