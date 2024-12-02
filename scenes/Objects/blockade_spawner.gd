extends StaticBody2D


@export var player: CharacterBody2D
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize a timer with a random duration between 1 and 3 seconds
	
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

# Function triggered when the timer times out
func _on_timer_timeout():
	# Check if the "Blockade" node exists
	if $Blockade:
		# Create a duplicate of the "Blockade" node
		var new_blockade = $Blockade.duplicate()
		add_child(new_blockade)  # Add the new node to the parent of the StaticBody2D
		new_blockade.isCopy = true
		new_blockade.position = Vector2(0, 16)  # Position below the original
		var random_time = randf_range(1.0, 3.0)
		timer.wait_time = random_time
		timer.start()
