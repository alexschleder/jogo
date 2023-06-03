extends Node


const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

export(NodePath) var exploration_screen
var heart_container

func _ready():
	exploration_screen = get_node(exploration_screen)
	for n in $Exploration/Grid.get_children():
		if !(n is Pawn):
			continue
		if not n.type == n.CellType.ACTOR:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"_on_opponent_dialogue_finished", [n])
	heart_container = $"CanvasLayer/Heart Container"
	heart_container.connect("game_over_zero_hearts", self, "on_game_over_zero_hearts")

func on_open_chest(life_value):
	print("On open chest")
	heart_container.change_heart(life_value)
	pass
	
func on_game_over_zero_hearts():
	print("GAME OVER - ZERO HEARTS")
	pass
	
