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
		card.queue_free()
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
	var card_image = card.instantiate()
	card_image.load_card(hand[pos])
	card_image.target = get_card_pos(pos)


func get_card_pos(index):
	var x_offset = 420/hand.size()+1
	var x_pos = 365 + index*x_offset
	var y_pos = -0.01*pow(x_pos, 2) + 1
	return Vector2(x_pos, y_pos)
