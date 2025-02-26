extends Node3D
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
	
	# TODO replace with actually instantiating a new grid of the correct tiles
	# based on how we want to represent different tile types later on
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
