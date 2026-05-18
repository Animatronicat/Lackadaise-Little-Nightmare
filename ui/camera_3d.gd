extends Camera3D

@onready var camera_3d: Camera3D = $"."
@onready var move_to_door: Area2D = $CanvasLayer/move_to_door
@onready var rotate_right: Area2D = $CanvasLayer/rotate_right
@onready var rotate_left: Area2D = $CanvasLayer/rotate_left
@onready var area_2d: Area2D = $CanvasLayer/Area2D

@onready var anim_player: AnimationPlayer = $"../AnimationPlayer"

var pos_main : bool = true
var first_move = ""
var second_move = ""
var is_rotation_finished : bool = true
func _ready() -> void:
	#move_to_door.mouse_entered.connect(func() -> void: move("move_to_door"))
	#move_to_fireplace.mouse_entered.connect(func() -> void: move("move_to_fireplace"))
	#move_to_couch.mouse_entered.connect(func() -> void: move("move_to_couch"))
	rotate_right.mouse_entered.connect(func(): rotate_cam(-1))
	rotate_left.mouse_entered.connect(func(): rotate_cam(1))



func rotate_cam(dir):
	if is_rotation_finished:
		is_rotation_finished = false
		var tween = get_tree().create_tween()
		tween.tween_property(camera_3d, "rotation_degrees", camera_3d.rotation_degrees + Vector3(0,90,0)*dir, 0.2)
		tween.tween_callback(func(): is_rotation_finished = true)
	else:
		#add to the action memory function
		pass
		


func move():
	if camera_3d.rotation_degrees.y == 90:
		anim_player.play("move_to_door")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click_to_move"):
		move()
