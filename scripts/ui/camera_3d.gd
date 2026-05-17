extends Camera3D

@onready var camera_3d: Camera3D = $"."
@onready var move_to_door: Area2D = $CanvasLayer/move_to_door
@onready var move_to_fireplace: Area2D = $CanvasLayer/move_to_fireplace
@onready var move_to_couch: Area2D = $CanvasLayer/move_to_couch
@onready var anim_player: AnimationPlayer = $"../AnimationPlayer"

var pos_main : bool = true
var first_move = ""
var second_move = ""
func _ready() -> void:
	move_to_door.mouse_entered.connect(func() -> void: move("move_to_door"))
	move_to_fireplace.mouse_entered.connect(func() -> void: move("move_to_fireplace"))
	move_to_couch.mouse_entered.connect(func() -> void: move("move_to_couch"))

func move(anim):
	if pos_main:
		first_move = anim
		anim_player.play(anim)
		pos_main = false
	else:
		second_move = anim 
		if first_move == second_move:
			anim_player.play_backwards(anim)
			pos_main = true
