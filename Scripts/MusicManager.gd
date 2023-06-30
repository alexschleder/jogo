extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$DefaultMusic.playing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Game_change_map():
	return
	$DefaultMusic.playing = false
	$BossMusic.playing = true
	pass # Replace with function body.
