extends Control

@export var full_deck: Array[Ingredient]

@onready var card_path: Path2D = $Path2D

var hs = preload("res://scripts/Ingredients/Heartstone.tres")
var sr = preload("res://scripts/Ingredients/SparkRock.tres")
signal card_released(card: CardBase)

func _ready() -> void:
	full_deck = [hs, hs, hs, sr, sr]

func shuffle_deck(deck) -> Array[Ingredient]:
	deck = full_deck
	var shuffled_deck = deck
	return shuffled_deck

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_view_deck_pressed() -> void:
	for i in range(full_deck.size()):
		var path_follow = PathFollow2D
		var card = path_follow.instantiate()
		card.add_child(full_deck[i])
		card_path.add_child(card)
		var lenght = 1/card_path.get_child_count()
		for child in card_path.get_children():
			child.progress_ratio = lenght * (child.get_index() +1)
			
func wait(sec: float):
	await get_tree().create_timer(sec).timeout
	return
