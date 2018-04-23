extends Node2D

var paused = false
var platform = preload("res://MiniScenes/platform.tscn")

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		paused = not paused
	
	if paused:
		return
	
	if Input.is_action_just_pressed("ui_spawn"):
		var parent = get_parent()
		var temp = platform.instance()
		temp.position = position
		parent.add_child(temp)
	
	var pos = get_global_mouse_position()
	position = pos
	pass