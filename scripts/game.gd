@tool
class_name GameEntry
extends Control

signal edited
signal hovered
signal description_edited
signal moved(up: bool)

@export_global_file("*.exe") var app_path: String
@export_global_file("*.png", "*.jpg", "*.ktx", "*.webp", "*.tga", "*.svg") var app_icon: String:
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

@export var display_only = false


@onready var label: Control = %Label
@onready var icon: TextureRect = %Art
@onready var outline: Panel = %Panel
@onready var right_click: PopupMenu = %RightClick
@onready var description: Window = $Description

var tween: Tween


const pic_size = 128

func save_dict() -> Dictionary:
	return {
		"app_path" : app_path,
		"app_icon" : app_icon,
		"name" : name,
		"border_colour" : var_to_str(border_colour * Color(1.0, 1.0, 1.0, 1.0)),
		"description:text" : description.text
	}


func _ready() -> void:
	label.position.x = 0
	label.text = name
	description.submitted.connect(func():
		description_edited.emit())

func tween_label(out: bool):

	if tween:
		await tween.finished

	tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label, "position:x", pic_size * int(out), 0.3)\
			.set_ease(Tween.EASE_OUT if out else Tween.EASE_IN)

	tween.finished.connect(func():
		tween = null)


func _on_game_mouse_entered() -> void:
	print(description.text)
	hovered.emit()
	tween_label(true)


func _on_game_mouse_exited() -> void:
	tween_label(false)


func _on_game_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_mask == MOUSE_BUTTON_LEFT:
				print("OPEN")
				OS.shell_open(app_path)
			if event.button_mask == MOUSE_BUTTON_RIGHT:
				if display_only:
					return
				right_click.position = event.global_position - Vector2(10.0, 10.0)
				right_click.show()


func _on_right_click_mouse_exited() -> void:
	right_click.hide()


func _on_right_click_index_pressed(index: int) -> void:
	match index:
		0:
			edited.emit()
		1:
			description.show()
			description.textbox.text = description.text
		2:
			moved.emit(true)
		3:
			moved.emit(false)
		4:
			queue_free()




