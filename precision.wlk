// Que tan justo le pegaste a una nota
object perfecto {
	method alcanza(desfasaje) = desfasaje <= 40
	method puntos() = 150
	method texto() = "PERFECTO"
}

object bien {
	method alcanza(desfasaje) = desfasaje <= 90
	method puntos() = 100
	method texto() = "BIEN"
}

// La ultima acepta cualquier desfasaje: si llego hasta aca, es acierto
object apenas {
	method alcanza(_desfasaje) = true
	method puntos() = 50
	method texto() = "APENAS"
}

// Estos no son aciertos, pero tambien tienen que poder mostrarse en el cartel
object fallo {
	method texto() = "MAL"
}

object cayoEnTrampa {
	method texto() = "TRAMPA!"
}

object sinTocar {
	method texto() = ""
}
