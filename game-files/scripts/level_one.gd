### FIRST LEVEL OF THE GAME ###
extends Node2D

### FOR POSITIONING ###
var SCREENX : int
var SCREENY : int 
var CENTERX : int
var CENTERY : int

### HOLDING THE PLAYER ###
@export var player  : Node2D

### LOAD ENEMY SCENES ###
var enemy = preload("res://scenes/bad_guy.tscn")
var enemy_pather = preload("res://scenes/worse_guy.tscn")
var enemy_radial = preload("res://scenes/radial_guy.tscn")


### HOLDING SPAWNERS ###
@export var Nmark  : Marker2D
@export var Smark  : Marker2D
@export var Emark  : Marker2D
@export var Wmark : Marker2D

### SPAWNER OFFSET FROM SCREEN ###
@export var spwn_offset : int = 24

### TO FIGURE OUT DIRECTION OF SPAWN ###
enum DIR {NORTH, SOUTH, EAST, WEST}

### MARKER ARRAY ###
var spawn_arr 
var total_spawns : int

### TIMER ###
@export var spawn_clock : Timer
@export var min_spawn_time : float = 1.0
@export var max_spawn_time : float = 2.0

### PATH FOR SPAWNING WORSE GUY ###
@export var path : Path2D

@export var delta_spawn : float = 0.05 # Amount that spawn interval decreases every 10 kills 

## Node for score text
@export var score_text : RichTextLabel
## Node for high score text
@export var h_score_text : RichTextLabel

@export var LIFE_1 : TextureRect
@export var LIFE_2 : TextureRect
@export var LIFE_3 : TextureRect
func _ready():
	check_lives()
	position_actors()
	### HOLD MARKERS IN ARRAY ###
	spawn_arr = [Nmark, Smark, Emark, Wmark]
	total_spawns = spawn_arr.size()
	h_score_text.text = "%010d" % Globals.HIGH_SCORE
	score_text.text = "%010d" % Globals.SCORE
	Globals.filled_gates = {
	DIR.NORTH : 0,
	DIR.SOUTH : 0,
	DIR.EAST  : 0,
	DIR.WEST  : 0
	}
func _process(_delta):
	pass
func position_actors():
	### ASSIGN VALUES FOR POSITIONING ###
	SCREENX = floor(get_viewport_rect().size.x)
	SCREENY = floor(get_viewport_rect().size.y) 
	CENTERX = floor(get_viewport_rect().size.x / 2) + 8
	CENTERY = floor(get_viewport_rect().size.y / 2)
	
	### CENTER PLAYER ###
	player.position.y = CENTERY
	player.position.x = CENTERX
	
	### POSITION SPAWNERS ###
	# NORTH SPAWNER #
	Nmark.position.x = CENTERX
	Nmark.position.y = -spwn_offset
	
	# SOUTH SPAWNER #
	Smark.position.x = CENTERX
	Smark.position.y = SCREENY + spwn_offset
	
	# EAST SPAWNER #
	Emark.position.x = SCREENX + spwn_offset 
	Emark.position.y = CENTERY
	
	# WEST SPAWNER #
	Wmark.position.x = -spwn_offset + 16 #ALERT CHANGE THIS
	Wmark.position.y = CENTERY
	
	## SET UP SCORE TEXT LINK BETWEEN PLAYER AND TEXT BOX
	player.score_text = score_text
	player.h_score_text = h_score_text
func spawn_enemy():
	# EVENTUALLY WILL DO RANDOM SPAWN AT RANDOM TIMES, WITH SPLINES FOR THE SPECIAL FAST ENEMIES
	# ROLL 1 - 100
	var dice_roll : int = randi_range(1,100)
	
	### SPAWN ENEMY ###
	# Spawn enemy at random marker
	var rand_mark: int = randi_range(0,total_spawns-1)
	
	if dice_roll <= Globals.BASIC_ODDS and Globals.filled_gates[rand_mark] == 0:
		var enemy_inst = enemy.instantiate()
		enemy_inst.player = player
		add_child(enemy_inst)
		enemy_inst.position = spawn_arr[rand_mark].position
		### MOVE THE ENEMY TOWARDS THE CENTER ###
		# SPAWN ENEMY AT RANDOM INDEX, MOVE THEM IN THE CORRECT DIRECTION, WILL NEED TO REFACTOR FOR SPECIAL
		# ENEMIES
		match rand_mark:
			DIR.NORTH:
				enemy_inst.direction = Vector2.DOWN
				Globals.filled_gates[DIR.NORTH] = 1
				enemy_inst.gate = DIR.NORTH
			DIR.SOUTH:
				enemy_inst.direction = Vector2.UP
				Globals.filled_gates[DIR.SOUTH] = 1
				enemy_inst.gate = DIR.SOUTH
			DIR.EAST:
				enemy_inst.direction = Vector2.LEFT
				Globals.filled_gates[DIR.EAST] = 1
				enemy_inst.gate = DIR.EAST
			DIR.WEST:
				enemy_inst.direction = Vector2.RIGHT
				Globals.filled_gates[DIR.WEST] = 1
				enemy_inst.gate = DIR.WEST
		enemy_inst.align_sprite()
	else:
		dice_roll -= Globals.BASIC_ODDS
		if dice_roll <= Globals.SPECIAL_ODDS or Globals.filled_gates[rand_mark] == 1: # SPECIAL CASE
			var enemy_inst = enemy_pather.instantiate()
			enemy_inst.player = player
			# ATTACH TO PATH
			path.add_child(enemy_inst)
		else: # RARE CASE
			var enemy_inst = enemy_radial.instantiate()
			enemy_inst.player = player
			add_child(enemy_inst)
			# Could attach enemy to player here instead of using center of viewport
func _on_spawn_timer_timeout():
	print("No change in bump, currently = ", Globals.LAST_BUMP)
	if(!player.dead):
		spawn_enemy()
		#if Globals.KILLS % 10 == 0 and Globals.KILLS != 0 and Globals.LAST_BUMP != Globals.KILLS:
		if Globals.KILLS % 10 == 0 and Globals.LAST_BUMP != Globals.KILLS:
			Globals.LAST_BUMP = Globals.KILLS
			print("Spawn time decrease")
			print("Change in recent bump to: ", Globals.LAST_BUMP)
			Globals.SPAWN_INCREASE -= delta_spawn # Less time between spawns every 10 kills
		spawn_clock.wait_time = randf_range(min_spawn_time, max_spawn_time) * Globals.SPAWN_INCREASE


func _on_good_guy_im_dead():
	check_lives()


func check_lives():
	match Globals.LIVES:
		3:
			LIFE_1.visible = true
			LIFE_2.visible = true
			LIFE_3.visible = true
		2:
			LIFE_1.visible = true
			LIFE_2.visible = true
			LIFE_3.visible = false
		1:
			LIFE_1.visible = true
			LIFE_2.visible = false
			LIFE_3.visible = false
		0:
			LIFE_1.visible = false
			LIFE_2.visible = false
			LIFE_3.visible = false	
	
