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

## Ambience Sound
@export var ambience : AudioStreamPlayer2D

## This noise plays when the player selects a new option in the main menu
@export var menu_pick_noise : AudioStreamPlayer2D

## The splash screen that reveals and disappears for controls
@export var controls_splash : Sprite2D

## The splash screen that reveals and disappears for credits
@export var credits_splash : Sprite2D

## Block hud in the menu
@export var hud_image : TextureRect

## Turns true when viewing menu
var VIEWING : bool = false

## Text image overlays for the hud
@export var hud_text : AnimatedSprite2D


func _ready():
	# Play bg noise
	ambience.play()
	current_choice = WINDOW.PLAY
	moving_parts.position = play_mark.position

func _process(_delta):
	input_handler()
	
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
		menu_choice()
		if(DEBUG): 
			print("A")
	else:
		a_but = false
	if Input.is_action_just_pressed("B"):
		b_but = true
		menu_choice()
		if(DEBUG): 
			print("B")
	else:
		b_but = false
	if Input.is_action_just_pressed("SELECT"):
		sel_but = true
		menu_move(MOVE.DOWN)
		if(DEBUG): 
			print("S E L E C T")
	else:
		sel_but = false
	if Input.is_action_just_pressed("START"):
		srt_but = true
		menu_choice()
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false

func menu_move(input):
	if !VIEWING:
		menu_pick_noise.play()
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
		# Use enum and correct frame order for clean code
		hud_text.frame = current_choice

func menu_choice():
	match current_choice:
		WINDOW.PLAY:
			get_tree().change_scene_to_file("res://scenes/level_one.tscn")
		WINDOW.CONTROLS:
			menu_pick_noise.play()
			controls_splash.visible = !controls_splash.visible
			hud_image.visible = !hud_image.visible
			VIEWING = controls_splash.visible
		WINDOW.CREDITS:
			menu_pick_noise.play()
			credits_splash.visible = !credits_splash.visible
			hud_image.visible = !hud_image.visible
			VIEWING = credits_splash.visible
