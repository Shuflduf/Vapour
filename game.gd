@tool
extends Control

@export var app_path: String
@export var app_name: String
@export var app_icon: Texture2D
@export_color_no_alpha var border_colour: Color:
	set(value):
		border_colour = value
		var styleBox: StyleBoxFlat = outline.get_theme_stylebox("panel").duplicate()
		styleBox.set("border_color", value)
		outline.add_theme_stylebox_override("panel", styleBox)


@onready var label: Control = %Label
@onready var icon: TextureRect = %Art
@onready var outline: Panel = %Panel


var tween: Tween
const pic_size = 128

#func set_colour()


func _ready() -> void:
	icon.texture = app_icon

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
