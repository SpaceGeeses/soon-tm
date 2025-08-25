extends Control

@export var cooldown: PackedScene
@export var controller: AbilityController
@export var ability_input: AbilityInputController

var widgets := {}

func _ready() -> void:
	controller.connect("ability_finished", _on_ability_finished)


	for child in get_children():
		child.queue_free()
	
	for slot in ability_input.slots:
		var widget = cooldown.instantiate()
		widget.name = slot.ability.name
		add_child(widget)

func _on_ability_finished(ability: Ability) -> void:
	var node = get_node(ability.name)
	node.start_cooldown(ability.cooldown)
