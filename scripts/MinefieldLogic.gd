extends Node
class_name MinefieldLogic

@export var fieldHieght : int
@export var fieldWidth : int

@export var mineCount : float

var cellsToOpen : int = 0
var cellsOpened : int = 0

@export var mineGeneration : Node
@export var fieldNumberGenerator : Node
@export var playerStats : Node
@export var gameLogic : Node
@export var hiddenLayer : Control
@export var shownLayer : Control

@export var backgroundContainer : GridContainer
@export var buttonContainer : GridContainer

@export var explosionPrefab : PackedScene

var backpanel = preload("res://scenes/backpanel.tscn")
var minebutton = preload("res://scenes/minebutton.tscn")

var mineNumbers = []
var revealedNumbers = []
var cellStates = [] #0 - hidden, 1 - revealed, 2 - no auto reveal

var modifierTags = []

const cellOffset = 110

func _ready():
	pass

func GenerateLevel():
	backgroundContainer.columns = fieldWidth
	buttonContainer.columns = fieldWidth
	
	playerStats.UpdateMineCount(mineCount)
	
	for i in range(fieldWidth): 
		mineNumbers.append([])
		revealedNumbers.append([])
		cellStates.append([])
		for j in range(fieldHieght): 
			mineNumbers[i].append(0)
			revealedNumbers[i].append(0)
			cellStates[i].append(0)
			
	for i in range(fieldHieght):
		for j in range(fieldWidth):
			backgroundContainer.add_child(backpanel.instantiate())
			var mineButtonInstance : Button = minebutton.instantiate()
			buttonContainer.add_child(mineButtonInstance)
			#mineButtonInstance.pressed.connect(ButtonClicked.bind(j, i))
			mineButtonInstance.gui_input.connect(ButtonClicked.bind(j, i))
			
	mineGeneration.GenerateMines(fieldWidth, fieldHieght, mineCount)
	
	fieldNumberGenerator.GenerateNumbers(fieldWidth, fieldHieght)
	
	CountCellsToOpen()

func ClearField():
	cellsToOpen = 0
	cellsOpened = 0
	
	mineNumbers = []
	revealedNumbers = []
	cellStates = []
	
	for panel in backgroundContainer.get_children():
		backgroundContainer.remove_child(panel)
		panel.queue_free()
	for button in buttonContainer.get_children():
		buttonContainer.remove_child(button)
		button.queue_free()
	for node in hiddenLayer.get_children():
		hiddenLayer.remove_child(node)
		node.queue_free()
	for node in shownLayer.get_children():
		shownLayer.remove_child(node)
		node.queue_free()

func CountCellsToOpen():
	cellsToOpen = 0
	for cellColumns in mineNumbers:
		for cell in cellColumns:
			if cell == 0:
				cellsToOpen += 1

func ButtonClicked(event : InputEvent, xPos : int, yPos : int): # x> yv
	#print("Button clicked on " + str(xPos) + " | " + str(yPos))
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				#print("Button clicked on " + str(xPos) + " | " + str(yPos))
				OpenCell(xPos, yPos)
			MOUSE_BUTTON_RIGHT:
				if buttonContainer.get_child(xPos + (yPos * fieldWidth)).text == "F":
					buttonContainer.get_child(xPos + (yPos * fieldWidth)).text = ""
				else:
					buttonContainer.get_child(xPos + (yPos * fieldWidth)).text = "F"
	
func OpenCell(xPos : int, yPos : int):
	if(cellStates[xPos][yPos] != 1):
		
		if mineNumbers[xPos][yPos] > 0:
			BombOpened(xPos, yPos)
			
		cellStates[xPos][yPos] = 1
		buttonContainer.get_child(xPos + (yPos * fieldWidth)).disabled = true
		
		if mineNumbers[xPos][yPos] == 0:
			cellsOpened += 1
			print("Cells opened: " + str(cellsOpened) + "/" + str(cellsToOpen))
			if cellsOpened >= cellsToOpen:
				gameLogic.LevelSolved()
		
		#print("Revealed Num: " + str(revealedNumbers[xPos][yPos]) + " on " + str(xPos) + ", " + str(yPos) + " with cell state: " + str(cellStates[xPos][yPos]))
		
		await get_tree().create_timer(0.005).timeout
		if(revealedNumbers[xPos][yPos] == 0):
			for i in range(3):
				for j in range(3):
					if((not (j == 1 and i == 1)) and CheckIfInsideArray(xPos + i - 1, yPos + j - 1)):
						OpenCell(xPos + i - 1, yPos + j - 1)

func BombOpened(xPos : int, yPos : int):
	playerStats.DealDamage(mineNumbers[xPos][yPos])
	var explosionInstance = explosionPrefab.instantiate()
	shownLayer.add_child(explosionInstance)
	explosionInstance.position = Vector2((xPos + 0.5) * cellOffset, (yPos + 0.5) * cellOffset)

func CheckIfInsideArray(x_pos : int, y_pos : int):
	if(x_pos < 0 or y_pos < 0 or x_pos >= fieldWidth or y_pos >= fieldHieght):
		return false
	else:
		return true
