extends Node

@export var buffLabel : Label
@export var debuffLabel : Label

func SetupPerk(buffName : String, debuffName : String, buffDesc : String, debuffDesc : String):
	buffLabel.text = buffName
	buffLabel.tooltip_text = buffDesc
	debuffLabel.text = debuffName
	debuffLabel.tooltip_text = debuffDesc
