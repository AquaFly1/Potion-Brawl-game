extends Control

var hand_size = 3
@export var hand: Array[Ingredient]
@onready var card_path: Path2D = $Path2D
@onready var discard: Button = $Discard
@onready var hand_cont: HBoxContainer = $HBoxContainer

var deck = []
var card = preload("res://scenes/card.tscn")
var discard_pile = []
var cards = []
var has_card = false
var mouse_on_discard = false
func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	Deck.card_released.connect(release_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(cards.size()):
		cards[i].target = get_card_pos(i)[0]
		cards[i].target_rotation = get_card_pos(i)[1]

func release_card(card: CardBase):
	if mouse_on_disc():
		discard_pile.append(card.ingredient)
		card.queue_free()
		hand.pop_at(0)
		draw_card(1)
		

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())
		load_cards(i)

func load_cards(pos):
	var card_image = card.instantiate()
	add_child(card_image)
	cards.append(card_image)
	card_image.load_card(hand[pos])
	card_image.target = get_card_pos(pos)[0]
	card_image.target_rotation = get_card_pos(pos)[1]


func get_card_pos(index):
	var x_offset = 420/hand.size()
	var x_pos = 365 + index*x_offset
	var y_pos = 0.001*(pow((x_pos-(365+x_offset)), 2)) + 500
	var rot = 2.6*(x_pos-(365+x_offset))
	return [Vector2(x_pos, y_pos), rot]

func mouse_on_disc():
	if get_global_mouse_position().x >= 825 and get_global_mouse_position().x <= 1095:
		if get_global_mouse_position().y >= 28 and get_global_mouse_position().y <= 147:
			return true
		else:
			return false
	else:
		return false
