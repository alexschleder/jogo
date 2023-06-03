extends TileMap

enum CellType { FLOOR = 0, ACTOR = 1, OBSTACLE = 3, OBJECT = 4}
export(NodePath) var dialogue_ui
var object_interaction_background_panel
var canvas_layer
var root_node

func _ready():
	for child in get_children():
		if child is Pawn:
			set_cellv(world_to_map(child.position), child.type)
	object_interaction_background_panel = get_node("ColorRect")
	canvas_layer = get_node("/root/Game/CanvasLayer")
	root_node = get_node("/root/Game")
	root_node.connect("before_object_resolve", self, "on_before_object_resolve")
	

func get_cell_pawn(cell, type = CellType.ACTOR):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1, CellType.FLOOR:
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, CellType.FLOOR)
			return map_to_world(cell_target) + cell_size / 2
		CellType.OBJECT, CellType.ACTOR:
			$Player.canMove = false
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print (cell_target)
			print("Cell %s contains %s" % [cell_target, target_pawn.name])
			canvas_layer.instantiate_object_interaction_scene(target_pawn.ObjectInteractionScene)
			root_node.current_object = target_pawn

func on_before_object_resolve(object):
	set_cellv(world_to_map(object.position), CellType.FLOOR)
