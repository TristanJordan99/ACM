extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.jetpackTime = 5
			queue_free()