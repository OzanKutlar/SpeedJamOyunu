extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	#game_manager.add_point()
	#animation_player.play("pickup")
	var newLoc = get_parent().get_random_loc()
	self.position = newLoc
	self.visible = true
	
	
