import pista.*
import reloj.*

class Nota {
	const tiempo
	const carril = carrilCentral

	// La misma posicion para toda la vida de la nota: en cada cuadro le
	// cambiamos los valores en vez de crear una nueva
	const miPosicion = new PosicionPrecisa(x = 0, y = 0)

	method image() = "flecha3.png"

	method position() {
		miPosicion.x(carril.columna())
		miPosicion.y(pista.filaPara(self.cuantoFalta()))
		return miPosicion
	}

	// Da negativo cuando la nota ya se paso
	method cuantoFalta() = tiempo - reloj.tiempo()
	method desfasaje() = self.cuantoFalta().abs()
	method estaPorEntrar() = pista.entraAlTablero(self.cuantoFalta())
	method estaAlAlcance(tolerancia) = self.desfasaje() <= tolerancia
	method sePaso(tolerancia) = self.cuantoFalta() < tolerancia.invert()

	// Una simple se acierta apenas se toca
	method alTocar(unaPartida) {
		unaPartida.acertar(self)
	}

	method estaSiendoMantenida() = false
	method completada() = false
	method visuales() = [self]
}

class NotaSostenida {
	const comienzo
	const duracion
	const cola = (1 .. pista.filasPara(duracion).floor()).map({ fila => new TramoDeCola(comienzo = comienzo, filasArriba = fila) })
	var agarrada = false

	const miPosicion = new PosicionPrecisa(x = 0, y = 0)

	method image() = "flecha4.png"

	method position() {
		miPosicion.x(comienzo.position().x())
		miPosicion.y(self.fila())
		return miPosicion
	}
	method fila() = if (agarrada) comienzo.position().y().max(pista.filaDeAcierto()) else comienzo.position().y()
	method cuantoFalta() = comienzo.cuantoFalta()
	method desfasaje() = comienzo.desfasaje()
	method estaPorEntrar() = comienzo.estaPorEntrar()

	method estaAlAlcance(tolerancia) = !agarrada && comienzo.estaAlAlcance(tolerancia)
	method sePaso(tolerancia) = !agarrada && comienzo.sePaso(tolerancia)

	// Tocarla la agarra. Todavia no suma puntos: hay que mantenerla hasta el final
	method alTocar(_unaPartida) {
		self.agarrar()
	}

	method agarrar() {
		agarrada = true
	}

	method completada() = agarrada && self.cuantoFalta() + duracion <= 0
	method estaSiendoMantenida() = agarrada && !self.completada()

	method visuales() = cola + [self]
}

// Un pedazo de la cola de una nota sostenida: va pegado arriba del comienzo
class TramoDeCola {
	const comienzo
	const filasArriba

	const miPosicion = new PosicionPrecisa(x = 0, y = 0)

	method image() = "cola.png"

	method position() {
		miPosicion.x(comienzo.position().x())
		miPosicion.y(comienzo.position().y() + filasArriba)
		return miPosicion
	}
}
