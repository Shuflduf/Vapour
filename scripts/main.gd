extends Control

@export var new_game: PackedScene
@export var game_entry: PackedScene
@onready var games: VBoxContainer = %Games
@onready var backround_colour: Panel = $BackroundColour
@onready var current_description: RichTextLabel = $CurrentDescription

func reset_main():
	if games.get_child_count() > 0:
		change_backround_colour(0)
		set_description(0)

func _ready() -> void:
	load_games()
	await get_tree().process_frame
	reset_main()

func _on_new_game_pressed() -> void:
	var new_entry = new_game.instantiate()
	add_child(new_entry)
	new_entry.added_game.connect(add_game)


func add_game(new_entry: GameEntry):
	new_entry.reparent(games)
	save_games()
	connect_all_children()


func edit_game(new_entry: GameEntry, index):
	games.get_child(index).free()
	new_entry.reparent(games)
	games.move_child(games.get_child(-1), index)
	save_games()
	connect_all_children()
	#games.get_child(index) = new_entry

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

	await get_tree().process_frame

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
			elif i == "description:text":
				continue
			else:
				new_object.set(i, node_data[i])

		games.add_child(new_object, true)

		new_object.description.text = node_data["description:text"]

	call_deferred("connect_all_children")

func change_backround_colour(new_colour_index: int):
	if games.get_child_count() - 1 < new_colour_index:
		return
	if games.get_child(new_colour_index) == null:
		return
	if get_tree() == null:
		return


	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(backround_colour, "modulate"\
			, games.get_child(new_colour_index).border_colour, 0.3)

func set_description(index: int):
	if games.get_child(index).description.text:
		current_description.text = games.get_child(index).description.text


func connect_all_children():
	for i in games.get_children().size():

		if !games.get_children()[i].get_signal_connection_list("tree_exited"):
			games.get_children()[i].tree_exited.connect(func():

				save_games()
				reset_main()
				connect_all_children())

		if !games.get_children()[i].get_signal_connection_list("description_edited"):
			games.get_children()[i].description_edited.connect(save_games)

		if games.get_children()[i].get_signal_connection_list("hovered"):
			games.get_children()[i].disconnect("hovered", hovered)
		games.get_children()[i].hovered.connect(hovered.bind(i))

		games.get_children()[i].edited.connect(func():
			var new_entry = new_game.instantiate()
			add_child(new_entry)
			new_entry.title = "Edit Game"
			new_entry.game.queue_free()
			new_entry.h_box.add_child(games.get_children()[i].duplicate(), true)
			new_entry.game = new_entry.h_box.get_child(-1)
			new_entry.game.size_flags_horizontal = SIZE_SHRINK_BEGIN
			new_entry.game.size_flags_horizontal = SIZE_EXPAND
			new_entry.game.size_flags_vertical = SIZE_SHRINK_CENTER
			new_entry.update_from_game()
			new_entry.added_game.connect(func(g: GameEntry):
				edit_game(g, i)))

func hovered(i: int):
	set_description(i)
	change_backround_colour(i)
