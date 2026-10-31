import colores.*

// Cuantas notas seguidas acertaste: cuanto mas larga la racha, mas vale cada
// acierto
object combo {
	const escalones = [
		new Escalon(desdeRacha = 20, factor = 4, color = rojo),
		new Escalon(desdeRacha = 10, factor = 3, color = naranja),
		new Escalon(desdeRacha = 5, factor = 2, color = amarillo)
	]

	var property racha = 0

	// La mas larga de toda la ronda, para el resumen del final
	var property rachaMaxima = 0

	method multiplicador() = self.escalonActual().factor()

	method sumar() {
		racha += 1
		rachaMaxima = rachaMaxima.max(racha)
	}

	method reiniciar() {
		racha = 0
		rachaMaxima = 0
	}

	method cortar() {
		racha = 0
	}

	method texto() = "RACHA: " + racha + "   x" + self.multiplicador()

	method color() = self.escalonActual().color()

	method escalonActual() = escalones.findOrElse({ escalon => escalon.alcanza(racha) }, { sinCombo })
}

class Escalon {
	const desdeRacha
	const property factor
	const property color

	method alcanza(unaRacha) = unaRacha >= desdeRacha
}

// Con la racha corta se juega sin multiplicador
object sinCombo {
	method factor() = 1
	method color() = blanco
}
