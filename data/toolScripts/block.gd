extends Node

class_name Block

func leftClick(signals):
	print("Wood left")
func rightClick(signals):
	signals["place"].emit("wood")
	print("woodRight")
