extends Sprite2D


@export var cardResource : CardResource
@onready var cardNameText: Label = $CardFront/CardName/CardNameText
@onready var cardAliasText: Label = $CardFront/CardImage/CardAliasText
@onready var cardAttackText: Label = $CardFront/CardAttack/CardAttackText
@onready var cardCountText: Label = $CardFront/CardCountText



func updateCard(inShop: bool = true):
	if cardResource:
		cardNameText.text = cardResource.name
		cardAliasText.text = cardResource.name[0]
		cardAttackText.text = "Att: " + str(cardResource.attack)
		if inShop:
			cardCountText.text = str(cardResource.shopStock)
		else:
			cardCountText.text = str(cardResource.inventoryCount)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print(cardResource.name)
