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
@export var max_spawn_time : float = 3.0

### PATH FOR SPAWNING WORSE GUY ###
@export var path : Path2D

func _ready():
	position_actors()
	### HOLD MARKERS IN ARRAY ###
	spawn_arr = [Nmark, Smark, Emark, Wmark]
	total_spawns = spawn_arr.size()

func _process(_delta):
	pass
func position_actors():
	### ASSIGN VALUES FOR POSITIONING ###
	SCREENX = floor(get_viewport_rect().size.x)
	SCREENY = floor(get_viewport_rect().size.y) 
	CENTERX = floor(get_viewport_rect().size.x / 2)
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
	Wmark.position.x = -spwn_offset
	Wmark.position.y = CENTERY

func spawn_enemy():
	# ALERT: DONT FORGET TO PARENT THE "WORSE GUY" TO THE PATH2D
	# EVENTUALLY WILL DO RANDOM SPAWN AT RANDOM TIMES, WITH SPLINES FOR THE SPECIAL FAST ENEMIES
	# ROLL 1 - 100
	var dice_roll : int = randi_range(1,100)
	print("roll", dice_roll)
	
	### SPAWN ENEMY ###
	# Spawn enemy at random marker
	var rand_mark: int = randi_range(0,total_spawns-1)
	if dice_roll <= Globals.BASIC_ODDS:
		var enemy_inst = enemy.instantiate()
		add_child(enemy_inst)
		enemy_inst.position = spawn_arr[rand_mark].position
		### MOVE THE ENEMY TOWARDS THE CENTER ###
		# SPAWN ENEMY AT RANDOM INDEX, MOVE THEM IN THE CORRECT DIRECTION, WILL NEED TO REFACTOR FOR SPECIAL
		# ENEMIES
		match rand_mark:
			DIR.NORTH:
				enemy_inst.direction = Vector2.DOWN
			DIR.SOUTH:
				enemy_inst.direction = Vector2.UP
			DIR.EAST:
				enemy_inst.direction = Vector2.LEFT
			DIR.WEST:
				enemy_inst.direction = Vector2.RIGHT
	else:
		dice_roll -= Globals.BASIC_ODDS
		if dice_roll <= Globals.SPECIAL_ODDS: # SPECIAL CASE
			var enemy_inst = enemy_pather.instantiate()
			# ATTACH TO PATH
			path.add_child(enemy_inst)
		else: # RARE CASE
			var enemy_inst = enemy_radial.instantiate()
			add_child(enemy_inst)
			# Could attach enemy to player here instead of using center of viewport

func _on_spawn_timer_timeout():
	if(!player.dead):
		spawn_enemy()
		spawn_clock.wait_time = randf_range(min_spawn_time, max_spawn_time)
