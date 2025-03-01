extends Node
# the unit types a player can use
@onready var type_test_unit = load("res://src/scenes/units/test_unit.tscn")
@onready var game_board = get_tree().root.get_node("Level")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var test_unit_1 = type_test_unit.instantiate()
	test_unit_1.connect(test_unit_1.unit_moved, game_board._on_move_unit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
