extends Control

@export var app_path: String
@export var app_name: String
@export var app_icon: Texture2D

@onready var label: Control = %Label
@onready var icon: TextureRect = %Art

var tween: Tween
const pic_size = 128

func _ready() -> void:
	#icon.texture = app_icon
	label.text = app_name

func tween_label(out: bool):
	if tween:
		await tween.finished

	tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label, "position:x", pic_size * int(out), 0.3)\
			.set_ease(Tween.EASE_OUT if out else Tween.EASE_IN)

	tween.finished.connect(func():
		tween = null)


func _on_game_mouse_entered() -> void:
	tween_label(true)


func _on_game_mouse_exited() -> void:
	tween_label(false)


func _on_game_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("OPEN")
				OS.shell_open(app_path)
