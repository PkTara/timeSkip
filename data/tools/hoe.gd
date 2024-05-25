extends Node

class_name Hoe
@export var item:Item

func leftClick():
	print("leftClick")
	$Map.on_player_place("soil")
