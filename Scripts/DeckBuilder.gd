extends Control


@onready var deckGrid: GridContainer = $DeckGrid
@onready var inventory: Control = $Inventory
var deckCards: Dictionary = {}
@onready var sell_random_card: Button = $SellRandomCard
@export var playerResource : PlayerResource
@onready var goldText: Label = $GoldText


func _ready():
	goldText.text = "Player Gold:" + str(playerResource.gold)


func _process(delta: float) -> void:
	goldText.text = "Player Gold:" + str(playerResource.gold)


func _on_card_clicked(card_resource: CardResource):
	print("Card clicked: " + card_resource.name)


func OnBackButtonPressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func PickRandomCard() -> CardResource:
	var availableCards = []
	for card in inventory.inventoryCardsResources:
		if card.inventoryCount > 0:
			availableCards.append(card)
	if availableCards.size() > 0:
		return availableCards[randi() % availableCards.size()]
	return null


func OnSellRandomCardPressed() -> void:
	SellRandomCard(1)
	inventory.InventoryView()

func SellRandomCard(numCards):
	var sellCard: Dictionary = {}
	for i in range(numCards):
		var cardResource = PickRandomCard()
		if cardResource:
			cardResource.shopStock += 1
			cardResource.inventoryCount -= 1
			playerResource.gold += 10
			
			if sellCard.has(cardResource.name):
				sellCard[cardResource.name] += 1
			else:
				sellCard[cardResource.name] = 1
	
	if sellCard.size() > 0:
		print("You sold: ")
		for name in sellCard.keys():
			print("%s x%d" % [name, sellCard[name]])
	else:
		print("Your Inventory in empty... Try to buy card from Shop")
	
	for cardSlot in inventory.inventoryGrid.get_children():
		for card in cardSlot.get_children():
			if card.has_method("updateCard") and card.cardResource != null:
				card.updateCard(false)
