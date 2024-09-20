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

### Animations ###
@export var north_anim : AnimatedSprite2D
@export var south_anim : AnimatedSprite2D
@export var east_anim : AnimatedSprite2D
@export var west_anim : AnimatedSprite2D

var bass1 : AudioStream = preload("res://audio/bass1.mp3")
var bass2 : AudioStream = preload("res://audio/bass2.mp3")
var bass3 : AudioStream = preload("res://audio/bass3.mp3")

var hihat1 : AudioStream = preload("res://audio/hihat1.mp3")
var hihat2 : AudioStream = preload("res://audio/hihat2.mp3")
var hihat3 : AudioStream = preload("res://audio/hihat3.mp3")

var snare1 : AudioStream= preload("res://audio/snare1.mp3")
var snare2 : AudioStream = preload("res://audio/snare2.mp3")
var snare3 : AudioStream = preload("res://audio/snare3.mp3")

var vox1 : AudioStream = preload("res://audio/vox1.mp3")
var vox2 : AudioStream = preload("res://audio/vox2.mp3")
var vox3 : AudioStream = preload("res://audio/vox3.mp3")

@export var speaker : AudioStreamPlayer2D 

var basses = []
var hihats = []
var snares = []
var voxes = []
func _ready():
	### HOLDS GUNS TO MAKE FIRING CODE EASIER ###
	gun_arr = [NORTH_GUN,SOUTH_GUN,EAST_GUN,WEST_GUN]
	### FOR RANDOM SOUNDS
	
	basses.append(bass1)
	basses.append(bass3)
	basses.append(bass3)

	hihats.append(hihat1)
	hihats.append(hihat2)
	hihats.append(hihat3)
	
	snares.append(snare1)
	snares.append(snare1)
	snares.append(snare1)
	
	voxes.append(vox1)
	voxes.append(vox2)
	voxes.append(vox3)

func _process(_delta):
	input_handler()

func input_handler(DEBUG = false):
	if Input.is_action_pressed("DPAD-DOWN"):
		down = true
		aim_dir = AIM.SOUTH
		sprite.flip_v = false
		sprite.rotation_degrees = 0
		if(DEBUG): 
			print("D O W N")
	else:
		down = false
	if Input.is_action_pressed("DPAD-UP"):
		up = true
		aim_dir = AIM.NORTH
		sprite.rotation_degrees = 0
		sprite.flip_v = true
		if(DEBUG): 
			print("U P")
	else:
		up = false
	if Input.is_action_pressed("DPAD-LEFT"):
		left = true
		aim_dir = AIM.WEST
		sprite.rotation_degrees = 90
		sprite.flip_v = false
		if(DEBUG): 
			print("L E F T")
	else:
		left = false
	if Input.is_action_pressed("DPAD-RIGHT"):
		right = true
		aim_dir = AIM.EAST
		sprite.rotation_degrees = 270
		sprite.flip_v = false
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
		Globals.reset_difficulty()
	else:
		# RESTART LEVEL
		Globals.LIVES -= 1
	print("LIVES: ", Globals.LIVES)
	call_deferred("restart_level")
	#queue_free()

func fire():
	# Haven't decided on a fire button
	if a_but or b_but and !dead:
		# Fire the correct gun
		var curr_gun = gun_arr[aim_dir]
		if sprite.is_playing():
			sprite.set_frame_and_progress(0,0)
		sprite.play()
		### PLAY ANIMATION ###
		match aim_dir:
			AIM.NORTH:
				if north_anim.is_playing():
					north_anim.frame = 0
				north_anim.visible = true
				north_anim.play()
				speaker.set_stream(basses[randi_range(0,basses.size()-1)])
				speaker.play()
			AIM.SOUTH:
				if south_anim.is_playing():
					south_anim.frame = 0
				south_anim.visible = true
				south_anim.play()
				speaker.set_stream(voxes[randi_range(0,voxes.size()-1)])
				speaker.play()
			AIM.EAST:
				if east_anim.is_playing():
					east_anim.frame = 0
				east_anim.visible = true
				east_anim.play()
				speaker.set_stream(snares[randi_range(0,snares.size()-1)])
				speaker.play()
			AIM.WEST:
				if west_anim.is_playing():
					west_anim.frame = 0
				west_anim.visible = true
				west_anim.play()
				speaker.set_stream(hihats[randi_range(0,hihats.size()-1)])
				speaker.play()
		### SEE WHAT IT HIT ###
		var target = curr_gun.get_collider()
		if target and target.is_in_group("Enemies"):
			# Damage Enemy
			#print("Enemy Hit")
			# Isolate the root node of the enemy, and apply damage to its health
			Globals.KILLS += 1
			target.owner.hurt(damage)
			
			#print(Globals.KILLS)
		else:
			#print("Enemy Miss")
			pass

func restart_level():
	respawn_clock.start()
func _on_respawn_timer_timeout():
	owner.get_tree().reload_current_scene()
func _on_north_anim_animation_finished():
	north_anim.visible = false
func _on_south_anim_animation_finished():
	south_anim.visible = false
func _on_east_anim_animation_finished():
	east_anim.visible = false
func _on_west_anim_animation_finished():
	west_anim.visible = false


func _on_animated_sprite_2d_animation_finished():
	sprite.set_frame_and_progress(0,0)

