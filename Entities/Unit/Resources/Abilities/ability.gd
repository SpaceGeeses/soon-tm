extends Resource
class_name Ability

@export var name: String
@export var icon: Texture2D
@export var cooldown: float = 0.0
@export var cast_time: float = 0.0
@export var cost: int = 0

func execute(caster: CharacterBody2D, target: CharacterBody2D):
	print('test')
