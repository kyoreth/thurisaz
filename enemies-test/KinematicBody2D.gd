extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 150
const JUMP_SPEED = 50
const MAX_JUMP_SPEED = 400

# States
enum State { IDLE, JUMPING, FALLING, DUCKING, RUNNING }

enum WalkDirection { LEFT, RIGHT, NONE }

var acceleration = Vector2()
var velocity = Vector2()
var target_velocity = Vector2()
var airborne = false
var walk_direction = NONE
var state = IDLE
var timeElapsed = 0
var timeInAir = 0
var timeOnGround = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("debug"):
#	timeElapsed += delta
#	if timeElapsed >= 0.5:
#		timeElapsed -= 0.5
		print("Velocity = ", velocity)
		print("Airborne: ", airborne)
		print("On ceiling: ", is_on_ceiling())
		print("State: ", state)
		print("Animation: ", get_node("SurgeSprite").get_animation())
		print("Assigned animation: ", get_node("SurgeSprite/AnimationPlayer").get_assigned_animation())
		print("Current animation: ", get_node("SurgeSprite/AnimationPlayer").get_current_animation())

	airborne = not is_on_floor()
	
	if airborne:
		timeOnGround = 0
		velocity.y += delta * GRAVITY
	
	if not airborne:
		timeOnGround += delta
		if timeOnGround > 0.5:
			velocity.y = 0 # reset velocity effects from gravity
	
	if state == JUMPING:
		if Input.is_action_pressed("jump") and not is_on_ceiling():
			velocity.y += -JUMP_SPEED
			if velocity.y <= -MAX_JUMP_SPEED:
				velocity.y = -MAX_JUMP_SPEED
				state = FALLING
		
		if velocity.y > 0:
			state = FALLING
		
		# stop going upwards if hitting a ceiling
		if is_on_ceiling():
			velocity.y = 0
	
	if state == FALLING:
		if not airborne:
			state = IDLE
			print("Changing state to IDLE from FALLING")
		
		if Input.is_action_pressed("move_left"): #and not walk_direction == RIGHT:
			walk_direction = LEFT
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move_right"): #and not walk_direction == LEFT:
			walk_direction = RIGHT
			velocity.x = WALK_SPEED
	
	if state == RUNNING:
		if velocity.x == 0:
			state = IDLE
			get_node("SurgeSprite").set_animation("stand")
			#get_node("AnimationPlayer").set_assigned_animation("stand")
	
	if state == IDLE:
		# running right
		if velocity.x > 0:
			state = RUNNING
			get_node("SurgeSprite").set_animation("run")
			#get_node("AnimationPlayer").set_assigned_animation("run")
		
		# running left
		elif velocity.x < 0:
			state = RUNNING
			get_node("SurgeSprite").set_animation("run")
			#get_node("AnimationPlayer").set_assigned_animation("run")
		
	if state == IDLE or state == RUNNING:
		if Input.is_action_pressed("move_left"):
			walk_direction = LEFT
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move_right"):
			walk_direction = RIGHT
			velocity.x = WALK_SPEED
		else:
			walk_direction = NONE
			velocity.x = 0
	
		if Input.is_action_pressed("jump"):
			state = JUMPING
			print("Changing state to JUMPING from IDLE")
			get_node("SurgeSprite").set_animation("jump")
#			get_node("SurgeSprite/AnimationPlayer").set_current_animation("jump")
		
		if Input.is_action_pressed("duck"):
			state = DUCKING
			print("Changing state to DUCKING from IDLE")
			get_node("SurgeSprite").set_animation("duck")
#			get_node("SurgeSprite/AnimationPlayer").set_current_animation("duck")
	
	if state == DUCKING:
		velocity.x = 0
		if Input.is_action_just_released("duck"):
			state = IDLE
			get_node("SurgeSprite").set_animation("stand")
			print("Changing state to IDLE from DUCKING")
	
	if walk_direction == LEFT:
		get_node("SurgeSprite").set_flip_h(true)
	elif walk_direction == RIGHT:
		get_node("SurgeSprite").set_flip_h(false)
	
	move_and_slide(velocity, Vector2(0,-1))
	