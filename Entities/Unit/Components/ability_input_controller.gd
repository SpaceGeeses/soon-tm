extends Node
class_name AbilityInputController

@export var slots: Array[ActionSlot] = []
@export var ability_controller: AbilityController
@export var caster: Node2D

func _process(delta: float) -> void:
	for slot in slots:
		if slot.ability and Input.is_action_just_pressed(slot.input_action):
			ability_controller.request_cast(slot.ability, caster, null)
