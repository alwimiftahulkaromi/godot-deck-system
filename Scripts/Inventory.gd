extends Control


@onready var inventoryGrid: GridContainer = $InventoryGrid
var inventoryCards: Array = []
var inventoryCardsResources: Array = []


func _ready():
	InventoryArray()
	InventoryView()


func InventoryArray():
	for cardSlot in inventoryGrid.get_children():
		for card in cardSlot.get_children():
			if card.has_method("updateCard") and card.cardResource != null:
				card.updateCard(false)
				inventoryCards.append(card)
				inventoryCardsResources.append(card.cardResource)
	print("Shop cards array size:", inventoryCards.size())
	print("Card resources array size:", inventoryCardsResources.size())


func InventoryView():
	for cardSlot in inventoryGrid.get_children():
		for card in cardSlot.get_children():
			if card.has_method("updateCard") and card.cardResource != null:
				if card.cardResource.inventoryCount == 0:
					cardSlot.visible = false
