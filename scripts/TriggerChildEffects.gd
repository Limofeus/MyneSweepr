extends Node

func TriggerEffects():
	print("onStart effects triggered")
	for child in get_children():
		child.TriggerEffect()
