extends CharacterBody2D
@onready var player = get_node("/root/GameLevel/player")

@export var take_D_dmg = 5
@export var take_A_sword_dmg = 20
@export var take_E_spike_dmg = 10

@export var base_hp = 100
var old_hp
var med_hp
var new_hp
var debug_hp = base_hp

@export var detect_radius = 160

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200
	look_at(player.global_position)
	move_and_slide()

func _ready():
	$enembar.value = base_hp
	$enem_player_detect/enem_player_detect_collbox.shape.radius = detect_radius

func _on_enemhurtbox_area_entered(area):
	if area.is_in_group("playerweponsword"):
		new_hp = debug_hp - take_A_sword_dmg
		old_hp = new_hp + take_A_sword_dmg
		for n in take_A_sword_dmg:
			debug_hp = debug_hp - 1
			$enembar.value = debug_hp
			$enemhp.text = str(debug_hp)
			await get_tree().create_timer(0.02).timeout
			if  (debug_hp <= 0):
				debug_hp = 0
				$enemhp.text = str(debug_hp)
				queue_free()

func _on_enemhurtbox_body_entered(body):
	if body.is_in_group("player_body"):
		new_hp = debug_hp - take_D_dmg
		old_hp = new_hp + take_D_dmg
		for n in take_D_dmg:
			debug_hp = debug_hp - 1
			$enembar.value = debug_hp
			$enemhp.text = str(debug_hp)
			await get_tree().create_timer(0.1).timeout
			if  (debug_hp <= 0):
				debug_hp = 0
				$enemhp.text = str(debug_hp)
				queue_free()
	if body.is_in_group("spikes"):
		base_hp -= 10
		$enembar.value -= 10
		$enemhp.text = str(base_hp - 10)
		if  (debug_hp <= 0):
			debug_hp = 0
			$enemhp.text = str(debug_hp)
			queue_free()
