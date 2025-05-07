extends Control

var hand_size = 3
@export var hand: Array[Ingredient]
@onready var card_path: Path2D = $Path2D
@onready var discard: Button = $Discard
@onready var hand_cont: HBoxContainer = $HBoxContainer

var deck = []
var card = preload("res://scenes/card.tscn")
var discard_pile = []
var has_card = false
var mouse_on_discard = false
func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	Deck.card_released.connect(release_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func release_card(card: CardBase):
	if mouse_on_discard:
		discard_pile.append(card.ingredient)
		hand.pop_at(0)
		draw_card(1)
		

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())
		load_cards(hand[i], i)

func _on_discard_mouse_entered() -> void:
	mouse_on_discard = true

func _on_discard_mouse_exited() -> void:
#	mouse_on_discard = false
	pass

func load_cards(cards, pos):
#	var card_follow = PathFollow2D.new()
	var card_image = card.instantiate()
	hand_cont.add_child(card_image)
	card_image.load_card(hand[pos])
#	card_path.add_child(card_follow)
#	card_follow.add_child(card_image)
#	card_image.load_card(hand[pos])
#	card_follow.progress_ratio = float(pos)/float(hand.size() - 1)
#	card_image.target = card_follow.position
