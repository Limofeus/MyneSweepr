extends Node

const cellOffset = 110
@export var numberPrefab : PackedScene

func TriggerEffect():
	var mineNums = get_parent().get_node("%MinefieldLogic").mineNumbers
	var mWidth = mineNums.size()
	var mHieght = mineNums[0].size()
	var topLeftSum = 0
	var topRightSum = 0
	var botLeftSum = 0
	var botRightSum = 0
	for i in range(3):
		for j in range(3):
			if (i + j <= 2):
				#print("Capturing cell for " + str(i) + " " + str(j))
				if mineNums[i][j] > 0:
					topLeftSum += 1
				if mineNums[mWidth - i - 1][j] > 0:
					topRightSum += 1
				if mineNums[i][mHieght - j - 1] > 0:
					botLeftSum += 1
				if mineNums[mWidth - i - 1][mHieght - j - 1] > 0:
					botRightSum += 1
	print("TLS")
	print(str(topLeftSum))
	print("TRS")
	print(str(topRightSum))
	print("BLS")
	print(str(botLeftSum))
	print("BRS")
	print(str(botRightSum))
	if topLeftSum >= 2:
		var numInstance = numberPrefab.instantiate()
		get_parent().get_node("%ShownLayer").add_child(numInstance)
		numInstance.position = Vector2((-1 + 0) * cellOffset, (-1 + 0) * cellOffset)
		numInstance.get_child(0).text = str(mineNums[0][0])
	if topRightSum >= 2:
		var numInstance = numberPrefab.instantiate()
		get_parent().get_node("%ShownLayer").add_child(numInstance)
		numInstance.position = Vector2((mWidth + 0) * cellOffset, (-1 + 0) * cellOffset)
		numInstance.get_child(0).text = str(mineNums[mWidth - 1][0])
	if botLeftSum >= 2:
		var numInstance = numberPrefab.instantiate()
		get_parent().get_node("%ShownLayer").add_child(numInstance)
		numInstance.position = Vector2((-1 + 0) * cellOffset, (mHieght + 0) * cellOffset)
		numInstance.get_child(0).text = str(mineNums[0][mHieght - 1])
	if botRightSum >= 2:
		var numInstance = numberPrefab.instantiate()
		get_parent().get_node("%ShownLayer").add_child(numInstance)
		numInstance.position = Vector2((mWidth + 0) * cellOffset, (mHieght + 0) * cellOffset)
		numInstance.get_child(0).text = str(mineNums[mWidth - 1][mHieght - 1])
