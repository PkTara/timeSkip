extends TileMap


class Tiles:
	var layer:int
	var sourceID:int
	var atlas:Vector2i
	
	var list = {}
	func _init(layeri, sourceIDi, atlasi, name):
		layer = layeri
		sourceID = sourceIDi
		atlas = atlasi
		list[name] = self

var soil = Tiles.new(3, 2, Vector2i(0,0), "soil")
var wood = Tiles.new(1, 0, Vector2i(13,1), "wood")
var grass = Tiles.new(1, 0, Vector2i(4, 1), "grass")
var sea = Tiles.new(0, 0, Vector2i(1,1), "sea")

var can_place_wood_custom_data = "can_place_dirt"
var tiles = {
	"soil": soil,
	"wood": wood,
	"grass" : grass,
	"sea" : sea
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
	if tile == "grass":
		var atlas = Vector2i(-1, -1)
		if get_cell_atlas_coords(3, coord) in destroyable:
			set_cell(3, coord, 2, atlas)
	
