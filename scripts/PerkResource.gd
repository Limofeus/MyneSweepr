extends Resource
class_name PerkResource

@export var perkLevel : int
@export var oneTime : bool
@export var perkName : String
@export_multiline var perkDescription : String
@export var perkTag : String
@export var reqPerkTags : Array[String]

@export var obscurifierScene : PackedScene
@export var onStartEffectScene : PackedScene

func InitializePerk(rootNode : Node):
	return
