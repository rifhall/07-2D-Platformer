extends KinematicBody2D

const UP = Vector2(0,-1)
const DIS = 100
var DIR = -1

var lives = 2
var motion = Vector2()

func _ready():
	motion.x = DIR*DIS
	print(motion.x)
	
	motion.y = 40
	
	if is_on_wall():
		print("hehe")
		DIR *= -1
		
	motion = move_and_slide(motion, UP)

func _on_Stomped_body_entered(body):
	lives -= 1
	if lives <= 0:
		queue_free()
