extends Area2D


# paddle movement speeed
@export var DEFAULT_SPEED = 100.0
# modified for balls velocity 
@export var DEFAULT_BOUNCE = 1.0
@export var diff =0.1;

# Player and AI 
@export var PLAYER_AI:bool = false

var frame =0;

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
	if not Pong.GAME_RUNNING:
		return
	#TODO: Paddle Boost
	if not PLAYER_AI:
		direction.y= Input.get_action_strength(down_action) - Input.get_action_strength(up_action)
		position.y = clamp(position.y+direction.y*delta*speed, Pong.celling_floor_size+paddle_size.y/2.0, viewport_size.y-paddle_size.y/2-Pong.celling_floor_size);
	else:
		move_AI(delta)


func _on_area_entered(area):
	if area is Ball:
		area.direction= Vector2(ball_direction, direction.y*0.7+area.direction.y).normalized()
func move_AI(delta:float):
	#if there is no ball do nothing
	if not Pong.Ball:
		return
	#put the AI to sleep if the ball isn't in the incoming direction
	if(sign(Pong.Ball.direction.x) == sign(ball_direction)):
		return
	var ball_pos:Vector2 = Pong.Ball.position
	var dir:float = clampf(lerp(0.0, ball_pos.y - position.y, 0.01), -diff, diff);
	position.y = clamp(position.y+dir*delta*speed, Pong.celling_floor_size+paddle_size.y/2.0, viewport_size.y-paddle_size.y/2-Pong.celling_floor_size);
	
	
