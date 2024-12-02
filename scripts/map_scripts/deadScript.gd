extends Node

# Constants
const SAVE_FILE := "user://high_scores.save"
const MAX_HIGH_SCORES := 5

# Variables
var score: int = 0
var time: float = 0
var high_scores: Array = []

# Nodes
var score_label: Label
var time_label: Label
var high_scores_label: Label
var retry_button: Button

func _ready():
	# Load high scores from save file
	score = Global.score
	time = Global.timer
	_load_high_scores()

	# Create and set up the UI
	_create_ui()

	# Update the score and high scores display
	_update_ui()

func _create_ui():
	# Create Score Label
	score_label = Label.new()
	score_label.text = "Score: " + str(score)
	score_label.set_position(Vector2(50, 50))
	add_child(score_label)
	
	time_label = Label.new()
	time_label.text = "Timer: " + str(time)
	time_label.set_position(Vector2(50, 100))
	add_child(time_label)

	# Create High Scores Label
	high_scores_label = Label.new()
	high_scores_label.text = "High Scores:\n"
	high_scores_label.set_position(Vector2(50, 150))
	add_child(high_scores_label)

	# Create Retry Button
	retry_button = Button.new()
	retry_button.text = "Retry"
	retry_button.set_position(Vector2(50, 300))
	retry_button.connect("pressed", _on_retry_button_pressed)
	add_child(retry_button)

func _on_retry_button_pressed():
	# Add current score to high scores, reset score, and save
	_add_score_to_high_scores(score)
	score = 0
	_save_high_scores()

	# Update the score and high scores display
	_update_ui()
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")

	# Optionally, restart the game logic (not implemented here)

func _update_ui():
	# Update the score display
	score_label.text = "Score: %d" % score
	
	time_label.text = "Timer: %d" % score
	# Update the high scores display
	high_scores_label.text = "High Scores:\n"
	for s in high_scores:
		high_scores_label.text += "\n" + str(s)

func _add_score_to_high_scores(new_score: int):
	if new_score > 0:  # Only save positive scores
		high_scores.append(new_score)
		high_scores.sort_custom(sort_ascending)  # Sort scores in descending order
		if high_scores.size() > MAX_HIGH_SCORES:
			high_scores.pop_back()  # Remove the lowest score if exceeding the limit

func sort_ascending(a, b):
	if a > b:
		return true
	return false



func _save_high_scores():
	# Save high scores to browser storage
	ProjectSettings.set_setting("HIGH_SCORES_KEY", high_scores)
	ProjectSettings.save()  # Ensure the changes are written to storage

func _load_high_scores():
	# Load high scores from browser storage
	if ProjectSettings.has_setting("HIGH_SCORES_KEY"):
		high_scores = ProjectSettings.get_setting("HIGH_SCORES_KEY")
	else:
		high_scores = []
