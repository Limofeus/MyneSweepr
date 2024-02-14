extends Node

func _ready():
	get_parent().emitting = true

func DeleteEffect():
	get_parent().get_parent().remove_child(get_parent())
	get_parent().queue_free()
