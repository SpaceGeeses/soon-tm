extends ProgressBar

@export var health_component: HealthComponent

func _ready() -> void:
	if health_component:
		health_component.connect("health_changed", on_health_changed)
		print('changing health to', health_component.current_health)
		value = health_component.current_health
		print(value)

func on_health_changed(new_health: int) -> void:
	value = new_health
