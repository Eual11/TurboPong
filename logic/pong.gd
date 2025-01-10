extends Node


# Game Logic
# Called when the node enters the scene tree for the first time.

var SCORE: Vector2 = Vector2.ZERO
@onready var root: Node = get_tree().root
@onready var main: Node = root.get_child(-1)
@onready var viewport_rect:Rect2=get_viewport().get_visible_rect()

@onready var HUD:CanvasLayer = root.get_node("/root/Main/HUD")
var celling_floor_size: float=16.0;
func _ready():
	var separator:Sprite2D = get_node("/root/Main/Separator")
	separator.position = Vector2(viewport_rect.size.x/2.0, viewport_rect.size.y/2.0);
	separator.scale = Vector2(1.0, viewport_rect.size.y/separator.get_rect().size.y)
	
	# Connecting Signals
	
	var p1_wall:Area2D = root.get_node("/root/Main/Player1_Wall")
	var p2_wall:Area2D = root.get_node("/root/Main/Player2_Wall")
	
	p1_wall.ball_entered.connect(player_scored)
	p2_wall.ball_entered.connect(player_scored)
	
	
	#Inital Score
	
	HUD.get_child(0).text ="0"
	HUD.get_child(1).text ="0"
func player_scored(player_idx:int, ball:Area2D):
	SCORE[1-player_idx]+=1
	HUD.get_child(0).text = str(SCORE[0])
	HUD.get_child(1).text = str(SCORE[1])
	ball.reset(ball.inital_position, Vector2(1 if player_idx==0 else -1, randf_range(-1,1)))

	
	
	
	
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
