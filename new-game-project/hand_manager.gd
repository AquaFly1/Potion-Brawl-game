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
var selected_card = null

func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	Deck.card_released.connect(release_card)
	Deck.card_select.connect(card_select)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(cards.size()):
		if is_instance_valid(cards[i]):
			cards[i].target = get_card_pos(i)

func release_card(card: CardBase):
	if mouse_on_discard:
		discard_pile.append(card.ingredient)
		hand.erase(card)
		card.queue_free()
		draw_card(1)
		
func card_select(card: CardBase):
	selected_card = card

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())
		load_cards(i)

func load_cards(pos):
	var card_image = card.instantiate()
	add_child(card_image)
	cards.append(card_image)
	card_image.load_card(hand[pos])


func get_card_pos(index):
	var x_offset = 420/hand.size()
	var x_pos = 365 + index*x_offset
	var y_pos = 0.001*(pow((x_pos-(365+x_offset)), 2)) + 500
	var rot = 2.6*(x_pos-(365+x_offset))
	return Vector2(x_pos, y_pos)


func _on_discard_mouse_entered() -> void:
	mouse_on_discard = true

func _on_discard_mouse_exited() -> void:
	#mouse_on_discard = false
	pass
