extends Button


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var DiceAnimatedSprite : AnimatedSprite

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
	return GetDiceValue()

func can_drop_data(_pos, data):
	print('candrop')
	return typeof(data) == TYPE_INT

func drop_data(_pos, data):
	print('drop data')
	DiceAnimatedSprite.frame = data
	ChangeIcon()
