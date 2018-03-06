extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet = preload("res://bullet.tscn")
var bulletCount = 0
var bulletArray = []


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass
	
func fire():
	bulletCount += 1
	print("firing")
	print(str(bulletArray))
	var bullet_instance = bullet.instance()
	bullet_instance.set_name("bullet"+str(bulletCount))
	add_child(bullet_instance)
	var bulletPos = get_node("Sprite").position
	bulletPos.x += 16
	get_node("bullet"+str(bulletCount)).set_position(bulletPos)
	bulletArray.push_back("bullet"+str(bulletCount))
#
	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.

	var spripos = get_node("Sprite").position
	
#	if Input.is_action_just_pressed("ui_up"):
#		fire()
		
	if Input.is_action_pressed("ui_right"):
		get_node("Sprite").move_local_x(300*delta)
	
	if Input.is_action_pressed("ui_left"):
		get_node("Sprite").move_local_x(-300*delta)
		
	if Input.is_action_just_pressed("ui_up"):
		fire()
	var bulletId = 0
	for bullet in bulletArray:
		get_node(bullet).move_local_y(500*delta)
		if get_node(bullet).position.y > 600:
			remove_child(get_node(bullet))
			bulletArray.remove(bulletId)
		bulletId += 1
	
	
			
		
	
	pass
