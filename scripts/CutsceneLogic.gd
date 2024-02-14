extends Node
class_name CutsceneLogic

@export var playerStats : PlayerStats
@export var cutsceneLayer : CanvasLayer
@export var cutsceneTextObj : RichTextLabel
@export var animationPlayer : AnimationPlayer
@export var videoStreamPlayer : VideoStreamPlayer
@export var audioStreamPlayer : AudioStreamPlayer
@export var cutsceneResources : Array[CutsceneResource] = []

#@export var mainMenuScene : PackedScene

var currentCutsceneId : int = 0

var deathCutscene : bool = false

func _ready():
	StartCutscene(0)

func _input(event):
	if Input.is_action_just_pressed("skip_cutscene"):
		CutsceneEnded()

func StartCutscene(cutsceneId : int):
	playerStats.StopTimer()
	cutsceneLayer.visible = true
	videoStreamPlayer.stream = cutsceneResources[cutsceneId].video
	audioStreamPlayer.stream = cutsceneResources[cutsceneId].audio
	animationPlayer.play(cutsceneResources[cutsceneId].cutsceneAnimName)
	currentCutsceneId = cutsceneId

func StartVideo(startAudio : bool):
	videoStreamPlayer.play()
	if startAudio:
		StartAudio()

func StartAudio():
	audioStreamPlayer.play()

func CutsceneEnded():
	if deathCutscene:
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	else:
		animationPlayer.stop()
		videoStreamPlayer.stop()
		audioStreamPlayer.stop()
		playerStats.ResetTimer()
		cutsceneLayer.visible = false

func SetCutsceneText(textId : int):
	cutsceneTextObj.text = cutsceneResources[currentCutsceneId].cutsceneLines[textId]
