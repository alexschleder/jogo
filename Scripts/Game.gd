extends Node


const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

export(NodePath) var exploration_screen
var heart_container
var dice_container
var bomb_container
var current_object = null
signal object_resolved
signal before_object_resolve

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
	dice_container = $"CanvasLayer/Dice Container"
	bomb_container = $"CanvasLayer/Bomb Container"

func try_connect_signal(instance, signal_name):
	if (signal_name == "on_open_chest"):
		instance.connect("on_open_chest", self,"on_open_chest")
	elif (signal_name == "open_door"):
		instance.connect("open_door", self, "on_open_door" )
	elif(signal_name == "fountain_use"):
		instance.connect("fountain_use", self, "on_fountain_use" )
	elif(signal_name == "reroll_potion_use"):
		instance.connect("reroll_potion_use", self, "on_reroll_potion_use")
	elif(signal_name=="defeat_enemy"):
		instance.connect("defeat_enemy", self, "on_defeat_enemy")
	elif(signal_name=="ladder_use"):
		instance.connect("ladder_use", self, "on_ladder_use")
	elif(signal_name=="spikes_use"):
		instance.connect("spikes_use", self, "on_spikes_use")
	elif(signal_name=="lever_use"):
		instance.connect("lever_use", self, "on_lever_use")
	else:
		print("could not connect signal", signal_name, instance.get_name())

func on_open_chest(life_quantity):
	print("On open chest")
	heart_container.change_heart(life_quantity)
	bomb_container.change_bomb(1)
	$AudioManager.play_pickup()
	on_object_resolve()
	
func on_open_door(life_value):
	print("On open door")
	heart_container.change_heart(life_value)
	$AudioManager.play_resolve()
	on_object_resolve()
	
func on_fountain_use(life_value):
	print("On fountain use")
	heart_container.change_heart(life_value)
	$AudioManager.play_resolve()
	on_object_resolve()
	
func on_reroll_potion_use(dice_number):
	print("On reroll potion use")
	dice_container.reroll()
	$AudioManager.play_pickup()
	on_object_resolve()
	
func on_defeat_enemy(hp_lost):
	print("On defeat enemy")
	heart_container.change_heart(hp_lost)
	$AudioManager.play_defeat()
	on_object_resolve()
	
func on_ladder_use(life_value):
	print("On ladder use")
	game_over()
	
func on_spikes_use(hp_lost):
	print("On spikes use")
	heart_container.change_heart(hp_lost)
	$AudioManager.play_resolve()
	on_object_resolve()
		
func on_game_over_zero_hearts():
	print("GAME OVER - ZERO HEARTS")
	game_over()
	
func on_lever_use(life_value):
	print("On lever use")
	heart_container.change_heart(life_value)
	$AudioManager.play_resolve()
	on_object_resolve()
	
func on_object_resolve():
	connect("before_object_resolve", current_object, "on_before_object_resolve")
	print("object_resolved")
	emit_signal("before_object_resolve", current_object)
	if (current_object != null):
		current_object.queue_free()
		current_object = null
	emit_signal("object_resolved")

func _on_Button_pressed():
	emit_signal("object_resolved")
	pass # Replace with function body.

func game_over():
	$CanvasLayer/GameOver.visible = true
	$CanvasLayer/GameOverBackground.visible = true
