extends Label

var timerValue: float = 0

func add_point():
	timerValue += 1
	Global.score = timerValue
	var strTimer = str(timerValue);
	text = "Score : " + strTimer.left(strTimer.find(".") + 3)
	
	

	
