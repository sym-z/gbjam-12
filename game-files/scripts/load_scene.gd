### USED FOR LOADING RESOURCES ###
extends Node2D

## INTRO ANIM SPRITE
@export var intro_sprite : AnimatedSprite2D
## TITLE SPRITE
@export var title_sprite : Node2D

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

## Make the intro unskippable
var CAN_MOVE : bool = false
func _ready():
	pass 

func _process(_delta):
	input_handler()

func _on_intro_animation_finished() -> void:
	intro_sprite.visible = false
	CAN_MOVE = true
	pass # Replace with function body.

func start_game():
	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")
	
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
		start_game()
		if(DEBUG): 
			print("A")
	else:
		a_but = false
	if Input.is_action_just_pressed("B"):
		b_but = true
		start_game()
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
		start_game()
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false
