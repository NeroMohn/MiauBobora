extends Line2D

@onready var player
var vector_start := Vector2.ZERO
var vector_end := Vector2.ZERO
@onready var canShot := true


func enable_input_processing():
	set_process_input(true)

func _ready() -> void:
	player = get_parent()
	set_process_input(false)
	
func _input(_event: InputEvent) -> void:
	if canShot:
		if Input.is_action_just_pressed("click"):
			vector_start = get_global_mouse_position()
			vector_end = vector_start
			points[0] = vector_start
		if Input.is_action_pressed("click"):
			vector_end = get_global_mouse_position()
			points[1] = vector_end
		if Input.is_action_just_released("click"):
			player.freeze = false
			player.dir = (vector_start - vector_end) *2
			visible = false
			canShot = false
			player.gravity_scale = 0.7
			$"../AnimatedSprite2D".play("Flying")
