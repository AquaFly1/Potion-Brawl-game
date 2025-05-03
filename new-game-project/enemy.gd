extends Control

class_name enemy

@export var max_health: int = 10
var health = 0

@export var potions: Array[Potion]

@onready var health_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health

func _process(delta: float) -> void:
	health_bar.value = health

func play():
	var pot = potions.pick_random()
	var damage = 0
	for ingredient in pot:
		damage += ingredient.damage
