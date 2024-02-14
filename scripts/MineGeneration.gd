extends Node

@export var minefieldLogic : Node
@export var hiddenLayer : Control

var simpleMineScene = preload("res://scenes/mine.tscn")

const cellOffset = 110

# Called when the node enters the scene tree for the first time.
func GenerateMines(fieldWidth : int, fieldHieght : int, mineCount : float):
	
	var minesGenerated = 0;
	var emptyCells = []
	
	for i in range(fieldHieght * fieldWidth):
		if not (fieldHieght == 9 and fieldWidth == 9 and i == 40):
			emptyCells.append(i)

	while(minesGenerated < mineCount):
		
		var emptyCellIndex = randi_range(0, emptyCells.size() - 1)
		var cellIndex = emptyCells[emptyCellIndex]
		emptyCells.remove_at(emptyCellIndex)
		
		var x_pos = int(cellIndex % fieldWidth)
		var y_pos = int(floor(cellIndex / fieldWidth))
		
		if("mineShift" in minefieldLogic.modifierTags) and (randi() % 3 == 0):
			var otherCell = AddShiftedMine(x_pos, y_pos)
			if otherCell >= 0:
				emptyCells.erase(otherCell)
		else:
			AddNormalMine(x_pos, y_pos)
		minesGenerated += 1

func AddNormalMine(x_pos : int, y_pos: int):
		var mineInstance = simpleMineScene.instantiate()
		hiddenLayer.add_child(mineInstance)
		mineInstance.position = Vector2(cellOffset * x_pos, cellOffset * y_pos)
		minefieldLogic.mineNumbers[x_pos][y_pos] += 1
		
func AddShiftedMine(x_pos : int, y_pos: int):
	var shiftsPossible = ["U", "R", "D", "L"]
	var shiftDir = ""
	if(x_pos < 1) or (minefieldLogic.mineNumbers[x_pos - 1][y_pos] > 0):
		shiftsPossible.erase("L")
	if(x_pos >= (minefieldLogic.mineNumbers.size() - 1)) or (minefieldLogic.mineNumbers[x_pos + 1][y_pos] > 0):
		shiftsPossible.erase("R")
	if(y_pos < 1) or (minefieldLogic.mineNumbers[x_pos][y_pos - 1] > 0):
		shiftsPossible.erase("U")
	if(y_pos >= (minefieldLogic.mineNumbers[x_pos].size() - 1)) or (minefieldLogic.mineNumbers[x_pos][y_pos + 1] > 0):
		shiftsPossible.erase("D")
	if shiftsPossible.size() == 0:
		AddNormalMine(x_pos, y_pos)
		return -1
	else:
		shiftDir = shiftsPossible.pick_random()
		match shiftDir:
			"U":
				var mineInstance = simpleMineScene.instantiate()
				hiddenLayer.add_child(mineInstance)
				mineInstance.position = Vector2(cellOffset * x_pos, cellOffset * (y_pos - 0.5))
				minefieldLogic.mineNumbers[x_pos][y_pos] += 0.5
				minefieldLogic.mineNumbers[x_pos][y_pos - 1] += 0.5
				return (x_pos) + ((y_pos - 1) * minefieldLogic.mineNumbers.size())
			"R":
				var mineInstance = simpleMineScene.instantiate()
				hiddenLayer.add_child(mineInstance)
				mineInstance.position = Vector2(cellOffset * (x_pos + 0.5), cellOffset * y_pos)
				minefieldLogic.mineNumbers[x_pos][y_pos] += 0.5
				minefieldLogic.mineNumbers[x_pos + 1][y_pos] += 0.5
				return (x_pos + 1) + ((y_pos) * minefieldLogic.mineNumbers.size())
			"D":
				var mineInstance = simpleMineScene.instantiate()
				hiddenLayer.add_child(mineInstance)
				mineInstance.position = Vector2(cellOffset * x_pos, cellOffset * (y_pos + 0.5))
				minefieldLogic.mineNumbers[x_pos][y_pos] += 0.5
				minefieldLogic.mineNumbers[x_pos][y_pos + 1] += 0.5
				return (x_pos) + ((y_pos + 1) * minefieldLogic.mineNumbers.size())
			"L":
				var mineInstance = simpleMineScene.instantiate()
				hiddenLayer.add_child(mineInstance)
				mineInstance.position = Vector2(cellOffset * (x_pos - 0.5), cellOffset * y_pos)
				minefieldLogic.mineNumbers[x_pos][y_pos] += 0.5
				minefieldLogic.mineNumbers[x_pos - 1][y_pos] += 0.5
				return (x_pos - 1) + ((y_pos) * minefieldLogic.mineNumbers.size())
