extends Control
class_name Cooldown

@onready var progress: TextureProgressBar = $TextureProgressBar

var cooldown_time: float = 0.0
var remaining: float = 0.0


func start_cooldown(duration: float) -> void:
	cooldown_time = duration
	remaining = duration
	progress.value = 1.0
	set_process(true)

func _process(delta: float) -> void:
	if remaining > 0.0:
		remaining -= delta
		var ratio: float = max(remaining / cooldown_time, 0.0)
		progress.value = ratio
	else:
		progress.value = 0.0
		set_process(false)
