extends Area2D
class_name Ball

@export var DEFAULT_SPEED:float = 200.0
@export var MAX_SPEED: float = 600.0
@export var accelaration: float=10.0
@onready var viewport_rect = get_viewport_rect()
@onready var inital_position:Vector2 = get_viewport().get_visible_rect().size/2.0
var speed: float = DEFAULT_SPEED
var direction: Vector2 = Vector2(1.0, 1.0);

# Called when the node enters the scene tree for the first time.
func _ready():
	reset(inital_position, direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func _physics_process(delta):
	if not Pong.GAME_RUNNING:
		return
	position+=direction*speed*delta
	if(speed < MAX_SPEED):
		speed+=accelaration*delta
	
	
	
func reset(pos:Vector2, dir: Vector2)->void:
	position = pos
	direction = dir.normalized()
	speed = DEFAULT_SPEED
