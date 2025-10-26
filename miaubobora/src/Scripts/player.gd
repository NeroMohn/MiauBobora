class_name Player

extends RigidBody2D

@onready var dir := Vector2.ZERO

func _ready() -> void:
	self.gravity_scale = 0.0

func _physics_process(delta: float) -> void:
	apply_impulse(dir, position)
	dir= lerp(dir, Vector2.ZERO, 0.5)

func enable_input_processing():
	var line = $Line2D
	line.set_process_input(true)
