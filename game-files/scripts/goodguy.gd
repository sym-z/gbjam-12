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

# Called when the node enters the scene tree for the first time.
func _ready():

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	input_handler(true)
	pass

func input_handler(DEBUG = false):
	if Input.is_action_just_pressed("DPAD-DOWN"):
		down = true
		if(DEBUG): 
			print("D O W N")
	else:
		down = false
		pass
	if Input.is_action_just_pressed("DPAD-UP"):
		up = true
		if(DEBUG): 
			print("U P")
	else:
		up = false
		pass
	if Input.is_action_just_pressed("DPAD-LEFT"):
		left = true
		if(DEBUG): 
			print("L E F T")
	else:
		left = false
		pass
	if Input.is_action_just_pressed("DPAD-RIGHT"):
		right = true
		if(DEBUG): 
			print("R I G H T")
	else:
		right = false
		pass
	if Input.is_action_just_pressed("A"):
		a_but = true
		if(DEBUG): 
			print("A")
	else:
		a_but = false
		pass
	if Input.is_action_just_pressed("B"):
		b_but = true
		if(DEBUG): 
			print("B")
	else:
		b_but = false
		pass
	if Input.is_action_just_pressed("SELECT"):
		sel_but = true
		if(DEBUG): 
			print("S E L E C T")
	else:
		sel_but = false
		pass
	if Input.is_action_just_pressed("START"):
		srt_but = true
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false
		pass
	pass
