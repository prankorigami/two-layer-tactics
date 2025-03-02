extends Control

func fill_information(unit):
	%Move.text = str(unit.position.x) + ", " + str(unit.position.y) + ", " + str(unit.position.z)
