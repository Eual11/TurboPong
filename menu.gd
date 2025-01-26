extends Control

@onready var root:Node = get_tree().root
@onready var current_scene:Node = root.get_child(-1)
var WIN_SCORE: int;
var PLAYER2_AI: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	$VBoxContainer/OnePlayer.hide()
	$VBoxContainer/TwoPlayers.hide()
	if(current_scene):
		Pong.goto_scene(current_scene, "res://Main.tscn", {"player2_ai": true})


func _on_quit_pressed():
	get_tree().quit()

func toggle_play_select(val:bool)->void:
	if(val):
		$VBoxContainer/Play_Select.show()
	else:
		$VBoxContainer/Play_Select.hide()
		
func toggle_win_cond(val:bool)->void:
	if(val):
		$VBoxContainer/Win_Cond.show()
	else:
		$VBoxContainer/Win_Cond.hide()
func _on_one_player_pressed():
	PLAYER2_AI = true 
	toggle_play_select(false)
	toggle_win_cond(true)



func _on_two_players_pressed():
	PLAYER2_AI = false 
	toggle_play_select(false)
	toggle_win_cond(true)


func play_game():
	if(current_scene):
		Pong.goto_scene(current_scene, "res://Main.tscn", {"player2_ai": PLAYER2_AI, "win_score":WIN_SCORE})

func _on_wi_1_pressed():
	WIN_SCORE =1 
	play_game()


func _on_wi_3_pressed():
	WIN_SCORE =3
	play_game()


func _on_wi_7_pressed():
	WIN_SCORE =7
	play_game()

func _on_back_pressed():
	toggle_play_select(true)
	toggle_win_cond(false)
