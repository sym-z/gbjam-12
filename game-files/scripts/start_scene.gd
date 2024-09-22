### USED FOR MAIN MENU ***
extends Control

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
var change = false

## The moving parts of the menu
@export var moving_parts : Control

## Alignment position of the play menu
@export var play_mark : Marker2D

## Alignment position of the tutorial menu
@export var controls_mark : Marker2D

## Alignment position of the Credits menu
@export var credits_mark : Marker2D
 
enum MOVE {UP, DOWN}
enum WINDOW {CREDITS, PLAY, CONTROLS}
## What the player is looking at
var current_choice : int

var tween : Tween
@export var dur : float = 0.1

func _ready():
	current_choice = WINDOW.PLAY
	moving_parts.position = play_mark.position
	pass 

func _process(_delta):
	if !change:
		change = true
		#get_tree().change_scene_to_file("res://scenes/level_one.tscn")
	input_handler()
	pass
func input_handler(DEBUG = false):
	if Input.is_action_just_pressed("DPAD-DOWN"):
		down = true
		menu_move(MOVE.DOWN)
		if(DEBUG): 
			print("D O W N")
	else:
		down = false
	if Input.is_action_just_pressed("DPAD-UP"):
		up = true
		menu_move(MOVE.UP)
		if(DEBUG): 
			print("U P")
	else:
		up = false
	if Input.is_action_just_pressed("DPAD-LEFT"):
		left = true
		menu_move(MOVE.UP)
		if(DEBUG): 
			print("L E F T")
	else:
		left = false
	if Input.is_action_just_pressed("DPAD-RIGHT"):
		right = true
		menu_move(MOVE.DOWN)
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
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false

func menu_move(input):
	match current_choice:
		WINDOW.PLAY:
			if input == MOVE.DOWN:
				current_choice = WINDOW.CONTROLS
				tween = create_tween()
				tween.tween_property(moving_parts, "position", controls_mark.position, dur)
			elif input == MOVE.UP:
				current_choice = WINDOW.CREDITS
				tween = create_tween()
				tween.tween_property(moving_parts, "position", credits_mark.position, dur)
		WINDOW.CREDITS:
			if input == MOVE.DOWN:
				current_choice = WINDOW.PLAY
				tween = create_tween()
				tween.tween_property(moving_parts, "position", play_mark.position, dur)
			elif input == MOVE.UP:
				current_choice = WINDOW.CONTROLS
				tween = create_tween()
				tween.tween_property(moving_parts, "position", controls_mark.position, dur)
		WINDOW.CONTROLS:
			if input == MOVE.DOWN:
				current_choice = WINDOW.CREDITS
				tween = create_tween()
				tween.tween_property(moving_parts, "position", credits_mark.position, dur)
			elif input == MOVE.UP:
				current_choice = WINDOW.PLAY
				tween = create_tween()
				tween.tween_property(moving_parts, "position", play_mark.position, dur)

func menu_choice(input):
	pass
