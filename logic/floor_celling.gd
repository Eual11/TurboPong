extends Area2D

@export var ball_direction:float 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "Ball":
		
		area.direction = (area.direction+ Vector2(0.0, ball_direction)).normalized()
		
