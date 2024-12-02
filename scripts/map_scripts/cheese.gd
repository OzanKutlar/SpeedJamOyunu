extends Area2D

var label: Label
@onready var animation_player = $PickupSound

func _ready() -> void:
	label = get_parent().get_parent().get_node("Camera2D").get_node("ScoreLabel")


func _on_body_entered(body):
	label.add_point()
	animation_player.play(0)
	var newLoc = get_parent().get_random_loc()
	self.position = newLoc
	self.visible = true
	
	
