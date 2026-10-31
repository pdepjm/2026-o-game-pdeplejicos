// Que tan rapido bajan las notas (cuantos milisegundos entran en cada fila del
// tablero) y cuales de las notas del tema entran a jugar: cada cancion trae una
// lista por dificultad y es la dificultad la que sabe cual pedirle.
object facil {
	method nombre() = "FACIL"
	method msPorFila() = 180
	method notasDe(unaCancion) = unaCancion.notasFacil()
	method imagenTele() = "tv_facil.png"
}

object normal {
	method nombre() = "NORMAL"
	method msPorFila() = 140
	method notasDe(unaCancion) = unaCancion.notasNormal()
	method imagenTele() = "tv_normal.png"
}

object dificil {
	method nombre() = "DIFICIL"
	method msPorFila() = 110
	method notasDe(unaCancion) = unaCancion.notasDificil()
	method imagenTele() = "tv_dificil.png"
}

object experto {
	method nombre() = "EXPERTO"
	method msPorFila() = 85
	method notasDe(unaCancion) = unaCancion.notasExperto()
	method imagenTele() = "tv_experto.png"
}
