extends Node3D
# game board is represented as a dictionary of all units/obstacles
# key is a 3 digit number = yxz
var board = {}
	
func _on_move_unit(unit, oldpos, newpos):
	board.erase(oldpos)
	board[newpos] = unit
