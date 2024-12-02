extends AnimatableBody2D



var player: CharacterBody2D
var externalForce = Vector2(0,0)
var isCopy = false
var copyTimer = 0
var externalNum = 0
var oldSpeed = null
var ischanging = false
var timer = 0
@onready var collider: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	self.player = self.get_parent().player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(isCopy):
		copyTimer += delta
		if(copyTimer >= 16):
			self.queue_free()
	collider.disabled = player.sizeProgress >= 0.2
	var newSpeed = externalForce * player.SPEED * delta
	
	if newSpeed != oldSpeed and oldSpeed != null and not ischanging:
		ischanging = true
		timer = 0.5 # Set timer for 0.2 seconds
		# Store the original value of newSpeed
	if ischanging:
		timer -= delta
		if timer <= 0:
			ischanging = false
			# Allow newSpeed to change to its new value after 0.2 seconds
			oldSpeed = newSpeed
	else:
		oldSpeed = newSpeed
	move_and_collide(oldSpeed)
