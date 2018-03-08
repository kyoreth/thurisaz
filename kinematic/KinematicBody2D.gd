extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 150
const JUMP_SPEED = 350
var acceleration = Vector2()
var velocity = Vector2()
var airborne = false
var walk_direction = "none"

func _physics_process(delta):
	airborne = not is_on_floor()
	acceleration.y += delta * GRAVITY
	velocity.y = acceleration.y # don't need to take delta for velocity, 
								# it's already built-into move_and_slide
	
	if not airborne:
		if Input.is_action_pressed("ui_left"):
			walk_direction = "left"
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			walk_direction = "right"
			velocity.x = WALK_SPEED
		else:
			walk_direction = "none"
			velocity.x = 0
		
		if Input.is_action_just_pressed("ui_space"):
				acceleration.y = -JUMP_SPEED
	
	if airborne:
		if Input.is_action_pressed("ui_left") and not walk_direction == "right":
			walk_direction = "left"
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right") and not walk_direction == "left":
			walk_direction = "right"
			velocity.x = WALK_SPEED
	
	move_and_slide(velocity, Vector2(0,-1))