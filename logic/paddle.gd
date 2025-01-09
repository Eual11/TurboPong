extends Area2D


# paddle movement speeed
@export var DEFAULT_SPEED = 100.0
# modified for balls velocity 
@export var DEFAULT_BOUNCE = 1.0
@onready var speed: float = DEFAULT_SPEED
@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var paddle_size = $Sprite2D.get_rect().size

var up_action: StringName;
var down_action: StringName;
var ball_direction: float;


func _ready():
	var n:String = name.to_lower()
	up_action = n+"_move_up"
	down_action = n+"_move_down"
	
	if(n =="left"):
		ball_direction = 1.0
	else: ball_direction = -1.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#TODO: Paddle Boost
	
	var motion = Input.get_action_strength(down_action) - Input.get_action_strength(up_action)
	position.y = clamp(position.y+motion*delta*speed, paddle_size.y/2.0, viewport_size.y-paddle_size.y/2);


func _on_area_entered(area):
	
	if area.name == "Ball":
		area.direction= Vector2(ball_direction, 0.0)
