extends Node

@export var moveSpeed : float
@export var dragSence : float
@export var zoomSence : float

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("camera_drag"):
			get_parent().position += event.relative * -dragSence * (1 / get_parent().zoom.x)
	if Input.is_action_just_pressed("camera_zoom_out"):
		get_parent().zoom /= zoomSence * Vector2.ONE
	if Input.is_action_just_pressed("camera_zoom_in"):
		get_parent().zoom *= zoomSence * Vector2.ONE

func _process(delta):
	get_parent().position += moveSpeed * delta * Input.get_vector("camera_move_left", "camera_move_right", "camera_move_up", "camera_move_down")
