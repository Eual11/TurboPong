extends Node


# Game Logic
# Called when the node enters the scene tree for the first time.

@onready var root: Node = get_tree().root

#Main Game
var Main:Node

#Game HUD
var HUD:CanvasLayer

var Ball:Area2D;
var EndGame:CanvasLayer
@onready var BallScene = preload("res://Ball.tscn")


var celling_floor_size: float=16.0;
var GAME_RUNNING = false;

func _ready():
	SignalBus.button_pressed.connect(button_press_handler)
	
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
	

func button_press_handler(btn_name:StringName)->void:
	print(btn_name)
