extends Node


# Game Logic
# Called when the node enters the scene tree for the first time.

var SCORE: Vector2 = Vector2.ZERO
@onready var root: Node = get_tree().root
@onready var viewport_rect:Rect2=get_viewport().get_visible_rect()
@export var END_SCORE: int =3;

#Main Game
var Main:Node

#Game HUD
var HUD:CanvasLayer

var Ball:Area2D;
var EndGame:CanvasLayer



@onready var BallScene = preload("res://Ball.tscn")


var celling_floor_size: float=16.0;
var GAME_RUNNING = false;


func load_game():	
	
	Main = root.get_node("Main")
	if(Main):
		HUD = Main.get_node("HUD")
		Ball = Main.get_node("Ball")
		EndGame = Main.get_node("EndGame")
		EndGame.hide()
	else:
		get_tree().root.print_tree_pretty()

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
		GAME_RUNNING = true
	
func _ready():
		load_game()
	

func player_scored(player_idx:int, ball:Area2D):
	SCORE[1-player_idx]+=1
	HUD.get_child(0).text = str(SCORE[0])
	HUD.get_child(1).text = str(SCORE[1])
	
	if(SCORE[player_idx]==END_SCORE):
		player_wins(player_idx)
	elif(SCORE[1-player_idx] == END_SCORE):
		player_wins(1-player_idx)
	else:
		ball.reset(ball.inital_position, Vector2(1 if player_idx==0 else -1, randf_range(-1,1)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func goto_scene(current_scene:Node, path:String):
	if(_defered_goto_scene(path)):
		current_scene.queue_free()
	else:
		print("Couldn't path given or null current_scene")
		
	
func _defered_goto_scene(path:String)->bool:
	
	var s:PackedScene = ResourceLoader.load(path)
	
	if not s:
		return false
	var new_scene = s.instantiate()
	
	if not new_scene:
		return false
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene
	
	return true
	
func player_wins(idx:int):
	EndGame.update_win_label("Player "+str(idx)+"Wins")
	EndGame.show()
	GAME_RUNNING = false
