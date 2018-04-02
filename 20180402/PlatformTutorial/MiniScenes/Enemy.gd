extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UPVECTOR = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 125

var Direction = 0
var motion = Vector2()
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	pass

func _physics_process(delta):
	var VectorToPlayer = player.position - position
	
	motion.y += GRAVITY
	
	#AI
	Direction = sign(VectorToPlayer.x)
	
	
	for body in $HitDetect.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.TakeDamage()
			
	#MOVEMENT
	motion.x = Direction*SPEED
	
	motion = move_and_slide(motion, UPVECTOR)

func TakeDamage():
	queue_free()
	
	
	
	
	
	
	