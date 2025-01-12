extends Control

@onready var root:Node = get_tree().root
@onready var current_scene:Node = root.get_child(-1)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	if(current_scene):
		Pong.goto_scene(current_scene, "res://Main.tscn")


func _on_quit_pressed():
	get_tree().quit()
