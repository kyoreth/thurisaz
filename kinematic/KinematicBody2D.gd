extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 200
const JUMP_SPEED = 200
var acceleration = Vector2()

func _physics_process(delta):
	acceleration.y += delta * GRAVITY
	var velocity = acceleration# * delta
	if is_on_floor():
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x = WALK_SPEED
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("ui_space"):
			acceleration.y = -JUMP_SPEED
	move_and_slide(velocity, Vector2(0,-1))