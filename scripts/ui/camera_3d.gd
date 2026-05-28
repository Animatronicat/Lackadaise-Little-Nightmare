extends Camera3D

@warning_ignore_start("unused_parameter")

@onready var camera_3d: Camera3D = $"."
@onready var move_to_door: Area2D = $CanvasLayer/move_to_door
@onready var rotate_right: Area2D = $CanvasLayer/rotate_right
@onready var rotate_left: Area2D = $CanvasLayer/rotate_left

@onready var anim_player: AnimationPlayer = $"../AnimationPlayer"
@onready var rc3d: RayCast3D = $RayCast3D

var pos_main : bool = true
var first_move = ""
var second_move = ""
var is_rotation_finished : bool = true
func _ready() -> void:
	rotate_right.mouse_entered.connect(func(): rotate_cam(-1))
	rotate_left.mouse_entered.connect(func(): rotate_cam(1))
	



func rotate_cam(dir):
	if is_rotation_finished and pos_main:
		is_rotation_finished = false
		var tween = get_tree().create_tween()
		tween.tween_property(camera_3d, "rotation_degrees", camera_3d.rotation_degrees + Vector3(0,90,0)*dir, 0.2)
		tween.tween_callback(func(): is_rotation_finished = true)
	else:
		#add input_buffer in future
		pass

func move():
	if rc3d.is_colliding():
		var target = rc3d.get_collider()
		if pos_main:
			pos_main = false
			anim_player.play(target.name)
			print(rc3d.get_collider())
		else:
			pos_main = true
			anim_player.play_backwards(target.name)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			move()
	
	if Input.is_action_just_pressed("left"):
		rotate_cam(1)
	
	if Input.is_action_just_pressed("right"):
		rotate_cam(-1)
	
	if Input.is_action_just_pressed("forword"):
		if pos_main:
			move()
	
	if Input.is_action_just_pressed("back"):
		if !pos_main:
			move()
		else:
			rotate_cam(-2)
