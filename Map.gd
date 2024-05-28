extends TileMap

signal removedTile(tile)

class Tiles:
	var layer:int
	var sourceID:int
	var atlas:Vector2i
	var drops:String
	
	func _init(layeri:int, sourceIDi:int, atlasi:Vector2i, name:String, dropsi=""):
		layer = layeri
		sourceID = sourceIDi
		atlas = atlasi
		drops = dropsi


#var soil = Tiles.new(3, 2, Vector2i(0,0), "soil")
#var wood = Tiles.new(1, 0, Vector2i(13,1), "wood")
#var grass = Tiles.new(1, 0, Vector2i(4, 1), "grass")
#var sea = Tiles.new(0, 0, Vector2i(1,1), "sea")

var can_place_wood_custom_data = "can_place_dirt"
var tiles = {
	"soil": Tiles.new(3, 2, Vector2i(0,0), "soil"),
	"wood": Tiles.new(1, 0, Vector2i(13,1), "wood"),
	"grass" : Tiles.new(1, 0, Vector2i(4, 1), "grass"),
	"sea" : Tiles.new(0, 0, Vector2i(1,1), "sea"),
	"tree" : Tiles.new(4, 3, Vector2i(0,0), "tree", "res://data/tools/wood.tres"),
	"herb" : Tiles.new(3, 3, Vector2i(2, 0), "herb")
}

var dirtCells = []
var woodCells = []
var destroyable = [Vector2i(2,0), Vector2i(0,0)]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
	


func _on_player_place(tile):
	var coord = local_to_map(get_local_mouse_position())
	if tile == "soil":
		var tileObj = ["soil"]
		
		
		if get_cell_atlas_coords(1, coord) == tiles["grass"].atlas and get_cell_atlas_coords(3, coord) == Vector2i(-1, -1) and get_cell_atlas_coords(4, coord) == Vector2i(-1, -1):
			dirtCells.append(coord)
			set_cells_terrain_connect(3, dirtCells, 0, 3)
			#set_cell(tileObj.layer, coord, tileObj.sourceID, tileObj.atlas)
			

	if tile == "wood":
		var tileObj = tiles["wood"]
		
		
		if get_cell_atlas_coords(0, coord) == tiles["sea"].atlas and get_cell_atlas_coords(3, coord) == Vector2i(-1, -1) and get_cell_atlas_coords(4, coord) == Vector2i(-1, -1):
			woodCells.append(coord)
			set_cells_terrain_connect(1, woodCells, 1, 0)
			#set_cell(tileObj.layer, coord, tileObj.sourceID, tileObj.atlas)

func _on_player_destory(tile):
	var coord = local_to_map(get_local_mouse_position())
	var atlasRemove = Vector2i(-1, -1)
	
	if tiles[tile]:
		if get_cell_atlas_coords(tiles[tile].layer, coord) == tiles[tile].atlas:
			set_cell(tiles[tile].layer, coord, tiles[tile].sourceID, atlasRemove)
			if tiles[tile].drops:
				removedTile.emit(load(tiles[tile].drops))
			

	
