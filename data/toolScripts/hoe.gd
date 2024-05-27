extends Node

class_name ToolHoe

func leftClick(signals):
	signals["destroy"].emit("grass")
func rightClick(signals):
	signals["place"].emit("soil")
