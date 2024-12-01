extends Node2D


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
		var duplicateMid = middle.duplicate() as AnimatedSprite2D
		duplicateMid.play("conveyor_mid")
		if duplicateMid == null:
			print("Failed to duplicateMid 'middle'.")
			return

		duplicateMid.name = "middle_duplicateMid_" + str(i + 1)

		# Offset duplicateMids for better visibility (optional)
		duplicateMid.position.x = middle.position.x + (16 * (i + 1))  # Adjust offset for 3D; use position for 2D
		end = duplicateMid
		# Add the duplicateMid to the same parent as `middle`
		add_child(duplicateMid)
	
	end.play("conveyor_end")
	killzone.scale.x = -(size + 1)
	killzone.position.x = -14 + (2 * (size + 1))
