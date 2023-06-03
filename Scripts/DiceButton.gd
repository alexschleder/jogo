extends Button


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

enum dice_type {CHARACTER_DICE, OTHER}
export(dice_type) var type = dice_type.CHARACTER_DICE
var DiceAnimatedSprite : AnimatedSprite
var from_dice

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiceAnimatedSprite = $Dice
	pass # Replace with function body.
	
func ChangeIcon() -> void:
	icon = DiceAnimatedSprite.GetCurrentFrame()

func GetDiceValue() -> int:
	return DiceAnimatedSprite.frame

func get_drag_data(_pos):
	print('getdrag')
	set_drag_preview(self)
	return self

func can_drop_data(_pos, data):
	print('candrop')
	print(data.type)
	return data.type == dice_type.CHARACTER_DICE

func drop_data(_pos, data):
	if(type == dice_type.CHARACTER_DICE):
		return
	print('drop data')
	DiceAnimatedSprite.frame = data.GetDiceValue()
	from_dice = data
	ChangeIcon()

func on_before_object_resolve(object):
	print("dicebutton before object resolve")
	if type == dice_type.CHARACTER_DICE:
		return
	from_dice.queue_free()
	from_dice = null
	
