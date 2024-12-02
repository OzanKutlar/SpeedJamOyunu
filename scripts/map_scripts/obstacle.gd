extends AnimatableBody2D



@export var player: CharacterBody2D
var externalForce = Vector2(0,0)
@onready var collider: CollisionShape2D = $CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	collider.disabled = player.sizeProgress >= 0.2
	self.position += externalForce * player.SPEED
