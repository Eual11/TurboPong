extends Area2D

@export var ball_direction:float 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func reflect(n:Vector2, v:Vector2)->Vector2:
	return v- n.dot(v)*2.0*(n)  ;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is Ball:
		#reflecting the ball with some randomness
		area.direction = (reflect(Vector2(0.0, ball_direction), area.direction)+Vector2(randf_range(-0.04, 0.04), randf_range(-0.04, 0.04))).normalized()
		
