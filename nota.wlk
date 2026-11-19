import pista.*
import reloj.*

// Lo que tienen en comun todas las notas: en que momento pasan por el receptor y
// donde se dibujan. Que hacer al tocarla lo decide cada una.
class Nota {
	const property tiempo
	const property carril

	// Una sola posicion para toda la vida de la nota: en cada cuadro le cambiamos
	// los valores en vez de crear otra
	const miPosicion = new PosicionPrecisa(x = 0, y = 0)

	method image()
	method alTocar(unaPartida)
	method alPasarse(unaPartida)

	method position() {
		miPosicion.x(carril.columna())
		miPosicion.y(self.fila())
		return miPosicion
	}

	method fila() = self.filaDondeVa()

	// Donde iria si nada la frenara: la cola de las sostenidas se guia por esto,
	// asi sigue bajando aunque la cabeza se quede esperando en el receptor
	method filaDondeVa() = pista.filaPara(self.cuantoFalta())

	// Da negativo cuando la nota ya se paso
	method cuantoFalta() = tiempo - reloj.tiempo()
	method desfasaje() = self.cuantoFalta().abs()

	method desfasajeAlTocarla() = self.desfasaje()

	method terminaEn() = tiempo

	method estaPorEntrar() = pista.entraAlTablero(self.cuantoFalta())
	method estaAlAlcance(tolerancia) = self.desfasaje() <= tolerancia
	method sePaso(tolerancia) = self.cuantoFalta() < tolerancia.invert()
	method estaSiendoMantenida() = false
	method completada() = false
	method visuales() = [self]
}

class NotaSimple inherits Nota {
	override method image() = self.carril().imagenDeNota()

	override method alTocar(unaPartida) {
		unaPartida.acertar(self)
	}

	override method alPasarse(unaPartida) {
		unaPartida.perder(self)
	}
}

// Se agarra como una simple, pero hay que mantener la tecla hasta que termina su
// cola: suma recien ahi
class NotaSostenida inherits Nota {
	const duracion
	const cola = (1 .. pista.filasPara(duracion).floor()).map({ fila => new TramoDeCola(cabeza = self, filasArriba = fila) })

	var agarrada = false

	// Se puntua por como la agarraste, no por el milisegundo en que termina
	var desfasajeAlAgarrarla = 0

	override method image() = self.carril().imagenDeSostenida()

	// Mientras la mantienen se queda en el receptor y lo que pasa es su cola
	override method fila() = if (agarrada) super().max(pista.filaDeAcierto()) else super()

	method columna() = self.carril().columna()

	override method terminaEn() = self.tiempo() + duracion

	override method desfasajeAlTocarla() = desfasajeAlAgarrarla

	// Una ya agarrada no se vuelve a tocar ni se pierde
	override method estaAlAlcance(tolerancia) = !agarrada && super(tolerancia)
	override method sePaso(tolerancia) = !agarrada && super(tolerancia)

	override method alTocar(_unaPartida) {
		desfasajeAlAgarrarla = self.desfasaje()
		agarrada = true
	}

	override method alPasarse(unaPartida) {
		unaPartida.perder(self)
	}

	override method completada() = agarrada && self.cuantoFalta() + duracion <= 0
	override method estaSiendoMantenida() = agarrada && !self.completada()

	// La cola va primero para que la cabeza se dibuje encima cuando la cruza
	override method visuales() = cola + [self]
}

// Esta no hay que tocarla: tocarla cuesta puntos y dejarla pasar no cuesta nada
class NotaTrampa inherits Nota {
	override method image() = self.carril().imagenDeTrampa()

	override method alTocar(unaPartida) {
		unaPartida.caerEnTrampa(self)
	}

	override method alPasarse(unaPartida) {
		unaPartida.esquivar(self)
	}
}

// La amarilla: suma como cualquiera y ademas prende el bonus
class NotaBonus inherits Nota {
	override method image() = self.carril().imagenDeBonus()

	override method alTocar(unaPartida) {
		unaPartida.acertarConBonus(self)
	}

	override method alPasarse(unaPartida) {
		unaPartida.perder(self)
	}
}

// Un pedazo de cola, pegado arriba de su cabeza
class TramoDeCola {
	const cabeza
	const filasArriba

	const miPosicion = new PosicionPrecisa(x = 0, y = 0)

	method image() = "cola.png"

	method position() {
		miPosicion.x(cabeza.columna())
		miPosicion.y(cabeza.filaDondeVa() + filasArriba)
		return miPosicion
	}
}
