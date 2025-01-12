extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_win_label(new_text:String):
	$VBoxContainer/End_Text.text = new_text


func _on_menu_btn_pressed():
	SignalBus.button_pressed.emit(&"endgame_menu")


func _on_restart_pressed():
	SignalBus.button_pressed.emit(&"endgame_restart")
