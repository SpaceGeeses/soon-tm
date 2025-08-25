extends CharacterBody2D

@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@onready var ability_controller = $AbilityController

func _physics_process(delta: float) -> void:
	velocity = movement_component.get_velocity(self)
	move_and_slide()
