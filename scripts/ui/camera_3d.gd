extends Camera3D

@warning_ignore_start("unused_parameter")

@onready var camera_3d: Camera3D = $"."
@onready var move_to_door: Area2D = $CanvasLayer/move_to_door
@onready var rotate_right: Area2D = $CanvasLayer/rotate_right
@onready var rotate_left: Area2D = $CanvasLayer/rotate_left

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
	if is_rotation_finished and pos_main:
		is_rotation_finished = false
		var tween = get_tree().create_tween()
		tween.tween_property(camera_3d, "rotation_degrees", camera_3d.rotation_degrees + Vector3(0,90,0)*dir, 0.2)
		tween.tween_callback(func(): is_rotation_finished = true)
	else:
		#add to the action memory function in future
		pass
		


func move(anim):
	if pos_main:
		pos_main = false
		anim_player.play(anim)
	else:
		pos_main = true
		anim_player.play_backwards(anim)


func _on_coll_door_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			move("move_to_door")
			if !pos_main:
				await 1
				$"../AudioStreamPlayer".play()
				$"../Sprite3D".show()
				var tween = get_tree().create_tween()
				tween.tween_property($"../Sprite3D", "modulate:a", 0, 1.0)
				tween.tween_callback(abc)

func abc():
	$"../Sprite3D".hide()
	$"../Sprite3D".modulate.a = 225

func _on_coll_fireplace_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			move("move_to_fireplace")


func _on_couch_coll_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			move("move_to_couch")


func _on_table_coll_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			move("move_to_table")
