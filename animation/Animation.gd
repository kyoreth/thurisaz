extends Node

var state = "standing"
var timePassed = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if(event.is_action_released("ui_right") or event.is_action_released("ui_left")):
		state = "standing"
		get_node("AnimatedSprite").set_animation("stand")
		get_node("AnimationPlayer").set_assigned_animation("stand")
	if(event.is_action_pressed("ui_right") or event.is_action_pressed("ui_left")):
		state = "running"
		get_node("AnimatedSprite").set_animation("run")
		get_node("AnimationPlayer").set_assigned_animation("run")
	if(event.is_action_pressed("ui_space")):
		state = "jumping"
		get_node("AnimatedSprite").set_animation("jump")
		get_node("AnimationPlayer").set_assigned_animation("jump")
		get_node("AnimatedSprite").play()
		get_node("AnimationPlayer").play()

func _process(delta):
#	if(state == "stand"):
#		get_node("AnimationPlayer").queue("stand")
#	if(state == "run"):
#		get_node("AnimationPlayer").queue("run")
#	if(state == "jump"):
#		get_node("AnimationPlayer").queue("jump")
	timePassed += delta
	if(timePassed >= 1):
		timePassed -= 1
		print(state)


func _on_AnimationPlayer_animation_finished(jump):
	state = "standing"
	get_node("AnimatedSprite").set_animation("stand")
	get_node("AnimationPlayer").set_assigned_animation("stand")
	print("Finished!")
