extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal bomb_explosion(instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	emit_signal("bomb_explosion", self)
	pass # Replace with function body.
