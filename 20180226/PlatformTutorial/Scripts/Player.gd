extends KinematicBody2D

const UPVECTOR = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMPHEIGHT = -500

var motion = Vector2(0,0)

func _physics_process(delta):
	if(motion.x < 5):
		motion.x = 0
	else:
		motion.x-=sign(motion.x)*75 #Friction
	motion.y+=GRAVITY #Gravity
	if(Input.is_action_pressed("ui_right")):
		motion.x = SPEED
	if(Input.is_action_pressed("ui_left")):
		motion.x = -SPEED
	if(is_on_floor() and Input.is_action_just_pressed("ui_up")):
		motion.y = JUMPHEIGHT
	
	
	motion = move_and_slide(motion, UPVECTOR)
	pass