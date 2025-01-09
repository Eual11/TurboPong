extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func rand_choice(arr: Array):
	return arr[randi()%arr.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_area_entered(area):
	if area.name == "Ball":
		print("fuck")
		area.reset(area.inital_position, Vector2(rand_choice([-1,1]),rand_choice([-1,1])))
