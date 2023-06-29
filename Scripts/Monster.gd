extends Pawn

#warning-ignore:unused_class_variable
var lost = false
export(bool) var needsMonster = true
onready var parent = get_parent()
var canMove = true
var root_node

func _ready():
	root_node = get_node("/root/Game")
	root_node.connect("object_resolved", self, "on_object_resolve")

func move_to(target_position):
	set_process(false)
	#$AnimationPlayer.play("walk")
	#var move_direction = (position - target_position).normalized()
	#$Tween.interpolate_property($Pivot, "position", move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#$Pivot/AnimatedSprite.position = position - target_position
	position = target_position

	$MoveAudio.playing = true
	yield($AnimationPlayer, "animation_finished")
	set_process(true)


func bump():
	$BumpAudio.play()
	$AnimationPlayer.play("bump")

func on_object_resolve():
	canMove = true

func _on_MoveCooldown_timeout():
	if !canMove:
		return
	var target_position = parent.request_monster_move(self)
	if target_position:
		move_to(target_position)
		$Tween.start()
	else:
		bump()
