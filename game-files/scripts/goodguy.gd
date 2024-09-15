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

### FOR THE GUNS ###
# For match statements
enum AIM {NORTH, SOUTH, EAST, WEST}
# Default aim direction is north!
var aim_dir = AIM.NORTH
@export var NORTH_GUN : RayCast2D
@export var SOUTH_GUN : RayCast2D
@export var EAST_GUN : RayCast2D
@export var WEST_GUN : RayCast2D

### GUN ARRAY ###
var gun_arr
### PLAYER HEALTH ###
@export var health : int = 4

### WEAPON DAMAGE (FOR NOW) ###
@export var damage : int = 1

### FOR DEATH HANDLING 
@export var hurtbox : Area2D
@export var sprite : AnimatedSprite2D
### FOR LEVEL RESPAWN ###
var dead : bool = false

@export var respawn_clock : Timer
func _ready():
	### HOLDS GUNS TO MAKE FIRING CODE EASIER ###
	gun_arr = [NORTH_GUN,SOUTH_GUN,EAST_GUN,WEST_GUN]
	pass 

func _process(_delta):
	input_handler()

func input_handler(DEBUG = false):
	if Input.is_action_pressed("DPAD-DOWN"):
		down = true
		aim_dir = AIM.SOUTH
		if(DEBUG): 
			print("D O W N")
	else:
		down = false
	if Input.is_action_pressed("DPAD-UP"):
		up = true
		aim_dir = AIM.NORTH
		if(DEBUG): 
			print("U P")
	else:
		up = false
	if Input.is_action_pressed("DPAD-LEFT"):
		left = true
		aim_dir = AIM.WEST
		if(DEBUG): 
			print("L E F T")
	else:
		left = false
	if Input.is_action_pressed("DPAD-RIGHT"):
		right = true
		aim_dir = AIM.EAST
		if(DEBUG): 
			print("R I G H T")
	else:
		right = false
	if Input.is_action_just_pressed("A"):
		a_but = true
		fire()
		if(DEBUG): 
			print("A")
	else:
		a_but = false
	if Input.is_action_just_pressed("B"):
		b_but = true
		fire()
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
		if(DEBUG): 
			print("S T A R T")
	else:
		srt_but = false

func _on_hurtbox_area_entered(area):
	# Check to see if collider is an enemy
	if area.is_in_group("Enemies") and !dead:
		# Owner grabs the root node of the tree.
		var attacker = area.owner
		health -= attacker.damage
		if health <= 0:
			die()
		# Destroy the enemy last!
		attacker.destroy(false)

func die():
	print("YOU DIED")
	dead = true
	sprite.visible = false
	if Globals.LIVES == 0:
		# GAME OVER
		Globals.SCORE = 0
		Globals.LIVES = 3
	else:
		# RESTART LEVEL
		Globals.LIVES -= 1
	print("LIVES: ", Globals.LIVES)
	call_deferred("restart_level")
	#queue_free()

func fire():
	# Haven't decided on a fire button
	if a_but or b_but:
		# Fire the correct gun
		var curr_gun = gun_arr[aim_dir]
		### SEE WHAT IT HIT ###
		var target = curr_gun.get_collider()
		if target and target.is_in_group("Enemies"):
			# Damage Enemy
			#print("Enemy Hit")
			# Isolate the root node of the enemy, and apply damage to its health
			target.owner.hurt(damage)
		else:
			#print("Enemy Miss")
			pass

func restart_level():
	respawn_clock.start()

func _on_respawn_timer_timeout():
	owner.get_tree().reload_current_scene()
