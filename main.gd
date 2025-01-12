extends Node


var SCORE: Vector2 = Vector2.ZERO
@export var END_SCORE:int =1
@onready var viewport_rect:Rect2=get_viewport().get_visible_rect()
# Called when the node enters the scene tree for the first time.
func _ready():	
	var Player1_Score_Label:Label = $HUD.get_child(0)
	var Player2_Score_Label:Label = $HUD.get_child(1)
	$EndGame.hide()

	var separator:Sprite2D = $Separator
	separator.position = Vector2(viewport_rect.size.x/2.0, viewport_rect.size.y/2.0);
	separator.scale = Vector2(1.0, viewport_rect.size.y/separator.get_rect().size.y)
	var p1_wall:Area2D = $Player1_Wall
	var p2_wall:Area2D = $Player2_Wall
	
	p1_wall.ball_entered.connect(player_scored)
	p2_wall.ball_entered.connect(player_scored)
	$HUD.get_child(0).text ="0"
	$HUD.get_child(1).text ="0"
	Player1_Score_Label.position = Vector2(viewport_rect.size.x/2.0-36, 36)
	Player2_Score_Label.position = Vector2(viewport_rect.size.x/2.0+32, 36)
	Pong.Ball = $Ball
	Pong.GAME_RUNNING = true
	
	#Connections to signal Bus

	SignalBus.button_pressed.connect(button_press_handler)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_scored(player_idx:int, ball:Ball):
	SCORE[1-player_idx]+=1	
	update_score()
	if(SCORE[1-player_idx]>=END_SCORE):
		player_wins((2-player_idx))
	else:
		ball.reset(ball.inital_position, Vector2(1 if player_idx==0 else -1, randf_range(-1,1)))
func player_wins(idx:int):
	$EndGame.update_win_label("Player "+str(idx)+" Wins")
	$EndGame.show()
	Pong.GAME_RUNNING = false

func reset_game():
	#Resting Player score
	SCORE = Vector2(0.0, 0.0)
	#hide Game end layer
	$EndGame.hide()
	update_score()
	$Ball.reset($Ball.inital_position, Vector2((randi()%2+1), randf_range(-1.0, 1.0)))

func update_score():
	$HUD.get_child(0).text = str(SCORE[0])
	$HUD.get_child(1).text = str(SCORE[1])
func button_press_handler(button_name:StringName):
	if button_name == "endgame_restart":
		Pong.GAME_RUNNING = true
		reset_game()
	elif button_name == "endgame_menu":
		pass
