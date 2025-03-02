extends Unit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 5
	attackList = [attack_class.new("Forward Shot", 1, 2, [Vector3(1, 0, 0), Vector3(2, 0, 0), Vector3(3, 0, 0), Vector3(-1, 0, 0), Vector3(-2, 0, 0), Vector3(-3, 0, 0), Vector3(0, 0, 1), Vector3(0, 0, 2), Vector3(0, 0, 3), Vector3(0, 0, -1), Vector3(0, 0, -2), Vector3(0, 0, -3)]), attack_class.new("Upward Grenade", 2, 3, [Vector3(0, 1, 0)])]
