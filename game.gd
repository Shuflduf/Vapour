@tool
extends Control

@export var app_path: String
@export_global_file("*.png", "*.jpg", "*.ktx", "*.webp", "*.tga") var app_icon: String:
	set(value):
		if icon == null:
			await ready
		app_icon = value
		icon.texture = ImageTexture.create_from_image(Image.load_from_file(value))

@export_color_no_alpha var border_colour: Color:
	set(value):
		if outline == null:
			await ready
		border_colour = value
		var styleBox: StyleBoxFlat = outline.get_theme_stylebox("panel").duplicate()
		styleBox.set("border_color", value)
		outline.add_theme_stylebox_override("panel", styleBox)


@onready var label: Control = %Label
@onready var icon: TextureRect = %Art
@onready var outline: Panel = %Panel

var selected = false:
	set(value):
		selected = value
		if outline == null:
			await ready
		var styleBox: StyleBoxFlat = outline.get_theme_stylebox("panel").duplicate()
		styleBox.set("draw_center", value)
		outline.add_theme_stylebox_override("panel", styleBox)

var tween: Tween

const pic_size = 128


func _ready() -> void:
	label.position.x = 0
	label.text = name

func tween_label(out: bool):
	if tween:
		await tween.finished

	tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label, "position:x", pic_size * int(out), 0.3)\
			.set_ease(Tween.EASE_OUT if out else Tween.EASE_IN)

	tween.finished.connect(func():
		tween = null)


func _on_game_mouse_entered() -> void:
	selected = true
	tween_label(true)


func _on_game_mouse_exited() -> void:
	selected = false
	tween_label(false)


func _on_game_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("OPEN")
				OS.shell_open(app_path)
