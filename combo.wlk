// Cuantas notas seguidas acertaste: cuanto mas larga la racha, mas vale cada
// acierto
object combo {
	const escalones = [
		new Escalon(desdeRacha = 20, factor = 4),
		new Escalon(desdeRacha = 10, factor = 3),
		new Escalon(desdeRacha = 5, factor = 2)
	]

	var property racha = 0

	method multiplicador() = escalones.findOrElse({ escalon => escalon.alcanza(racha) }, { sinCombo }).factor()

	method sumar() {
		racha += 1
	}

	method cortar() {
		racha = 0
	}

	method texto() = "RACHA: " + racha + "   x" + self.multiplicador()
}

class Escalon {
	const desdeRacha
	const property factor

	method alcanza(unaRacha) = unaRacha >= desdeRacha
}

// Con la racha corta se juega sin multiplicador
object sinCombo {
	method factor() = 1
}
