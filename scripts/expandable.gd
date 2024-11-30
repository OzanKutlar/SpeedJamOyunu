extends Node2D

@onready var timer = $Timer

@export var size = 0

@export var speed = 1


var player_inside: CharacterBody2D = null

func _notification(what):
	if what == NOTIFICATION_POST_ENTER_TREE:
		_on_tree_entered()
	
func _on_tree_entered():
	var middle = get_node("Middle")
	middle.play("conveyor_start")
	middle.speed_scale = speed
	print("Expanding Platform")
	if middle == null:
		print("middle node not found!")
		return

	# Get the reference to KillZone
	var killzone = get_node("Killzone")
	if killzone == null:
		print("KillZone node not found!")
		return
	
	

	# Duplicate middle 'size' times
	var end = null
	for i in range(size):
		# Ensure `middle` is valid before duplication
		if middle == null:
			print("middle node not found!")
			return

		# Duplicate the middle instance
		var duplicate = middle.duplicate() as AnimatedSprite2D
		duplicate.play("conveyor_mid")
		if duplicate == null:
			print("Failed to duplicate 'middle'.")
			return

		duplicate.name = "middle_Duplicate_" + str(i + 1)

		# Offset duplicates for better visibility (optional)
		duplicate.position.x = middle.position.x + (16 * (i + 1))  # Adjust offset for 3D; use position for 2D
		end = duplicate
		# Add the duplicate to the same parent as `middle`
		add_child(duplicate)
	
	end.play("conveyor_end")
	killzone.scale.x = -(size + 1)
	killzone.position.x = -14 + (2 * (size + 1))
