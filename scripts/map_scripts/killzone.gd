extends Area2D



func _on_body_entered(body):
	if body is CharacterBody2D:
		print("You died!")
		#body.position = body.initial_position
		get_tree().change_scene_to_file("res://scenes/Objects/EndScene.tscn")
