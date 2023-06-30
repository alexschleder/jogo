extends TileMap

enum CellType { FLOOR = 0, ACTOR = 5, OBSTACLE = 3, OBJECT = 4}
export(NodePath) var dialogue_ui
export (PackedScene) var BombItemScene
export (PackedScene) var MonsterScene
var object_interaction_background_panel
var canvas_layer
var root_node
var bomb_audio
var directions = []
export (bool) var needs_monster = true
signal map_change

func _ready():
	for child in get_children():
		if child is Pawn:
			set_cellv(world_to_map(child.position), child.type)
	object_interaction_background_panel = get_node("ColorRect")
	canvas_layer = get_node("/root/Game/CanvasLayer")
	root_node = get_node("/root/Game")
	root_node.connect("before_object_resolve", self, "on_before_object_resolve")
	bomb_audio = $BombAudio
	
func on_bomb_used():
	use_bomb()
	
func is_monster_dead():
	var node = $Monster
	if (node == null):
		return true
	return false

func get_cell_pawn(cell, type = CellType.ACTOR):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)

func use_bomb():
	var instance = BombItemScene.instance()
	instance.position = $Player.position
	add_child(instance)
	instance.connect("bomb_explosion", self, "on_bomb_explosion")

func on_bomb_explosion(bomb):
	for x in range(-1, 2):
		for y in range (-1, 2):
			var direction = Vector2(x, y)
			var cell_start = world_to_map(bomb.position)
			var cell_target = cell_start + direction 
			var cell_tile_id = get_cellv(cell_target)
			if (cell_tile_id == CellType.OBSTACLE):
				set_cellv(cell_target, CellType.FLOOR)
	bomb_audio.playing = true
	bomb.queue_free()

func spawn_monster(monster_position):
	var cell = world_to_map(monster_position)
	var instance = MonsterScene.instance()
	add_child(instance)
	instance.position = monster_position
	set_cellv(cell, CellType.OBJECT)

func on_toggle_object(object):
	var cell = world_to_map(object.position)
	var cell_tile_id = get_cellv(cell)
	if (cell_tile_id == CellType.FLOOR):
		set_cellv(cell, CellType.OBJECT)
	else:
		set_cellv(cell, CellType.FLOOR)

func stop_movement():
	var player = $Player
	var monster = $Monster
	
	player.canMove = false
	if(monster != null):
		monster.canMove = false

func request_move(pawn, direction):
	var monster_spawn_position = pawn.position
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1, CellType.FLOOR:
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, CellType.FLOOR)
			directions.append(direction)
			if (is_monster_dead()) and needs_monster:
				spawn_monster(monster_spawn_position)
			return map_to_world(cell_target) + cell_size / 2
		CellType.OBJECT, CellType.ACTOR:
			stop_movement()
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print (cell_target)
			print("Cell %s contains %s" % [cell_target, target_pawn.name])
			canvas_layer.instantiate_object_interaction_scene(target_pawn.ObjectInteractionScene)
			root_node.current_object = target_pawn
			
func request_monster_move(pawn):
	if (directions.size() == 0):
		return
	var cell_start = world_to_map(pawn.position)
	var direction = directions[0]
	var cell_target = cell_start + direction
	print(directions)
	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1, CellType.FLOOR:
			set_cellv(cell_target, CellType.OBJECT)
			set_cellv(cell_start, CellType.FLOOR)
			directions.remove(0)
			return map_to_world(cell_target) + cell_size / 2
		CellType.ACTOR:
			stop_movement()
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print (cell_target)
			print("Cell %s contains %s" % [cell_target, target_pawn.name])
			canvas_layer.instantiate_object_interaction_scene(pawn.ObjectInteractionScene)
			root_node.current_object = pawn

func on_map_change():
	directions = []
	emit_signal("map_change")

func on_before_object_resolve(object):
	object.on_before_object_resolve()
	set_cellv(world_to_map(object.position), CellType.FLOOR)
