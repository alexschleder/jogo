extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var maxHeart = 1
export (PackedScene) var BombSpriteScene
var bombs = []
var bomb_quantity = 0
signal bomb_used

func _input(event):
	if event.is_action_pressed("bomb"):
		use_bomb()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(maxHeart):
		instantiate_bomb()
	var grid = get_node("/root/Game/Exploration/Grid")
	print(grid.get_name())
	connect("bomb_used", grid, "on_bomb_used")
	pass
	
func use_bomb():
	print ("use bomb")
	if (bomb_quantity <= 0):
		return
	destroy_bomb()
	emit_signal("bomb_used")

func instantiate_bomb():
	var instance = BombSpriteScene.instance()
	add_child(instance)
	bombs.append(instance)
	bomb_quantity += 1
	pass
	
func destroy_bomb():
	print ("bomb quantity:", bomb_quantity)
	bombs[bomb_quantity-1].queue_free()
	bombs.erase(bombs[bomb_quantity-1])
	bomb_quantity-= 1
	pass
	
func change_bomb(quantity):
	print("Change bomb by", quantity)
	if (quantity == 0):
		return
	if (quantity > 0):
		for n in quantity:
			instantiate_bomb()
	else:
		for n in range(0, quantity, -1):
			if (bomb_quantity == 0):
				return
			destroy_bomb()
	pass
