extends Control


@export var playerResource : PlayerResource
@onready var shopGrid: GridContainer = $ShopGrid
var shopCards: Array = []
var shopCardsResources: Array = []
@onready var goldText: Label = $GoldText


func _ready():
	ShopArray()
	goldText.text = "Player Gold:" + str(playerResource.gold)


func _process(delta: float) -> void:
	goldText.text = "Player Gold:" + str(playerResource.gold)


func ShopArray():
	for cardSlot in shopGrid.get_children():
		for card in cardSlot.get_children():
			if card.has_method("updateCard") and card.cardResource != null:
				card.updateCard(true)
				shopCards.append(card)
				shopCardsResources.append(card.cardResource)
	print("Shop cards array size:", shopCards.size())
	print("Card resources array size:", shopCardsResources.size())


func OnDrawGachaButtonPressed():
	DrawGacha(10)


func DrawGacha(numCards):
	var drawnCards: Dictionary = {}
	if playerResource.gold >= 10 * numCards:
		for i in range(numCards):
			var cardResource = PickRandomCard()
			if cardResource:
				cardResource.shopStock -= 1
				cardResource.inventoryCount += 1
				playerResource.gold -= 10
				
				if drawnCards.has(cardResource.name):
					drawnCards[cardResource.name] += 1
				else:
					drawnCards[cardResource.name] = 1
	
	if drawnCards.size() > 0:
		print("You got: ")
		for name in drawnCards.keys():
			print("%s x%d" % [name, drawnCards[name]])
	else:
		print("This Shop is run out of card... Check your Inventory")
	
	for cardSlot in shopGrid.get_children():
		for card in cardSlot.get_children():
			if card.has_method("updateCard") and card.cardResource != null:
				card.updateCard(true)


func PickRandomCard() -> CardResource:
	var availableCards = []
	for card in shopCardsResources:
		if card.shopStock > 0:
			availableCards.append(card)
	if availableCards.size() > 0:
		return availableCards[randi() % availableCards.size()]
	return null


func OnBackButtonPressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
