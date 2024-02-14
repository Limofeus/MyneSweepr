extends Node

@export var targetPerkPairLevel : int = 1
@export var perkGenerateCount : int = 3
@export var perks : Array[PerkResource] = []

@export var starterPerks : Array[PerkResource] = []

@export var minefieldLogic : Node
@export var perkSelectScreen : Node
@export var playerStats : Node

@export var obscurifierHolder : Node
@export var onStartEffectsHolder : Node

var currentLevel = 0
var solvingLevel : bool

func _ready():
	if starterPerks.size() > 0:
		ApplyPerks(starterPerks)
	else:
		StartNewLevel()
	pass

func StartNewLevel():
	minefieldLogic.ClearField()
	minefieldLogic.GenerateLevel()
	solvingLevel = true
	currentLevel += 1
	playerStats.ResetTimer()
	playerStats.UpdateLevelLabel(currentLevel)
	
	onStartEffectsHolder.TriggerEffects()

func LevelSolved():
	if(solvingLevel):
		playerStats.StopTimer()
		solvingLevel = false
		print("level solved")
		GeneratePerks()
		perkSelectScreen.ShowHidePerkScreen(true)

func GeneratePerks():
	var tempPerkArray = []
	for addPerk in perks:
		var addFlag = true
		for tagCheck in addPerk.reqPerkTags:
			if not (tagCheck in minefieldLogic.modifierTags):
				addFlag = false
		if addFlag:
			tempPerkArray.append(addPerk)
	
	# 1) Create level dictionary for both positive and negative perks
	var perkDict = {}
	for perk in tempPerkArray:
		if not perkDict.has(perk.perkLevel):
			perkDict[perk.perkLevel] = []
		perkDict[perk.perkLevel].append(perk)
		perkDict[perk.perkLevel].shuffle()
	# 2) Filter out perks with no pairs
	var leftoverPerkDict = {}
	for key in perkDict:
		if perkDict.has(-key):
			while perkDict[key].size() > perkDict[-key].size():
				if not leftoverPerkDict.has(key):
					leftoverPerkDict[key] = []
				leftoverPerkDict[key].append(perkDict[key][0])
				perkDict[key].remove_at(0)
		else:
			leftoverPerkDict[key] = perkDict[key]
			perkDict.erase(key)
	# 3) Find leftover perk pairs
	var leftoverDuplicate = leftoverPerkDict.duplicate()
	for key in leftoverDuplicate:
		var keyCounter = key
		while (not perkDict.has(-keyCounter)) and (keyCounter < 10):
			keyCounter += 1
		if perkDict.has(-keyCounter):
			leftoverPerkDict[-key] = []
			for perk in leftoverPerkDict[key]:
				leftoverPerkDict[-key].append(perkDict[-keyCounter].pick_random())
		else:
			leftoverPerkDict.erase(key)
	# 4) Select viable perks
	print(perkDict)
	print(leftoverPerkDict)
	var perkPairs = []
	for i in range(perkGenerateCount):
		if perkDict.has(targetPerkPairLevel) and (perkDict[targetPerkPairLevel].size() > 0):
			var selectedBuffPerk = perkDict[targetPerkPairLevel].pick_random()
			var selectedDebuffPerk = perkDict[-targetPerkPairLevel].pick_random()
			perkPairs.append([selectedBuffPerk, selectedDebuffPerk])
			perkDict[targetPerkPairLevel].erase(selectedBuffPerk)
			perkDict[-targetPerkPairLevel].erase(selectedDebuffPerk)
		else:
			if perkDict.has(targetPerkPairLevel+1) and (perkDict[targetPerkPairLevel+1].size() > 0):
				var selectedBuffPerk = perkDict[targetPerkPairLevel+1].pick_random()
				var selectedDebuffPerk = perkDict[-(targetPerkPairLevel+1)].pick_random()
				perkPairs.append([selectedBuffPerk, selectedDebuffPerk])
				perkDict[targetPerkPairLevel+1].erase(selectedBuffPerk)
				perkDict[-(targetPerkPairLevel+1)].erase(selectedDebuffPerk)
			else:
				for key in leftoverPerkDict:
					if key > 0:
						var selectedBuffPerk = leftoverPerkDict[key].pick_random()
						var selectedDebuffPerk = leftoverPerkDict[-key].pick_random()
						perkPairs.append([selectedBuffPerk, selectedDebuffPerk])
						leftoverPerkDict[key].erase(selectedBuffPerk)
						if leftoverPerkDict[key].size() == 0:
							leftoverPerkDict.erase(key)
						if leftoverPerkDict[-key].size() == 0:
							leftoverPerkDict.erase(-key)
						leftoverPerkDict[-key].erase(selectedDebuffPerk)
						break
	# 5) Send em to perk selection
	perkPairs.shuffle()
	perkSelectScreen.UpdatePerks(perkPairs)
	perkSelectScreen.enableChoise = true

func ApplyPerks(perksToApply : Array[PerkResource]):
	perkSelectScreen.ShowHidePerkScreen(false)
	for perk in perksToApply:
		print(perk.perkName)
		if perk.perkTag != "":
			minefieldLogic.modifierTags.append(perk.perkTag)
		perk.InitializePerk(get_node("/root/Main"))
		# Add all the perk effect prefabs (Obsurifiers)
		if perk.obscurifierScene != null:
			obscurifierHolder.add_child(perk.obscurifierScene.instantiate())
		if perk.onStartEffectScene != null:
			onStartEffectsHolder.add_child(perk.onStartEffectScene.instantiate())
		
		if perk.oneTime:
			if perks.has(perk):
				perks.erase(perk)
	StartNewLevel()
