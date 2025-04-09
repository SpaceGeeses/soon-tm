extends CharacterBody2D
@export var max_speed: int = 300
@onready var sprite = $Sprite2D

var target_position = Vector2()
var arrive_radius = 1


func _ready():
	target_position = position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		print(sprite.texture.size)
		target_position = get_global_mouse_position()


func _process(delta: float) -> void:
	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_to(target_position)

	if distance_to_target < arrive_radius:
		velocity = Vector2()
	else:
		velocity = direction * max_speed

	move_and_slide()
