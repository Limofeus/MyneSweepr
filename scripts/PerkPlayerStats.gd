extends PerkResource
class_name PerkPlayerStats

@export var armorAdd : float
@export var maxHpAdd : float
@export var heal : float

func InitializePerk(rootNode : Node):
	var playerStatsNode = rootNode.get_node("%PlayerStats")
	playerStatsNode.armor += armorAdd
	if armorAdd != 0:
		playerStatsNode.UpdateArmorLabel()
	playerStatsNode.maxHealth += maxHpAdd
	playerStatsNode.Heal(heal)
