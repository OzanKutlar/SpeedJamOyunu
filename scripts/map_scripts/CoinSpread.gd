extends Node


var positions_list = []

func _ready() -> void:
	positions_list.clear()
	
	for child in get_children():
		if child.get_class() == "Node2D":
			#print("Found Node2D")
			positions_list.append(child.position)
			
func get_random_loc() -> Vector2:
	var random_position = positions_list[randi() % positions_list.size()]
	return random_position
