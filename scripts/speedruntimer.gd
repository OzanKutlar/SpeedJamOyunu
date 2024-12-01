extends Label

var timerValue: float = 0

func _physics_process(delta):
	timerValue += delta
	var strTimer = str(timerValue);
	text = "Time : " + strTimer.left(strTimer.find(".") + 3)
	
