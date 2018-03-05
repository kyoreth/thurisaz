extends Node



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if(event.is_action_released("ui_s")):
		get_node("AnimatedSprite").set_animation("stand")
		get_node("AnimationPlayer").set_assigned_animation("stand")
	if(event.is_action_released("ui_r")):
		get_node("AnimatedSprite").set_animation("run")
		get_node("AnimationPlayer").set_assigned_animation("run")
	if(event.is_action_released("ui_j")):
		get_node("AnimatedSprite").set_animation("jump")
		get_node("AnimationPlayer").set_assigned_animation("jump")

#func _process(delta):
