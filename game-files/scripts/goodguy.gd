extends Node2D

# # # CONTROLS # # #
var down : bool = false
var up : bool = false
var left : bool = false
var right : bool = false

var a_but : bool = false
var b_but : bool = false

var sel_but : bool = false
var srt_but : bool = false
# # # # # # # # # # # #

### PLAYER HEALTH ###
@export var health : int = 4

func _ready():
	pass 

func _process(_delta):
	input_handler(true)

func input_handler(DEBUG = false):
	if Input.is_action_just_pressed("DPAD-DOWN"):
		down = true
		if(DEBUG): 
			print("D O W N")
	else:
		down = false
	if Input.is_action_just_pressed("DPAD-UP"):
		up = true
		if(DEBUG): 
			print("U P")
	else:
		up = false
	if Input.is_action_just_pressed("DPAD-LEFT"):
		left = true
		if(DEBUG): 
			print("L E F T")
	else:
		left = false
	if Input.is_action_just_pressed("DPAD-RIGHT"):
		right = true
		if(DEBUG): 
			print("R I G H T")
	else:
		right = false
	if Input.is_action_just_pressed("A"):
		a_but = true
		if(DEBUG): 
			print("A")
	else:
		a_but = false
	if Input.is_action_just_pressed("B"):
		b_but = true
		if(DEBUG): 
			print("B")
	else:
		b_but = false
	if Input.is_action_just_pressed("SELECT"):
		sel_but = true
		if(DEBUG): 
			print("S E L E C T")
	else:
		sel_but = false
	if Input.is_action_just_pressed("START"):
		srt_but = true
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false

func _on_hurtbox_area_entered(area):
	# Check to see if collider is an enemy
	if area.is_in_group("Enemies"):
		# Owner grabs the root node of the tree.
		var attacker = area.owner
		health -= attacker.damage
		if health <= 0:
			die()
		# Destroy the enemy last!
		attacker.destroy()

func die():
	print("YOU DIED")
	queue_free()
