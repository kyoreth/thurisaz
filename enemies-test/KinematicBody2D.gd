extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 150
const JUMP_SPEED = 50
const MAX_JUMP_SPEED = 400

# States
enum State { IDLE, JUMPING, FALLING, DUCKING }

enum WalkDirection { LEFT, RIGHT, NONE }

var acceleration = Vector2()
var velocity = Vector2()
var target_velocity = Vector2()
var airborne = false
var walk_direction = NONE
var state = IDLE
var timeElapsed = 0

func _physics_process(delta):
	airborne = not is_on_floor()
	
	if not airborne:
		if not state == DUCKING:
			state = IDLE
			#print("Changing state to IDLE")
			velocity.y = 0 # reset velocity effects from gravity
			
			# running right
			if velocity.x > 0:
				if get_node("SurgeSprite").get_animation() != "run":
					get_node("SurgeSprite").play("run")
					#get_node("AnimationPlayer").set_assigned_animation("run")
					print("starting run")
			
			# running left
			elif velocity.x < 0:
				if get_node("SurgeSprite").get_animation() != "run":
					get_node("SurgeSprite").play("run")
					#get_node("AnimationPlayer").set_assigned_animation("run")
					print("starting run")
			
			# standing still
			else:
				get_node("SurgeSprite").set_animation("stand")
				#get_node("AnimationPlayer").set_assigned_animation("stand")
			
			if Input.is_action_pressed("move_left"):
				walk_direction = LEFT
				velocity.x = -WALK_SPEED
			elif Input.is_action_pressed("move_right"):
				walk_direction = RIGHT
				velocity.x = WALK_SPEED
			else:
				walk_direction = NONE
				velocity.x = 0
	
	if airborne:
		velocity.y += delta * GRAVITY
		
		if velocity.y > 0:
			state = FALLING
			#print("Changing state to FALLING")
		
		# stop going upwards if hitting a ceiling
		if is_on_ceiling():
			velocity.y = 0
		
		if Input.is_action_pressed("move_left"): #and not walk_direction == RIGHT:
			walk_direction = LEFT
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move_right"): #and not walk_direction == LEFT:
			walk_direction = RIGHT
			velocity.x = WALK_SPEED
	
	if Input.is_action_just_pressed("jump"):
		if not state == JUMPING and not state == FALLING:
			state = JUMPING
			get_node("SurgeSprite").set_animation("jump")
			get_node("SurgeSprite/AnimationPlayer").set_current_animation("jump")
			get_node("SurgeSprite").play()
			get_node("SurgeSprite/AnimationPlayer").play()
#			print("Pressed!")
	
	if state == JUMPING:
		if Input.is_action_pressed("jump") and not is_on_ceiling():
			velocity.y += -JUMP_SPEED
			if velocity.y <= -MAX_JUMP_SPEED:
				velocity.y = -MAX_JUMP_SPEED
				state = FALLING
	
	if Input.is_action_pressed("duck") and not state == DUCKING:
		state = DUCKING
		get_node("SurgeSprite").set_animation("duck")
		get_node("SurgeSprite/AnimationPlayer").set_current_animation("duck")
	
	if walk_direction == LEFT:
		get_node("SurgeSprite").set_flip_h(true)
	elif walk_direction == RIGHT:
		get_node("SurgeSprite").set_flip_h(false)
	
	move_and_slide(velocity, Vector2(0,-1))
	
	if Input.is_action_just_pressed("debug"):
#	timeElapsed += delta
#	if timeElapsed >= 0.5:
		print("Velocity = ", velocity)
		print("Airborne: ", airborne)
		print("On ceiling: ", is_on_ceiling())
		print("State: ", state)
		print("Animation: ", get_node("SurgeSprite").get_animation())
		print("Assigned animation: ", get_node("SurgeSprite/AnimationPlayer").get_assigned_animation())
		print("Current animation: ", get_node("SurgeSprite/AnimationPlayer").get_current_animation())
#		timeElapsed -= 0.5