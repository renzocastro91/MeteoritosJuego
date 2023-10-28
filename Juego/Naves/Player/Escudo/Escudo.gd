extends Area2D
class_name Escudo

#Variables
var esta_activado:bool = false setget, get_esta_activado

#Variables export
export var energia:float = 9.0
export var radio_desgaste = -1.5

#Métodos
func _ready() -> void:
	set_process(false)
	controlar_colisionador(true)

func _process(delta: float) -> void:
	energia += radio_desgaste * delta	
	if energia <= 0.0:
		desactivar()
		
#Métodos Custom
func controlar_colisionador(esta_activado: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_activado)

func activar() -> void:
	if energia <= 0.0:
		return
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("activando")

func desactivar() -> void:
	set_process(false)
	esta_activado = false 
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activando")
	
#Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado

#Señales internas

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)


func _on_Escudo_body_entered(body: Node) -> void:
	body.queue_free()
