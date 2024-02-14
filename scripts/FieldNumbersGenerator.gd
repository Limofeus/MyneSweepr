extends Node

@export var backgroundContainer : GridContainer
@export var minefieldLogic : Node

func GenerateNumbers(fieldWidth : int, fieldHieght : int):
	for i in range(fieldHieght):
		for j in range(fieldWidth):
			var realMineValue = GetRealMineValue(j, i, fieldWidth, fieldHieght)
			minefieldLogic.revealedNumbers[j][i] = realMineValue
			
			var obscuredMineValue = get_child(randi_range(0, get_child_count() - 1)).GetMineValue(realMineValue)
			
			var backplate = backgroundContainer.get_child(j + (i * fieldWidth))
			
			if minefieldLogic.mineNumbers[j][i] == 0:
				backplate.get_child(0).text = obscuredMineValue[0]
				backplate.get_child(0).set("theme_override_font_sizes/font_size", obscuredMineValue[1])
				backplate.get_child(0).modulate = obscuredMineValue[2]
			else:
				backplate.get_child(0).text = ""
			
func GetRealMineValue(x_pos : int, y_pos : int, fieldWidth : int, fieldHieght : int): #For some unfuckingknown reason I cant get width and hieght from minefield logic array, it says that there would be a potential infinite recursion! what a shitload
	var realValue = 0
	for i in range(3):
		for j in range(3):
			realValue += CheckIfInsideArray(x_pos + i - 1,y_pos + j - 1, fieldWidth, fieldHieght)
	#print("Real value on cell " + str(x_pos) + ", " + str(y_pos)+ " is " + str(realValue))
	return realValue
	
func CheckIfInsideArray(x_pos : int, y_pos : int, fieldWidth : int, fieldHieght : int):
	if(x_pos < 0 or y_pos < 0 or x_pos >= fieldWidth or y_pos >= fieldHieght):
		return 0
	else:
		return minefieldLogic.mineNumbers[x_pos][y_pos]
	
