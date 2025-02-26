extends Node3D
@onready var testTile: PackedScene =  preload("res://src/scenes/levels/tiles/test_tile.tscn")
@onready var testAirTile: PackedScene =  preload("res://src/scenes/levels/tiles/test_air_tile.tscn")
var groundGrid = []
var airGrid = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO replace this with how we instantiate level data, for now
	# it spawns in an empty 10x10 grid of test tiles
	for i in range(10):
		groundGrid.append([])
		airGrid.append([])
		for j in range(10):
			groundGrid[i].append(0)
			airGrid[i].append(0)
			# spawn a tile at the current location on the ground
			var currTile = testTile.instantiate()
			add_child(currTile)
			currTile.translate(Vector3(i, 0, j))
			await get_tree().create_timer(0.001).timeout
			# spawn a tile at the current location in the air
			#currTile = testAirTile.instantiate()
			#add_child(currTile)
			#currTile.translate(Vector3(i, 2, j))
	
	# TODO replace with actually instantiating a new grid of the correct tiles
	# based on how we want to represent different tile types later on
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
