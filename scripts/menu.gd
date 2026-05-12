extends Control

@onready var play: Button = $Buttons/Play
@onready var settings: Button = $Buttons/Settings
@onready var credits: Button = $Buttons/Credits
@onready var exit: Button = $Buttons/Exit

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	play.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://scenes/loadscreen.tscn"))
	settings.pressed.connect(func() -> void: pass)
	credits.pressed.connect(func() -> void: pass)
	exit.pressed.connect(func() -> void: get_tree().quit())

func _process(delta: float) -> void:
	pass
