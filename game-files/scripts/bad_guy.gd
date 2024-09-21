extends Node2D

@export var sprite : AnimatedSprite2D 
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1

## How much score is alloted for killing this enemy
@export var score_value : int = 250
## How often difficulty tick happens
@export var difficulty_tick : int = Globals.CHANGE_AT 
## Amount score changes every tick
@export var delta_score : int = 250 

## Speed of guy
@export var speed : float = 25

## Reference to the player, hook up in scene
@export var player: Node2D 


### TO FIGURE OUT DIRECTION OF SPAWN ###
enum DIR {NORTH, SOUTH, EAST, WEST}

## Which gate they spawn at
var gate : int
func _ready():
	pass
	
func _process(delta):
	move(delta)

func move(delta):
	if !player.dead:
		position += ((speed * direction) * delta)

func destroy(killed):
	if(killed):
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0 and Globals.CAN_CHANGE: # Every tenth kill, 
			Globals.raise_difficulty(delta_score)
		Globals.SCORE = Globals.SCORE + score_value + Globals.SCORE_BUFF
		print("Score: ", Globals.SCORE)
		Globals.filled_gates[gate] = 0
	queue_free()

func hurt(dam):
	health -= dam
	if health <= 0:
		destroy(true)

func align_sprite():
	match direction:
		Vector2.UP:
			rotation_degrees = 0
		Vector2.DOWN:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 90
		Vector2.LEFT:
			rotation_degrees = 270

func _on_animated_sprite_2d_animation_finished():
	if sprite.frame == 15:
		sprite.play_backwards()
	else:
		sprite.play()
