// Que tan rapido bajan las notas: cuantos milisegundos entran en cada fila del
// tablero. Cuanto menos, menos tiempo tenes para reaccionar.
object facil {
	method nombre() = "FACIL"
	method msPorFila() = 250
}

object normal {
	method nombre() = "NORMAL"
	method msPorFila() = 180
}

object dificil {
	method nombre() = "DIFICIL"
	method msPorFila() = 110
}

object experto {
	method nombre() = "EXPERTO"
	method msPorFila() = 85
}
