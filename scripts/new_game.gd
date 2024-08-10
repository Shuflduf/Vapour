extends Window

signal added_game(game: GameEntry)

@onready var image_file_dialog: FileDialog = %ImageFileDialog
@onready var path_file_dialog: FileDialog = %PathFileDialog

@onready var h_box: HBoxContainer = $MarginContainer/HBoxContainer

@onready var game: GameEntry = %Game

func update_from_game():
	%LineEdit.text = game.name
	%ColorPickerButton.color = game.border_colour

func _on_line_edit_text_changed(new_text: String) -> void:
	game.name = new_text
	game.label.text = new_text


func _on_line_edit_text_submitted(_new_text: String) -> void:
	%LineEdit.release_focus()


func _on_color_picker_button_color_changed(color: Color) -> void:
	game.border_colour = color


func _on_finish_pressed() -> void:
	added_game.emit(game)
	queue_free()


func _on_image_button_pressed() -> void:
	image_file_dialog.show()

func _on_image_file_dialog_file_selected(path: String) -> void:
	game.app_icon = path


func _on_path_button_pressed() -> void:
	path_file_dialog.show()


func _on_path_file_dialog_file_selected(path: String) -> void:
	print(path)
	game.app_path = path

func _on_close_requested() -> void:
	queue_free()
