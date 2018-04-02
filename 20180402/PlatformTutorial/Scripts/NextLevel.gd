extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var  nextLevel = "res://Scenes/world2.tscn"

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			get_tree().change_scene(nextLevel)
	pass
