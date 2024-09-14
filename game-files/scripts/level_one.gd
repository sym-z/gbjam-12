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

func _ready():
	position_actors()
	### HOLD MARKERS IN ARRAY ###
	spawn_arr = [Nmark, Smark, Emark, Wmark]
	total_spawns = spawn_arr.size()
	spawn_enemies()

func _process(_delta):
	pass
func position_actors():
	### ASSIGN VALUES FOR POSITIONING ###
	SCREENX = get_viewport_rect().size.x
	SCREENY = get_viewport_rect().size.y 
	CENTERX = get_viewport_rect().size.x / 2
	CENTERY = get_viewport_rect().size.y / 2
	
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

func spawn_enemies():
	# EVENTUALLY WILL DO RANDOM SPAWN AT RANDOM TIMES, WITH SPLINES
	### SPAWN ENEMIES ###
	for i in range(total_spawns):
		var enemy_inst = enemy.instantiate()
		add_child(enemy_inst)
		enemy_inst.position = spawn_arr[i].position
		### MOVE THE ENEMY TOWARDS THE CENTER ###
		match i:
			DIR.NORTH:
				enemy_inst.direction = Vector2.DOWN
			DIR.SOUTH:
				enemy_inst.direction = Vector2.UP
			DIR.EAST:
				enemy_inst.direction = Vector2.LEFT
			DIR.WEST:
				enemy_inst.direction = Vector2.RIGHT
