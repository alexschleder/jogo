extends Pawn

#warning-ignore:unused_class_variable
var lost = false
onready var parent = get_parent()
var canMove = true
var root_node

func _ready():
	update_look_direction(Vector2.RIGHT)
	root_node = get_node("/root/Game")
	root_node.connect("object_resolved", self, "on_object_resolve")

func _process(_delta):
	if !canMove:
		return
	var input_direction = get_input_direction()
	if not input_direction:
		return
	update_look_direction(input_direction)

	var target_position = parent.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
		$Tween.start()
	else:
		bump()


func get_input_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)


func update_look_direction(direction):
	#$Pivot/Sprite.rotation = direction.angle()
	pass


func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")
	#var move_direction = (position - target_position).normalized()
	#$Tween.interpolate_property($Pivot, "position", move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Pivot/Sprite.position = position - target_position
	position = target_position

	$MoveAudio.playing = true
	yield($AnimationPlayer, "animation_finished")
	set_process(true)


func bump():
	$BumpAudio.play()
	$AnimationPlayer.play("bump")

func on_object_resolve():
	canMove = true
