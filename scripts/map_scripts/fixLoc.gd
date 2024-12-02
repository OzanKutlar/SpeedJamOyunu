extends Camera2D

# Exported variable to assign the Label node
@export var label: Label
@export var label2: Label

var offSetVector = Vector2(0,0)

func _ready():
	if not label:
		print("Error: Label node path is not assigned or invalid.")
		return
	
	
func _process(_delta):
	var t = get_viewport_transform()
	var pos = t * global_position
	var pos2 = t * global_position
	var end = get_viewport().size
	pos.x = 20
	pos.y = end.y - 100
	label.global_position = t.affine_inverse() * pos
	pos2.x = 10
	pos2.y = 10
	label2.global_position = t.affine_inverse() * pos2
