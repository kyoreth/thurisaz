extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 150
const JUMP_SPEED = 50
const MAX_JUMP_SPEED = 400

# States
const IDLE = 0
const JUMPING = 1
const FALLING = 2

var acceleration = Vector2()
var velocity = Vector2()
var target_velocity = Vector2()
var airborne = false
var walk_direction = "none"
var state = IDLE
var timeElapsed = 0

func _physics_process(delta):
	airborne = not is_on_floor()
	
	if velocity.y > 0:
		state = FALLING
	
	# stop going upwards if hitting a ceiling
	if is_on_ceiling():
		velocity.y = 0
	
	if not airborne:
		state = IDLE
		velocity.y = 0 # reset velocity effects from gravity
		
		if Input.is_action_pressed("ui_left"):
			walk_direction = "left"
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			walk_direction = "right"
			velocity.x = WALK_SPEED
		else:
			walk_direction = "none"
			velocity.x = 0
	
	if airborne:
		velocity.y += delta * GRAVITY
		
		if Input.is_action_pressed("ui_left"): #and not walk_direction == "right":
			walk_direction = "left"
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"): #and not walk_direction == "left":
			walk_direction = "right"
			velocity.x = WALK_SPEED
	
	if Input.is_action_just_pressed("ui_space"):
		if not state == JUMPING and not state == FALLING:
			state = JUMPING
#			print("Pressed!")
	
	if state == JUMPING:
		if Input.is_action_pressed("ui_space") and not is_on_ceiling():
			velocity.y += -JUMP_SPEED
			if velocity.y <= -MAX_JUMP_SPEED:
				velocity.y = -MAX_JUMP_SPEED
				state = FALLING
			
	move_and_slide(velocity, Vector2(0,-1))
	
	if Input.is_action_just_pressed("ui_space"):
#	timeElapsed += delta
#	if timeElapsed >= 0.5:
		print("Velocity = ", velocity)
		print("Airborne: ", airborne)
		print("On ceiling: ", is_on_ceiling())
		print("State: ", state)
#		timeElapsed -= 0.5