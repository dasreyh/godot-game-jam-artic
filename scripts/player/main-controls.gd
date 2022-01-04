extends Spatial

var mouse_toggle = true
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		mouse_toggle()
		
	if (Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()
		
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if (Input.is_action_just_pressed("toggle_console")):
		$"../GUI/console".visible = !$"../GUI/console".visible
		
func mouse_toggle():
	if mouse_toggle == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_toggle = false
		get_tree().paused = true
		$"../GUI/pause".show()

	elif mouse_toggle == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_toggle = true
		get_tree().paused = false
		$"../GUI/pause".hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
