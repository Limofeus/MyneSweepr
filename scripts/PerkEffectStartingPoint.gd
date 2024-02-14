extends Node

@export var noticePrefab : PackedScene
const cellOffset = 110

func TriggerEffect():
	var revealedNums = get_parent().get_node("%MinefieldLogic").revealedNumbers
	var coordPairs = []
	for i in range(revealedNums.size()):
		for j in range(revealedNums[i].size()):
			if revealedNums[i][j] == 0:
				coordPairs.append([i, j])
	var coords = coordPairs.pick_random()
	var warnInstance = noticePrefab.instantiate()
	get_parent().get_node("%ShownLayer").add_child(warnInstance)
	warnInstance.position = Vector2((coords[0] + 0) * cellOffset, (coords[1] + 0) * cellOffset)
