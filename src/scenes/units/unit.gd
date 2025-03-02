extends Node3D
class_name Unit
@onready var attack_class = load("res://src/attacks/attack.gd")

signal unit_moved(newpos)

# the health of the unit
var health
# the list of attacks a unit can use (should usually just be 2)
var attackList
# the team the unit is on (0 or 1 lol)
var team

func set_location(oldpos, new_x, new_y, new_z):
	position.x = new_x
	position.y = 1.5 if new_y == 1 else 0
	position.z = new_z
	unit_moved.emit(self, oldpos, new_y * 100 + position.x * 10 + position.z)
