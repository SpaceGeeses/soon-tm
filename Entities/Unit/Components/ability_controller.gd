extends Node
class_name AbilityController

signal ability_started(ability: Ability)
signal ability_finished(ability: Ability)
signal ability_failed(ability: Ability)

var cooldowns: Dictionary[Ability, float] = {}
var current_cast: Ability = null
var cast_timer: float = 0.0


var fail_reasons = {
	ON_COOLDOWN = "Ability is on cooldown",
	NOT_ENOUGH_RESOURCES = "Not enough resources",
	INVALID_TARGET = "Invalid target"
}

func request_cast(ability: Ability, caster: CharacterBody2D, target = null):
	if ability in cooldowns and cooldowns[ability] > 0:
		emit_signal("ability_failed", ability, fail_reasons.ON_COOLDOWN)
		return false

	if ability.cast_time > 0:
		current_cast = ability
		cast_timer = ability.cast_time
		emit_signal("ability_started", ability)
	else:
		_execute_ability(ability, caster)

func _execute_ability(ability: Ability, caster: CharacterBody2D, target = null):
	ability.execute(caster, target)
	cooldowns[ability] = ability.cooldown
	emit_signal("ability_finished", ability)

func _physics_process(delta: float):
	if current_cast:
		cast_timer -= delta
		if cast_timer <= 0.0:
			_execute_ability(current_cast, get_parent())
			current_cast = null

func _process(delta: float) -> void:
	for key in cooldowns.keys():
		cooldowns[key] = max(cooldowns[key] - delta, 0)
