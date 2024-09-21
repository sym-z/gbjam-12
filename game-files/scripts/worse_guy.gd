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


func _ready():
	pass

func _process(delta):
	move(delta)

func move(delta):
	if !player.dead:
		progress += speed * delta 

func destroy(killed):
	if(killed):
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0 and Globals.CAN_CHANGE: # Every tenth kill, 
			Globals.raise_difficulty(delta_score)
		Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		print("Score: ", Globals.SCORE)
	queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		sprite.animation = 'death'
		sprite.play()

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == 'death':
		destroy(true)
