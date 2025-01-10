extends Node


# Game Logic
# Called when the node enters the scene tree for the first time.

var SCORE: Vector2 = Vector2.ZERO
@onready var root: Node = get_tree().root
@onready var viewport_rect:Rect2=get_viewport().get_visible_rect()

var Main:Node
var HUD:CanvasLayer



@onready var BallScene = preload("res://Ball.tscn")


var celling_floor_size: float=16.0;


func load_game():
	
	if(Main):
		HUD = Main.get_node("HUD")
	if(HUD):
		var Player1_Score_Label:Label = HUD.get_child(0)
		var Player2_Score_Label:Label = HUD.get_child(1)

		var separator:Sprite2D = Main.get_node("Separator")
		separator.position = Vector2(viewport_rect.size.x/2.0, viewport_rect.size.y/2.0);
		separator.scale = Vector2(1.0, viewport_rect.size.y/separator.get_rect().size.y)
	
	# Connecting Signals
	
		var p1_wall:Area2D = Main.get_node("Player1_Wall")
		var p2_wall:Area2D = Main.get_node("Player2_Wall")
	
		p1_wall.ball_entered.connect(player_scored)
		p2_wall.ball_entered.connect(player_scored)


		HUD.get_child(0).text ="0"
		HUD.get_child(1).text ="0"

		Player1_Score_Label.position = Vector2(viewport_rect.size.x/2.0-36, 36)
		Player2_Score_Label.position = Vector2(viewport_rect.size.x/2.0+32, 36)
	
func _ready():
		Main = root.get_node("Main")
		
		if(Main):
			load_game()

	
	#Inital Score
	

func player_scored(player_idx:int, ball:Area2D):
	SCORE[1-player_idx]+=1
	HUD.get_child(0).text = str(SCORE[0])
	HUD.get_child(1).text = str(SCORE[1])
	ball.reset(ball.inital_position, Vector2(1 if player_idx==0 else -1, randf_range(-1,1)))
	

	

	
	
	
	
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
