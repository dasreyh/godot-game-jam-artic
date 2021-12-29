extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_toggle = true
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("Remove GUI from player node")
	print("Add input restart.")
	
	#set game window
	OS.window_size = Vector2(1280,720)
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

	
func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		mouse_toggle()
		
	if (Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()
		
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if (Input.is_action_just_pressed("toggle_console")):
		get_node("../KinematicBody/GUI/console").visible = !get_node("../KinematicBody/GUI/console").visible
		
func mouse_toggle():
	if mouse_toggle == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_toggle = false
		get_tree().paused = true
		get_node("../KinematicBody/GUI/pause").show()


	elif mouse_toggle == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_toggle = true
		get_tree().paused = false
		get_node("../KinematicBody/GUI/pause").hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
