extends KinematicBody

const MOVE_SPEED_FACTOR = 1.5
const SPAWN_ENEMY_INTERVAL = 8.0

var velocity = Vector3()
var move_speed = 0.5
var target_translation
var spawn_enemy_timer := 0.0
export var ball_drop_distance = 50
export var ball_drop_progress = 0.0
var rewind_secs = 0.0
var countdown_timer: float
var Enemy = preload ("res://scenes/NPC/groblen.tscn")

onready var secs_text_label: RichTextLabel = $Control/RichTextLabelSecs
onready var anim_ball_drop: AnimationPlayer = $AnimationPlayerBallDrop

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.init_ball()
	$AnimationPlayerBallSpin.play("spin")
	$AnimationPlayerBallDrop.play("Drop")
	target_translation = Vector3(0.0,translation.y,0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_enemy_timer += delta
	if spawn_enemy_timer > SPAWN_ENEMY_INTERVAL:
		_spawn_enemy()
		spawn_enemy_timer = 0.0
	
	countdown_timer = floor(anim_ball_drop.current_animation_length) - floor(anim_ball_drop.current_animation_position)
	secs_text_label.text = str(countdown_timer) + " Seconds"

	_process_move_ball_back_to()
	if Input.is_action_pressed("dev_add_time"):
		move_ball_back_secs(1.0)
	_set_ball_drop(ball_drop_progress)
	
	# Move towards player
	move_speed = MOVE_SPEED_FACTOR * ball_drop_progress
	target_translation.x = get_parent().get_node("KinematicBody").translation.x
	target_translation.z = get_parent().get_node("KinematicBody").translation.z
	velocity = (target_translation-translation).normalized()*move_speed
	velocity = move_and_slide(velocity);
	
	#if countdown_timer == 3:
		#if not $AudioStreamPlayer.playing:
		#	$AudioStreamPlayer.play()


func _set_ball_drop(ball_drop_progress: float):
	var top_y = ball_drop_distance
	var bottom_y = ball_drop_distance - 1.5
	var ball_y = top_y - ball_drop_progress * bottom_y
	$Icosphere.translation.y = ball_y


func move_ball_back_secs(secs: float):
	$AnimationPlayerBallDrop.playback_speed = 4.0
	rewind_secs = clamp($AnimationPlayerBallDrop.current_animation_position - secs, 0.0, $AnimationPlayerBallDrop.current_animation_length)
	$AnimationPlayerBallDrop.play_backwards("Drop")


func _process_move_ball_back_to():
	if $AnimationPlayerBallDrop.current_animation_position <= rewind_secs:
		$AnimationPlayerBallDrop.play("Drop")
		$AnimationPlayerBallDrop.playback_speed = 1.0


func _spawn_enemy():
	var ball_pos = get_node("Icosphere").global_transform.origin
	var e = Enemy.instance()
	get_tree().get_root().add_child(e)
	e.global_transform.origin = ball_pos
