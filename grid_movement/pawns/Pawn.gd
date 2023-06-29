class_name Pawn
extends Node2D

enum CellType { ACTOR = 0, OBSTACLE = 3, OBJECT = 4 }
#warning-ignore:unused_class_variable
export(CellType) var type = CellType.ACTOR

var active = true setget set_active
export (PackedScene) var ObjectInteractionScene
export (bool) var is_toggle = false
signal linked_object_resolve
signal toggle_object

func _ready():
	connect("toggle_object", get_parent(), "on_toggle_object")

func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)
	
func on_before_object_resolve():
	emit_signal("linked_object_resolve")
	
func on_linked_object_resolve():
	if(is_toggle):
		emit_signal("toggle_object", self)
