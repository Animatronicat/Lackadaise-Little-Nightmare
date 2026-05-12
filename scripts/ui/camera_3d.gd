extends Camera3D

var speed = 1
@onready var rotateright: Area2D = $CanvasLayer/rotateright
@onready var rotateleft: Area2D = $CanvasLayer/rotateleft

var is_rotating_l: bool = false
var is_rotating_r : bool = false

func _ready() -> void:
	rotateleft.mouse_entered.connect(func() : is_rotating_l = true)
	rotateleft.mouse_exited.connect(func() : is_rotating_l = false)
	rotateright.mouse_entered.connect(func() : is_rotating_r = true)
	rotateright.mouse_exited.connect(func() : is_rotating_r = false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_rotating_l:
		rot(delta, 1)
	if is_rotating_r:
		rot(delta, -1)

func rot(delta, direction):
	while true:
		rotation.y += 1 * delta * direction
		#rotate_y(0.02)
		if rotateleft.mouse_exited:
			break
