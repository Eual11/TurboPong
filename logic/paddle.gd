extends Area2D


# paddle movement speeed
@export var DEFAULT_SPEED = 100.0
# modified for balls velocity 
@export var DEFAULT_BOUNCE = 1.0
@onready var speed: float = DEFAULT_SPEED
@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var paddle_size:Vector2 = $Sprite2D.get_rect().size*$Sprite2D.scale

var up_action: StringName;
var down_action: StringName;
var ball_direction: float;
var direction: Vector2;


func _ready():
	var n:String = name.to_lower()
	up_action = n+"_move_up"
	down_action = n+"_move_down"
	
	if(n =="left"):
		ball_direction = 1.0
	else: ball_direction = -1.0
	print(name, paddle_size)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#TODO: Paddle Boost
	
	direction.y= Input.get_action_strength(down_action) - Input.get_action_strength(up_action)
	position.y = clamp(position.y+direction.y*delta*speed, Pong.celling_floor_size+paddle_size.y/2.0, viewport_size.y-paddle_size.y/2-Pong.celling_floor_size);


func _on_area_entered(area):
	if area is Ball:
		area.direction= Vector2(ball_direction, direction.y*0.7+area.direction.y).normalized()
