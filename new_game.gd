extends PopupPanel

signal added_game(game: GameEntry)

@onready var file_dialog: FileDialog = %FileDialog
@onready var game: Control = $MarginContainer/HBoxContainer/Game

func _on_button_pressed() -> void:
	file_dialog.show()


func _on_file_dialog_file_selected(path: String) -> void:
	game.app_icon = path


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
