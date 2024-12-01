extends Camera2D

# Exported variable to assign the Label node
@export var label: Label

var offSetVector = Vector2(0,0)

func _ready():
	if not label:
		print("Error: Label node path is not assigned or invalid.")
		return
	
	
func _process(_delta):
	var t = get_viewport_transform()
	var pos = t * global_position
	var end = get_viewport().size
	pos.x = 20
	pos.y = end.y - 100
	label.global_position = t.affine_inverse() * pos


