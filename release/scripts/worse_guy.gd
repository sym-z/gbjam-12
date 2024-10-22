### PATH FOLLOWING ENEMY ###
# REQUIRES A PARENT PATH2D NODE
# FOLLOWS GIVEN PATH

extends PathFollow2D
## Speed of this guy
@export var speed : float = 100

@export var damage : int = 1
@export var health : int = 1
## How much score is alloted when this enemy is killed
@export var score_value : int = 500

## How often difficulty tick happens
@export var difficulty_tick : int = Globals.CHANGE_AT 

## Amount score changes every tick
@export var delta_score : int = 250 

@export var sprite : AnimatedSprite2D 

## Reference to the player, hook up in scene
@export var player: Node2D 

## HANDLES SPRITE BIRTH ANIM
var CAN_MOVE : bool = false

## Holds Death Sound
@export var death_sound : AudioStreamPlayer2D

## For sound, connected to level
signal diff_bump

func _ready():
	## Variance in starting position
	progress = randi_range(0,250)

func _process(delta):
	if !player.dead and CAN_MOVE:
		move(delta)

func move(delta):
		progress += speed * delta 

func destroy(killed):
	if(killed) and CAN_MOVE:
		CAN_MOVE = false
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0 and Globals.CAN_CHANGE: # Every tenth kill, 
			Globals.raise_difficulty(delta_score)
			diff_bump.emit()
		Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		#Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		print("Score: ", Globals.SCORE)
		sprite.animation = 'death'
		sprite.play()
	elif !killed:
		queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		death_sound.play()
		destroy(true)

func _on_animated_sprite_2d_animation_finished():
	match sprite.animation:
		'default':
			pass
		'birth':
			# TODO can_move = true
			CAN_MOVE = true
			sprite.animation = 'default'
			sprite.play()
		'death':
			# TODO allow sprite to delete
			queue_free()
	
