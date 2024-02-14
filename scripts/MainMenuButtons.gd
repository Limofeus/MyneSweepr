extends Node

#@export var mainGameScene : PackedScene

func StartGame():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func QuitGame():
	get_tree().quit()
