extends Node
# the unit types a player can use
@onready var type_tank = preload("res://src/scenes/units/tank.tscn")
@onready var game_board = get_tree().root.get_node("Level")

# dictate who's turn it is, true if p1, false if p2
var current_player = true
var selected_unit
var current_energy = 10
var energy_per_turn = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SelectionSquare.connect("select_unit", _on_unit_selection)
	%SelectionSquare.connect("move_unit", _on_move_unit)
	%Back.connect("deselect", _on_deselect)
	
	# ORDER OF OPERATIONS
	# TODO: STEP 1: LET PLAYERS TAKE TURNS SELECTING UNIT TYPES AND PLACING THEM ON THE BOARD
	var test_unit_1 = type_tank.instantiate()
	add_child(test_unit_1)
	test_unit_1.connect("unit_moved", game_board._on_move_unit)
	test_unit_1.set_location(1, 1, 8)
	test_unit_1.team = true
	
	var test_unit_2 = type_tank.instantiate()
	add_child(test_unit_2)
	test_unit_2.connect("unit_moved", game_board._on_move_unit)
	test_unit_2.set_location(7, 0, 2)
	test_unit_2.team = false
	
	%EnergyLabel.text = "Energy left: " + str(current_energy)

func _on_unit_selection(position):
	selected_unit = game_board.get_board_pos(position)
	# activate the ui with information on this unit
	%OptionsUI.fill_information(selected_unit)
	%OptionsUI.visible = true
	
func _on_deselect():
	selected_unit = null
	%OptionsUI.visible = false
	
func _on_move_unit(position):
	valid_move(selected_unit, position)
	
# fuck doing actual path tracing ima just let you phase through mfers
func valid_move(unit, newpos):		
	if not unit.team == current_player:
		return false
	
	# make sure movement stays on same layer
	if not (newpos > 100) == (unit.position.y > 1):
		return false
	
	print(newpos)
	newpos = int(newpos)
	var new_y = 0 if newpos < 100 else 1
	var newpos_no_y = newpos - (100 if newpos > 100 else 0)
	var new_x = newpos_no_y / 10
	var new_z = newpos_no_y % 10
	
	# pathfind minimum distance to position with bfs
	# FUUUUUUUUUUUUUUUUUUUUUUUUUCK
	var oldpos = unit.position.x * 10 + unit.position.z + (1 if unit.position.y > 1 else 0) * 100
	var dist = -1
	var queue = [oldpos]
	var explored = [oldpos]
	var path = [[-1, oldpos]]
	
	
	while(len(queue) > 0):
		var current = queue.pop_front()
		
		# check the 4 adjacent edges
		if((not int(current) % 100 <= 9) and current - 10 >= 0 and (current - 10) not in explored and not game_board.has_board_pos(current - 10)):
			explored.append(current - 10)
			queue.append(current - 10)
			path.append([current, current - 10])
			if (current - 10) == newpos:
				break

		if((not int(current) % 100 >= 90) and current + 10 <= 199 and (current + 10) not in explored and not game_board.has_board_pos(current + 10)):
			explored.append(current + 10)
			queue.append(current + 10)
			path.append([current, current + 10])
			if (current + 10) == newpos:
				break

		if((not int(current) % 10 == 0) and current - 1 >= 0 and (current - 1) not in explored and not game_board.has_board_pos(current - 1)):
			explored.append(current - 1)
			queue.append(current - 1)
			path.append([current, current - 1])
			if (current - 1) == newpos:
				break

		if((not int(current) % 10 == 9) and current + 1 <= 199 and (current + 1) not in explored and not game_board.has_board_pos(current + 1)):
			explored.append(current + 1)
			queue.append(current + 1)
			path.append([current, current + 1])
			if (current + 1) == newpos:
				break
	
	var shortestPath = []
	for n in range(len(path) - 1, -1, -1):
		if path[n][1] == newpos:
			shortestPath.push_front(path[n])
			newpos = path[n][0]
			dist += 1
	
	if dist > current_energy:
		return false
	
	for n in range(1, len(shortestPath)):
		var old = int(shortestPath[n][0])
		var new = int(shortestPath[n][1])
		var deltaPos = Vector3((new / 10) - (old / 10), 0, (new % 10) - (old % 10))
		var tween = create_tween().set_parallel(true)
		tween.pause()
		tween.tween_property(unit, "position", deltaPos, 0.05).as_relative()
		tween.play()
		await get_tree().create_timer(0.05).timeout
	
	unit.set_location(new_x, new_y, new_z)
	current_energy -= dist
	check_turn()
	return true

func check_turn():
	if current_energy == 0:
		current_energy = energy_per_turn
		current_player = not current_player
		%TurnLabel.text = "Player 1's Turn" if current_player else "Player 2's Turn"
	%EnergyLabel.text = "Energy left: " + str(current_energy)
