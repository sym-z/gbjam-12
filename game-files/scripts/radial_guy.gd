extends Node2D
### CIRCLING ENEMY ###
# FOLLOWS SET CIRCULAR PATH
@export var speed : float = 45
@export var damage : int = 1
@export var health : int = 1
## How much score is awarded when killed
@export var score_value : int = 1000

## Used fpr initial positioning
@export var radius : int = 35
## What is being rotated
@export var body : Node2D

## The timer for the creep
@export var creep_clock : Timer

## How much the guy moves towards the center when the timer is up
@export var radial_creep : float = 1.0

## How long until the guy creeps forward
@export var creep_time : float = 1.0

## Handles difficulty increase
@export var difficulty_tick : int = Globals.CHANGE_AT # How often difficulty tick happens

## How much the score is affected by difficulty
@export var delta_score : int = 250 # Amount score changes every tick

## A reference to the enemy's sprite
@export var sprite : AnimatedSprite2D 
## How far this enemy will move in one jump
@export var movement_distance : int = 45
## How often this enemy jumps
@export var move_dur : float = 0.6

## Reference to the player, hook up in scene
@export var player: Node2D 

## HANDLES ENEMY BIRTH ANIM
var CAN_MOVE : bool = false
func _ready():
	# Start creep timer
	#movement_tick.wait_time = move_dur
	#movement_tick.start()
	creep_clock.wait_time = creep_time
	creep_clock.start()
	

	### ASSIGN VALUES FOR POSITIONING ###
	var CENTERX = get_viewport_rect().size.x / 2 + 16 #ALERT CHANGE THIS
	var CENTERY = get_viewport_rect().size.y / 2 
	# Align Orbit
	### USED THIS FOR HELP ###
	### https://forum.godotengine.org/t/how-to-make-ideal-circle-path2d-in-simple-way/26750 ###
	# TODO: COULD CHANGE THIS TO PLAYER POSITION
	position = Vector2(CENTERX,CENTERY)
	body.position = Vector2(radius, 0)

	var init_rot = randi_range(0,250)
	rotation_degrees = init_rot
	sprite.rotation_degrees -= init_rot
	
func _process(delta):
	if !player.dead and CAN_MOVE:
		move(delta)


func move(delta):
	rotation_degrees += speed * delta
	sprite.rotation_degrees -= speed * delta

func destroy(killed):
	if(killed) and CAN_MOVE:
		CAN_MOVE = false
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0 and Globals.CAN_CHANGE: # Every tenth kill, 
			Globals.raise_difficulty(delta_score)
		Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		print("Score: ", Globals.SCORE)
		sprite.animation = 'death'
		sprite.play()
	elif !killed:
		queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		destroy(true)

# The enemy creeps toward the center every second
func _on_creep_timer_timeout():
	if !player.dead and CAN_MOVE:
		if body.position.x - radial_creep < 0:
			body.position = Vector2.ZERO
		else:
			body.position -= Vector2(radial_creep,0)


func _on_animated_sprite_2d_animation_finished() -> void:
	match sprite.animation:
		'default':
			pass
		'birth':
			# TODO can_move = true
			CAN_MOVE = true
			sprite.animation = 'default'
		'death':
			# TODO allow sprite to delete
			queue_free()
