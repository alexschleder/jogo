extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var maxHeart = 3
export (PackedScene) var HeartSpriteScene
var hearts = []
var heart_quantity = 0
signal game_over_zero_hearts

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(maxHeart):
		instantiate_heart()
	pass
	
func instantiate_heart():
	var instance = HeartSpriteScene.instance()
	add_child(instance)
	hearts.append(instance)
	heart_quantity += 1
	pass
	
func destroy_heart():
	print ("heart quantity:", heart_quantity)
	hearts[heart_quantity-1].queue_free()
	heart_quantity-= 1
	check_game_over()
	pass
	
func change_heart(quantity):
	print("Change heart by", quantity)
	if (quantity == 0):
		return
	if (quantity > 0):
		for n in quantity:
			instantiate_heart()
	else:
		for n in range(0, quantity, -1):
			if (heart_quantity == 0):
				return
			destroy_heart()
	pass
	
	
func check_game_over():
	if (heart_quantity <= 0):
		emit_signal("game_over_zero_hearts")
		return true
