### PATH FOLLOWING ENEMY ###
# REQUIRES A PARENT PATH2D NODE
# FOLLOWS GIVEN PATH
# TODO: ATTACK PLAYER OR LEAVE

extends PathFollow2D
@export var speed : float = 100
@export var direction : Vector2 = Vector2.ZERO
@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 500

@export var difficulty_tick : int = Globals.CHANGE_AT # How often difficulty tick happens
@export var delta_health : int = 1 # Amount of health increase
@export var delta_speed : float = 1.1 # Amount speed changes every tick
@export var delta_score : int = 250 # Amount score changes every tick

@export var sprite : AnimatedSprite2D 
@export var movement_tick : Timer
@export var move_dist : int = 1
@export var move_dur : float = 1.0

func _ready():
	#health += Globals.INCREASED_HEALTH
	movement_tick.wait_time = move_dur
	movement_tick.start()
	progress = randi_range(0,80)
	pass
func _process(delta):
	pass

func move():
	## TODO: ADD JUMPY MOVEMENT
	progress += move_dist

func destroy(killed):
	if(killed):
		print(Globals.KILLS)
		if Globals.KILLS % difficulty_tick == 0 and Globals.KILLS != 0 and Globals.CAN_CHANGE: # Every tenth kill, 
			Globals.raise_difficulty(delta_speed,delta_score)

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


func _on_movement_tick_timeout():
	sprite.visible = false
	move()
	sprite.visible = true
	movement_tick.start()
