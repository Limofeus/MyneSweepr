extends Node

# MINE NUMBER OBSCURIFIERS SHOULD RETURN ARRAY OF 3 VALUES WITH GetMineValue FUNCTION
# 1) STRING - OBSCURIFIED VALUE 2) VALUE - LABEL SCALE 3) COLOR - FONT COLOR
var colorArray = [Color.CYAN, Color.ORANGE, Color.BLACK, Color.BLUE, Color.RED, Color.SEA_GREEN, Color.LIME, Color.PURPLE, Color.DARK_GREEN, Color.CRIMSON, Color.YELLOW_GREEN, Color.DARK_BLUE]

func GetMineValue(realMineValue):
	if realMineValue == 0:
		if randi() % 1000 == 0:
			return ["0", 65, Color.BLACK]
		else:
			return ["", 1, Color.BLACK]
	var retColor = colorArray.pick_random()
	match float(realMineValue):
		0.5:
			retColor = Color.DODGER_BLUE
		1.0:
			retColor = Color.BLUE
		1.5:
			retColor = Color.STEEL_BLUE
		2.0:
			retColor = Color.LIME_GREEN
		2.5:
			retColor = Color.DARK_MAGENTA
		3.0:
			retColor = Color.RED
		3.5:
			retColor = Color.REBECCA_PURPLE
		4.0:
			retColor = Color.DARK_BLUE
		5.0:
			retColor = Color.DARK_RED
		6.0:
			retColor = Color.DARK_CYAN
		7.0:
			retColor = Color.BLACK
		8.0:
			retColor = Color.DIM_GRAY
		9.0:
			retColor = Color.DEEP_PINK
	var returnArray = [str(realMineValue), 65, retColor]
	return returnArray
