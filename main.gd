extends HSplitContainer


@export var new_game: PackedScene
@onready var games: VBoxContainer = %Games

func _on_new_game_pressed() -> void:
	var new_entry = new_game.instantiate()
	add_child(new_entry)
	new_entry.added_game.connect(add_game)

func add_game(new_entry: GameEntry):
	new_entry.reparent(games)
	#games.add_child(new_entry)
