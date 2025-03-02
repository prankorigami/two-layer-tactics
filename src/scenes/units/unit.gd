extends Node3D
class_name Unit

signal unit_moved(unit: Unit, oldpos, newpos)

# the health of the unit
var health
# the list of attacks a unit can use (should usually just be 2)
var attackList
# the team the unit is on (0 or 1 lol)
var team

func set_location(new_x, new_y, new_z):
	var oldpos = position.y * 100 + position.x * 10 + position.z
	position.x = new_x
	position.y = new_y
	position.z = new_z
	unit_moved.emit(self, oldpos, position.y * 100 + position.x * 10 + position.z)
