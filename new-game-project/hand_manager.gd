extends Control

var hand_size = 3
@export var hand: Array[Ingredient]
@onready var card_path: Path2D = $Path2D
@onready var container: HBoxContainer = $HBoxContainer
@onready var discard: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var deck = []
var card = preload("res://scenes/card.tscn")

func _ready() -> void:
	deck = Deck.shuffle_deck(Deck.full_deck)
	draw_card(hand_size)
	for i in range(hand.size()):
		var card_image = card.instantiate()
		container.add_child(card_image)
		card_image.load_card(hand[i])
		
#	for i in range(hand.size()):
#		var card_follow = PathFollow2D.new()
#		var card_image = card.instantiate()
#		card_path.add_child(card_follow)
#		card_follow.add_child(card_image)
#		card_image.load_card(hand[i])
#		for child in card_path.get_children():
#			child.progress_ratio = (child.get_index()+1)/hand_size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if discard.has_overlapping_bodies():
		print("b")

func _on_discard_pressed() -> void:
	
	print("a")

func draw_card(x: int):
	for i in range(x):
		hand.append(deck.pop_front())


func _on_area_2d_body_entered(body: CardBase) -> void:
	print("discard")
	
