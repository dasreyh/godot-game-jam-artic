extends Control

func _input(event):
	if(event is InputEventKey):
		goto_title()
		
func goto_title():
	get_tree().change_scene("res://scenes/menus/main-menu.tscn")
	
func _on_AnimationPlayer_animation_finished(_anim_name):
	goto_title()
	pass

func _ready():
	$AnimationPlayer.play("logo")
