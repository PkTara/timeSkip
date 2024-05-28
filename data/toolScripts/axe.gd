extends Node

func leftClick(signals):
	signals["destroy"].emit("tree")
	print("script works")
func rightClick(signals):
	pass

		
