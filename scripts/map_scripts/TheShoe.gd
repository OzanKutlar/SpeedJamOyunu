extends Area2D

@onready var shoe = $Shoe
@onready var timer = $Timer

var positions_list = []

var shoeDirect = 0  # Can be 1 or -1
var shadow_alpha_target = 1.0
var shadow_fade_speed = 1  # Speed of the shadow fade
var killzone_delay_time = 0.2  # Delay time before disabling killzone and enabling collision shape
var time_since_shoe_visible = 0.0  # Track the time since the shoe became visible
var stop = 0

func _ready() -> void:
	connect("body_exited", _on_body_exited)
	timer.connect("timeout", _on_timer_timeout)
	shoe.get_node("CollisionShape2D").disabled = true
	shoe.get_node("Killzone/CollisionShape2D").disabled = true
	shoe.get_node("Shoe").visible = false
	shoe.get_node("Shadow").modulate.a = 0.0

# This function fades in or fades out the shadow's alpha based on shoeDirect
func _start_shadow_fade() -> void:
	shadow_fade_speed = 0.01  # Adjust speed here
	shadow_alpha_target = 1.0  # Final target alpha value (fully visible)
	
# This function gradually increases or decreases the shadow's alpha over time
func _physics_process(delta: float) -> void:
	if shoeDirect == 1:  # Start the process when shoeDirect is 1
		var shadow = shoe.get_node("Shadow")
		if shadow.modulate.a < shadow_alpha_target:
			shadow.modulate.a += shadow_fade_speed * delta  # Slowly increase the alpha
			
			# Once shadow is fully visible, make the shoe visible
			if shadow.modulate.a >= 1.0:
				shoe.get_node("Shoe").visible = true
				shoe.get_node("Killzone/CollisionShape2D").disabled = false  # Enable killzone
				time_since_shoe_visible = 0.0  # Reset the timer once the shoe is visible
				return
		if shoe.get_node("Shoe").visible:
			time_since_shoe_visible += delta  # Accumulate time since the shoe became visible
			
			if time_since_shoe_visible >= killzone_delay_time:
				shoeDirect = -1
				shoe.get_node("Killzone/CollisionShape2D").disabled = true  # Disable killzone
				shoe.get_node("CollisionShape2D").disabled = false  # Enable the main collision shape
	elif shoeDirect == -1:  # Reverse the process when shoeDirect is -1
		var shadow = shoe.get_node("Shadow")
		var shoe2 = shoe.get_node("Shoe")
		if shadow.modulate.a > 0.0:
			shadow.modulate.a -= shadow_fade_speed * delta  # Slowly decrease the alpha
			shoe2.modulate.a -= shadow_fade_speed * delta  # Slowly decrease the alpha
			# Once shadow is fully invisible, make the shoe invisible
			if shadow.modulate.a <= 0.0:
				shoe2.modulate.a = 1
				shoe2.visible = false
				shoeDirect = 0
				if stop == 0:
					timer.start(randf_range(1.0, 3.0))
				shoe.get_node("Shoe").visible = false
				shoe.get_node("Killzone/CollisionShape2D").disabled = true  # Disable killzone
				shoe.get_node("CollisionShape2D").disabled = true  # Disable the main collision shape
				return

	
func _on_body_entered(_body: Node) -> void:
	#print("Entered")
	positions_list.clear()
	
	for child in get_children():
		if child.get_class() == "Node2D":
			print("Found Node2D")
			positions_list.append(child.position)
	
	# Start the timer
	stop = 0
	timer.start()
	
	
func _on_body_exited(_body: Node):
	stop = 1


func _on_timer_timeout() -> void:
	#print("Timer tick")
	if positions_list.size() > 0:
		var random_position = positions_list[randi() % positions_list.size()]
		
		shoe.position = random_position
		shoeDirect = 1
		timer.stop()
