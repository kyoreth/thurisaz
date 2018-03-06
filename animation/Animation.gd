extends Node

var state = "standing"
var timePassed = 0
var movespeed = 100
var facing = "right"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if(event.is_action_released("ui_right") and facing == "right"):
		state = "standing"
		get_node("Player/player_sprite").set_animation("stand")
		get_node("AnimationPlayer").set_assigned_animation("stand")
	
	if(event.is_action_released("ui_left") and facing == "left"):
		state = "standing"
		get_node("Player/player_sprite").set_animation("stand")
		get_node("AnimationPlayer").set_assigned_animation("stand")
	
	if(event.is_action_pressed("ui_right")):
		state = "running"
		facing = "right"
		get_node("Player/player_sprite").set_flip_h(false)
		get_node("Player/player_sprite").set_animation("run")
		get_node("AnimationPlayer").set_assigned_animation("run")
	
	if(event.is_action_pressed("ui_left")):
		state = "running"
		facing = "left"
		get_node("Player/player_sprite").set_flip_h(true)
		get_node("Player/player_sprite").set_animation("run")
		get_node("AnimationPlayer").set_assigned_animation("run")
	
	if(event.is_action_pressed("ui_space")):
		state = "jumping"
		get_node("Player/player_sprite").set_animation("jump")
		get_node("AnimationPlayer").set_assigned_animation("jump")
		get_node("Player/player_sprite").play()
		get_node("AnimationPlayer").play()

func _process(delta):
#	if(state == "stand"):
#		get_node("AnimationPlayer").queue("stand")
	if(state == "running"):
		if(facing == "right"):
			get_node("Player").move_local_x(delta*movespeed)
		if(facing == "left"):
			get_node("Player").move_local_x(-delta*movespeed)
#	if(state == "jump"):
#		get_node("AnimationPlayer").queue("jump")
	timePassed += delta
	if(timePassed >= 1):
		timePassed -= 1
		print(state)


func _on_AnimationPlayer_animation_finished(jump):
	state = "standing"
	get_node("Player/player_sprite").set_animation("stand")
	get_node("AnimationPlayer").set_assigned_animation("stand")
	print("Finished!")
