extends Area2D


signal ball_entered(player_num:int, ball:Area2D)
@export var player_idx=0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func rand_choice(arr: Array):
	return arr[randi()%arr.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_area_entered(area):
	if area is Ball:
		ball_entered.emit(player_idx, area)
