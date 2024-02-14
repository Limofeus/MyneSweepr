extends Node

@export var gameLogic : Node
@export var perkButtonContainer : HBoxContainer
@export var perkButtonPreffab : PackedScene
var perkButtons : Array[Node] = []
var perkChoices = []
var enableChoise : bool = false

func ShowHidePerkScreen(shown : bool):
	get_parent().visible = shown

func UpdatePerks(perkPairs):
	perkChoices = perkPairs
	
	if(perkPairs.size() < perkButtons.size()):
		for button in perkButtons:
			perkButtonContainer.remove_child(button.get_parent())
			button.get_parent().queue_free()
		perkButtons = []
	
	while(perkPairs.size() > perkButtons.size()):
		var perkButtonInstance = perkButtonPreffab.instantiate()
		perkButtonContainer.add_child(perkButtonInstance)
		perkButtons.append(perkButtonInstance.get_child(0))
		perkButtonInstance.get_child(1).connect("pressed", PerkButtonClicked.bind(perkButtons.size() - 1))
	
	for i in range(perkPairs.size()):
		var buffPerk = perkPairs[i][0]
		var debuffPerk = perkPairs[i][1]
		perkButtons[i].SetupPerk(buffPerk.perkName, debuffPerk.perkName, buffPerk.perkDescription, debuffPerk.perkDescription)

func PerkButtonClicked(buttonId : int):
	#print("Perk button pressed, id: " + str(buttonId))
	if not enableChoise:
		return
	enableChoise = false
	var perkArray : Array[PerkResource] = []
	for perk in perkChoices[buttonId]:
		perkArray.append(perk) # Cus' perkChoices is Array[Array[PerkResource]] and godot cant handle nested arrays so it just collapses it down in to an Array, basically an array of.. idk links?.. whatever's the name of those things in English.. AH Pointers! Yea, pretty sure they're called pointers, yea
	gameLogic.ApplyPerks(perkArray)
