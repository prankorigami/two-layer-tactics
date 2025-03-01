extends Node
# the unit types a player can use
@onready var type_test_unit = preload("res://src/scenes/units/test_unit.tscn")
@onready var game_board = get_tree().root.get_node("Level")

# dictate who's turn it is, true if p1, false if p2
var current_player = true
var selected_unit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# ORDER OF OPERATIONS
	# TODO: STEP 1: LET PLAYERS TAKE TURNS SELECTING UNIT TYPES AND PLACING THEM ON THE BOARD
	var test_unit_1 = type_test_unit.instantiate()
	add_child(test_unit_1)
	test_unit_1.connect("unit_moved", game_board._on_move_unit)
	test_unit_1.set_location(1, 0, 8)
	
	var test_unit_2 = type_test_unit.instantiate()
	add_child(test_unit_2)
	test_unit_2.connect("unit_moved", game_board._on_move_unit)
	test_unit_2.set_location(7, 0, 2)
	
	# STEP 2 TAKE TURNS LETTING PLAYERS HAVE ROUNDS
	# DONT DO THIS IN THE READY FUNCTION LOL
