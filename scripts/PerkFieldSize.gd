extends PerkResource
class_name PerkFieldSize

@export var widthIncrease : int
@export var hieghtIncrease : int
@export var additionalMines : float

const mineDevider = 10

func InitializePerk(rootNode : Node):
	var initialSupposedMines = floor((rootNode.get_node("%MinefieldLogic").fieldWidth * rootNode.get_node("%MinefieldLogic").fieldHieght) / mineDevider)
	rootNode.get_node("%MinefieldLogic").fieldWidth += widthIncrease
	rootNode.get_node("%MinefieldLogic").fieldHieght += hieghtIncrease
	var minesToAdd = (ceil((rootNode.get_node("%MinefieldLogic").fieldWidth * rootNode.get_node("%MinefieldLogic").fieldHieght) / mineDevider)) - initialSupposedMines
	if widthIncrease != 0 or hieghtIncrease != 0:
		rootNode.get_node("%MinefieldLogic").mineCount += minesToAdd
	else:
		rootNode.get_node("%MinefieldLogic").mineCount += additionalMines
