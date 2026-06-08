extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jumpSound

const SPEED = 300.0
const JUMP_VELOCITY = -850.0

var can_take_damage = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jumping")
		jump_sound.play()

	var direction := Input.get_axis("left", "Right")

	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("Idle")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	move_and_slide()


func take_damage(from_position):
	if not can_take_damage:
		return

	can_take_damage = false

	print("player hit")

	var dir = (global_position - from_position).normalized()
	velocity = dir * 400

	await get_tree().create_timer(0.5).timeout
	can_take_damage = true
