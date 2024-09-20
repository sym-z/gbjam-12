extends Node2D
@export var speed : float = 3
@export var direction : Vector2 = Vector2.ZERO
### CIRCLING ENEMY ###
# FOLLOWS SET CIRCULAR PATH
# TODO: DISAPPEAR AFTER PLAYER KILL

@export var damage : int = 1
@export var health : int = 1
@export var score_value : int = 1000
@export var radius : int = 35
# What is being rotated
@export var body : Node2D

# The timer for the creep
@export var creep_clock : Timer

# How much the guy moves towards the center when the timer is up
@export var radial_creep : float = 1.0

# How long until the guy creeps forward
@export var creep_time : float = 1.0

@export var difficulty_tick : int = Globals.CHANGE_AT # How often difficulty tick happens
@export var delta_health : int = 1 # Amount of health increase
@export var delta_speed : float = 1.1 # Amount speed changes every tick
@export var delta_score : int = 250 # Amount score changes every tick


func _ready():
	#health += Globals.INCREASED_HEALTH
	# Start creep timer
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

func _process(delta):
	move(delta)

func move(delta):
	rotation += speed * delta * Globals.SPEED_MULT

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
		destroy(true)

# The enemy creeps toward the center every second
func _on_creep_timer_timeout():
	if body.position.x - radial_creep < 0:
		body.position = Vector2.ZERO
	else:
		body.position -= Vector2(radial_creep,0)

