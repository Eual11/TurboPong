extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	update_win_label("I am shit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_win_label(new_text:String):
	$VBoxContainer/End_Text.text = new_text
