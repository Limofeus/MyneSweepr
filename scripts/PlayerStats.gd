extends Node
class_name PlayerStats

@export var cutsceneLogic : CutsceneLogic
@export var minefieldLogic : MinefieldLogic
@export var healthLabel : Label
@export var armorLabel : Label
@export var timerLabel : Label
@export var levelLabel : Label
@export var mineCountLabel : Label
@export var healthProgressBar : ProgressBar
@export var maxHealth : float = 3
@export var minDamage : float = 0.1
@export var noDeath : bool = false
var playerHealth : float
var armor : float

var timerTime = 0

var timerStopped : bool = false

func _ready():
	playerHealth = maxHealth
	UpdateHealth()

func _process(delta):
	UpdateTimer(delta)

func GameOver():
	if not noDeath:
		cutsceneLogic.deathCutscene = true
		cutsceneLogic.StartCutscene(1)

func ResetTimer():
	timerStopped = false
	timerTime = 0

func UpdateTimer(delta):
	if(not timerStopped):
		timerTime += delta
		timerLabel.text = ("%02d:" % (fmod(timerTime, 3600) / 60)) + ("%02d" % fmod(timerTime, 60))

func StopTimer():
	timerStopped = true
	
func UpdateLevelLabel(currentLevel : int):
	levelLabel.text = "Level " + str(currentLevel)

func UpdateArmorLabel():
	armorLabel.text = "Block: " + str(min(armor, 1 - minDamage))

func DealDamage(damage : float):
	playerHealth -= max(damage - armor, minDamage)
	UpdateHealth()
	if playerHealth <= 0:
		GameOver()

func Heal(heal : float):
	playerHealth = min(playerHealth + heal, maxHealth)
	UpdateHealth()

func UpdateHealth():
	if("hideHealth" in minefieldLogic.modifierTags):
		healthLabel.text = "HP: ?/?"
		healthProgressBar.max_value = maxHealth
		healthProgressBar.value = maxHealth
	else:
		healthLabel.text = "HP: " + str(playerHealth) + "/" + str(maxHealth)
		healthProgressBar.max_value = maxHealth
		healthProgressBar.value = playerHealth

func UpdateMineCount(mineCount : float):
	mineCountLabel.text = "MINES: " + str(mineCount)
