// Que tan rapido bajan las notas: cuantos milisegundos entran en cada fila del
// tablero. Cuanto menos, menos tiempo tenes para reaccionar.
object facil {
	method nombre() = "FACIL"
	method msPorFila() = 250
	method imagenTele() = "tv_facil.png"
}

object normal {
	method nombre() = "NORMAL"
	method msPorFila() = 180
	method imagenTele() = "tv_normal.png"
}

object dificil {
	method nombre() = "DIFICIL"
	method msPorFila() = 110
	method imagenTele() = "tv_dificil.png"
}

object experto {
	method nombre() = "EXPERTO"
	method msPorFila() = 85
	method imagenTele() = "tv_experto.png"
}
