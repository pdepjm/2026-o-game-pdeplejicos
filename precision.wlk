// Que tan justo le pegaste a una nota
import visuales.*
object perfecto {
	method alcanza(desfasaje) = desfasaje <= 40
	method puntos() = 150
	method texto() = "PERFECTO"
	method actualizarCartel() {
    cartelDePrecision.perfecto()
	}
}

object bien {
	method alcanza(desfasaje) = desfasaje <= 90
	method puntos() = 100
	method texto() = "BIEN"
	method actualizarCartel() {
    cartelDePrecision.bien()
	}
}

// La ultima acepta cualquier desfasaje: si llego hasta aca, es acierto
object apenas {
	method alcanza(_desfasaje) = true
	method puntos() = 50
	method texto() = "APENAS"
	method actualizarCartel() {
    cartelDePrecision.mal()
	}
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
