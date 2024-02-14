extends Node

var colorArray = [Color.DARK_ORANGE, Color.BLACK, Color.MIDNIGHT_BLUE, Color.DARK_RED, Color.SEA_GREEN, Color.DARK_CYAN, Color.WEB_PURPLE, Color.DARK_GREEN, Color.CRIMSON, Color.DARK_GOLDENROD, Color.DARK_BLUE, Color.DARK_MAGENTA, Color.DARK_OLIVE_GREEN]

func GetMineValue(realMineValue):
	if realMineValue == 0:
		if randi() % 1000 == 0:
			return ["0", 65, Color.BLACK]
		else:
			return ["", 1, Color.BLACK]
	var fakeValue = randi_range(1, min(2 + realMineValue * 2, 9))
	var retstr = ""
	if randi() % 2 == 1:
		retstr = "(x-" + str(realMineValue) + ")(x-" + str(fakeValue)+")=0"
	else:
		retstr = "(x-" + str(fakeValue) + ")(x-" + str(realMineValue)+")=0"
	var returnArray = [retstr, 18, colorArray.pick_random()]
	return returnArray
