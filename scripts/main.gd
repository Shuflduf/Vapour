extends HSplitContainer

@export var new_game: PackedScene
@export var game_entry: PackedScene
@onready var games: VBoxContainer = %Games

func _ready() -> void:
	load_games()

func _on_new_game_pressed() -> void:
	var new_entry = new_game.instantiate()
	add_child(new_entry)
	new_entry.added_game.connect(add_game)

func add_game(new_entry: GameEntry):
	new_entry.reparent(games)
	save_games()

func save_games():
	var save_file = FileAccess.open("user://games.json", FileAccess.WRITE)
	for game in games.get_children():
		if !game is GameEntry:
			return
		var game_data = game.save_dict()
		save_file.store_line(JSON.stringify(game_data))

func load_games():
	for game in games.get_children():
		game.queue_free()

	var save_file = FileAccess.open("user://games.json", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(),\
					 " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = game_entry.instantiate()



		for i in node_data.keys():
			if i == "border_colour":
				new_object.set(i, str_to_var(node_data[i]))
			else:
				new_object.set(i, node_data[i])

		games.add_child(new_object, true)

		# Now we set the remaining variables.

