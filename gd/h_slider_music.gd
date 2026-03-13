extends HSlider
@export var bus_name: String = "Musica"
var busSoundId: int
@onready var soundPlayerTest: AudioStreamPlayer 

func _ready() -> void:
	busSoundId = AudioServer.get_bus_index(bus_name)
	value = AudioServer.get_bus_volume_linear(busSoundId)*100
	pass 
	
func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_linear(busSoundId, new_value/100)
	
	if soundPlayerTest:
		soundPlayerTest.stop()
		soundPlayerTest.play()
	pass
