import reloj.*
import tablero.*

object partida {

	const puntosPorAcierto = 100
	const puntosPorError = 50

	// permite acertar cerca del momento exacto sin exigir precision perfecta
	const tolerancia = 160

	const notas = []

	var property puntaje = 0
	var duracion = 0

	method empezar(unaCancion) {
		puntaje = 0
		duracion = unaCancion.duracion()
		notas.clear()
		notas.addAll(unaCancion.notas())
		tablero.mostrar(notas)
		reloj.arrancar()
	}

	method terminar() {
		tablero.ocultar(notas)
		notas.clear()
	}

	method termino() = reloj.tiempo() >= duracion

	method tocar() {
		if (self.hayNotaAlAlcance()) self.acertar(self.notaMasCercana()) else self.errar()
	}

	method actualizar() {
		notas.filter({ nota => nota.sePaso(tolerancia) }).forEach({ nota => self.perder(nota) })
	}

	method hayNotaAlAlcance() = !self.notasAlAlcance().isEmpty()

	method notaMasCercana() = self.notasAlAlcance().min({ nota => nota.desfasaje() })

	method notasAlAlcance() = notas.filter({ nota => nota.estaAlAlcance(tolerancia) })

	method acertar(nota) {
		puntaje += puntosPorAcierto
		self.sacar(nota)
	}

	method errar() {
		puntaje -= puntosPorError
	}

	method perder(nota) {
		self.errar()
		self.sacar(nota)
	}

	method sacar(nota) {
		notas.remove(nota)
		tablero.ocultar([nota])
	}

}
