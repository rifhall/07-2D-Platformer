extends KinematicBody2D

#gives Direction
const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCEL = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var lives = 3
var dir = 1
var Points = 0

var motion = Vector2()

func _physics_process(delta):
	#gravity
	motion.y += GRAVITY
	
	#friction for when your not moving
	var friction = false
	#for interacting with coins
	
	
	#character movement
	if Input.is_action_pressed("ui_right"):
		motion.x = min(dir*(motion.x+ACCEL), dir*MAX_SPEED)
		#will change direction and use run animation
		$Sprite.flip_h = false
		$Sprite.play("Run")
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(dir*(motion.x-ACCEL), dir*-MAX_SPEED)
		#will change direction and use run animation
		$Sprite.flip_h = true
		$Sprite.play("Run")
		
	#if doing nothing
	else:
		$Sprite.play("Idle")
		friction=true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x,0,0.2)
			
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
	
	#detects what the player is hitting
	

func _on_BadStuffDetector_body_entered(body):
	if body.name == "Enemy":
		lives -= 1
		$ParallaxBackground/Lives.text = "Lives: " + str(lives)

func _on_StompBox_body_entered(body):
	motion.y = JUMP_HEIGHT
	Points += 100
	$ParallaxBackground/Score.text = "Score: " + str(Points)
