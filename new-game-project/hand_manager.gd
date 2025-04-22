extends Control

var hand_size = 3
@export var hand: Array[Ingredient]
@onready var card_path: Path2D = $Path2D

var deck = []
var card = preload("res://scenes/card.tscn")

func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	for i in range(hand.size()):
		print("a")
		var card_follow = PathFollow2D.new()
		var card_image = card.instantiate()
		card_path.add_child(card_follow)
		card_follow.add_child(card_image)
		card_image.load_card(hand[i])
		var lenght = 1/card_path.get_child_count()
		for child in card_path.get_children():
			print(child.get_index()+1)
			child.progress_ratio = lenght * (child.get_index() +1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_discard_pressed() -> void:
	
	print("discard")

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())
	print(hand)
