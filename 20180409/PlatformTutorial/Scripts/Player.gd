extends KinematicBody2D

const UPVECTOR = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMPHEIGHT = -500

var jumps  = 0
var maxJumps = 2
var motion = Vector2(0,0)

var jetpackTime = 0
var jetpackThrust = -200

func _input(event):
	if (event.is_action_pressed("ui_cancel") and not event.is_echo()):
		get_tree().reload_current_scene()

func _physics_process(delta):
	if(motion.x < 5):
		motion.x = 0
	else:
		motion.x-=sign(motion.x)*75 #Friction
	motion.y+=GRAVITY #Gravity
	
	if(Input.is_action_pressed("ui_right")):
		motion.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	elif(Input.is_action_pressed("ui_left")):
		motion.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	elif(is_on_floor()):
		$AnimatedSprite.play("Idle")
	
	if(not is_on_floor()):
		$AnimatedSprite.play("Jump")
	else:
		jumps = 0
	
	if( (is_on_floor() or jumps < maxJumps) and Input.is_action_just_pressed("ui_up")):
		motion.y = JUMPHEIGHT
		jumps += 1
		$JumpSound.play()
	
	if(position.y > 800):
		get_tree().reload_current_scene()
	
	jetpackTime = max(jetpackTime-delta, 0)
	if jetpackTime > 0 and Input.is_action_pressed("ui_up"):
		motion.y = jetpackThrust
	
	motion = move_and_slide(motion, UPVECTOR)
	
	
	var bodies = $HitDetect.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemy"):
			body.TakeDamage()
			motion.y = JUMPHEIGHT/2
	
	
	pass

func TakeDamage():
	get_tree().reload_current_scene()






