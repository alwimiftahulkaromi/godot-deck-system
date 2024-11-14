extends Control


var shopScene = preload("res://Scenes/Shop.tscn")


func OnDeckButtonPressed():
	get_tree().change_scene_to_file("res://Scenes/DeckBuilder.tscn")


func OnShopButtonPressed():
	get_tree().change_scene_to_file("res://Scenes/Shop.tscn")


func OnQuitButtonPressed():
	get_tree().quit()
