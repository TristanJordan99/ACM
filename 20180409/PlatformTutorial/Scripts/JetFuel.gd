extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.jetpackTime = 10
			queue_free()