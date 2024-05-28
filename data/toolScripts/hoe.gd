extends Node

class_name ToolHoe

func leftClick(signals):
	signals["destroy"].emit("herb")
func rightClick(signals):
	signals["place"].emit("soil")
