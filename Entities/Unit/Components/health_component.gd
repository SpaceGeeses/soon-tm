extends Node
class_name HealthComponent

@export var stats: UnitStats
var current_health: int

signal health_changed(new_health: int)

func _ready() -> void:
	current_health = stats.health

func apply_damage(damage: int) -> void:
	current_health = max(current_health - damage, 0)
	emit_signal("health_changed", current_health)
