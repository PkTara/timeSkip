extends TileMap

'''class Tiles:
	def __init__(self, layer, sourceID, age):
		layer = layer
		sourceID = sourceID
		atlas = atlas
var soil = Tiles(3, 2, Vector2i(0,0))'''

var destroyable = [Vector2i(2,0), Vector2i(0,0)]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_till_map():
	var coord = local_to_map(get_local_mouse_position())
	var atlas = Vector2i(0, 0)
	if get_cell_atlas_coords(1, coord) == Vector2i(4,1) and get_cell_atlas_coords(3, coord) == Vector2i(-1, -1):
		set_cell(3, coord, 2, atlas)
	
	


func _on_player_place(tile):
	var coord = local_to_map(get_local_mouse_position())
	if tile == "soil":
		var atlas = Vector2i(0, 0)
		if get_cell_atlas_coords(1, coord) == Vector2i(4,1) and get_cell_atlas_coords(3, coord) == Vector2i(-1, -1) and get_cell_atlas_coords(4, coord) == Vector2i(-1, -1):
			set_cell(3, coord, 2, atlas)


func _on_player_destory(tile):
	var coord = local_to_map(get_local_mouse_position())
	if tile == "grass":
		var atlas = Vector2i(-1, -1)
		print(get_cell_atlas_coords(3, coord))
		if get_cell_atlas_coords(3, coord) in destroyable:
			set_cell(3, coord, 2, atlas)
	
