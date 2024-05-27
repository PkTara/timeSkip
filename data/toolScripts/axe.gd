extends Node


class Tool extends Node:
	func leftClick(singals:Object):
		pass
	func rightClick(signals:Object):
		pass
		

class ToolHoe extends Tool:
	func leftClick(signals):
		signals["destroy"].emit("grass")
	func rightClick(signals):
		signals["place"].emit("soil")

		
class ToolWood extends Tool:
	func leftClick(signals):
		print("Wood left")
	func rightClick(signals):
		signals["place"].emit("wood")
		print("woodRight")
