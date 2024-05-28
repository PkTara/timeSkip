extends Node

class_name Block

func leftClick(signals):
	pass
func rightClick(signals):
	signals["place"].emit("wood")
