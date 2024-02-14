extends Node

var colorArray = [Color.DARK_ORANGE, Color.BLACK, Color.MIDNIGHT_BLUE, Color.DARK_RED, Color.SEA_GREEN, Color.DARK_CYAN, Color.WEB_PURPLE, Color.DARK_GREEN, Color.CRIMSON, Color.DARK_GOLDENROD, Color.DARK_BLUE, Color.DARK_MAGENTA, Color.DARK_OLIVE_GREEN]

# Called when the node enters the scene tree for the first time.
func GetMineValue(realMineValue):
	if realMineValue == 0:
		return ["", 1, Color.BLACK]
	var mathValue = randi_range(0, 9)
	var retstr = ""
	if randi() % 2 == 1 and realMineValue >= 2:
		mathValue = randi_range(0, realMineValue)
		retstr = str(realMineValue - mathValue) + " + " + str(mathValue)
	else:
		retstr = str(realMineValue + mathValue) + " - " + str(mathValue)
	var returnArray = [retstr, 35, colorArray.pick_random()]
	return returnArray
