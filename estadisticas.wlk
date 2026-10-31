import combo.*

// Como te fue en la ronda, para el resumen de la pantalla final. No pregunta
// nada: cada precision sabe en que contador tiene que sumarse.
object estadisticas {
	var property perfectas = 0
	var property bien = 0
	var property apenas = 0
	var property erradas = 0

	method vaciar() {
		perfectas = 0
		bien = 0
		apenas = 0
		erradas = 0
	}

	method anotar(unaPrecision) {
		unaPrecision.sumarA(self)
	}

	method unaPerfecta() {
		perfectas += 1
	}

	method unaBien() {
		bien += 1
	}

	method unaApenas() {
		apenas += 1
	}

	method unaErrada() {
		erradas += 1
	}

	method rachaMaxima() = combo.rachaMaxima()
}
