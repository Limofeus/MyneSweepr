extends Node

@export var warningPrefab : PackedScene
const cellOffset = 110

func TriggerEffect():
	var mineNums = get_parent().get_node("%MinefieldLogic").mineNumbers
	var coordPairs = []
	for i in range(mineNums.size()):
		for j in range(mineNums[i].size()):
			if mineNums[i][j] > 0:
				coordPairs.append([i, j])
	var coords = coordPairs.pick_random()
	var warnInstance = warningPrefab.instantiate()
	get_parent().get_node("%ShownLayer").add_child(warnInstance)
	warnInstance.position = Vector2((coords[0] + 0) * cellOffset, (coords[1] + 0) * cellOffset)
