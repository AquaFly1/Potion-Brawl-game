extends Control

var hand_size = 3
@export var hand: Array[Ingredient]
@onready var card_path: Path2D = $Path2D
@onready var container: HBoxContainer = $HBoxContainer
@onready var discard: Area2D = $Area2D

var deck = []
var card = preload("res://scenes/card.tscn")
var has_card = false
var mouse_on_discard = false
func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	Deck.card_released.connect(release_card)
	for i in range(hand.size()):
		var card_follow = PathFollow2D.new()
		var card_image = card.instantiate()
		card_path.add_child(card_follow)
		card_follow.add_child(card_image)
		card_image.load_card(hand[i])
		card_follow.progress_ratio = float(i)/float(hand_size - 1)
		card_image.target = card_follow.position
#		card_image.rotation = card_follow.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func release_card(card: CardBase):
	if mouse_on_discard:
		print("discard")

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())

func _on_discard_mouse_entered() -> void:
	mouse_on_discard = true
	print("B")

func _on_discard_mouse_exited() -> void:
#	mouse_on_discard = false
	print("A")
