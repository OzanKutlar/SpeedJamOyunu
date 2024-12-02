extends Area2D

@onready var shoe = $Shoe
@onready var timer = $Timer
@onready var spawnArea = $SpawnArea
@export var player: CharacterBody2D

var positions_list = []

func _ready() -> void:
	timer.connect("timeout", _on_timer_timeout)

	
func _on_body_entered(body: Node) -> void:
	print("Entered")
	positions_list.clear()
	
	for child in get_children():
		if child.get_class() == "Node2D":
			print("Found Node2D")
			positions_list.append(child.position)
	
	# Start the timer
	timer.start()

func _on_timer_timeout() -> void:
	#print("Timer tick")
	if positions_list.size() > 0:
		var random_position = positions_list[randi() % positions_list.size()]
		
		shoe.position = random_position
		
		timer.start(randf_range(1.0, 3.0))
