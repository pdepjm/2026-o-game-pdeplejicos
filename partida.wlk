import wollok.game.*
import reloj.*
import sonido.*
import tablero.*

// Las reglas y el puntaje: que pasa cuando el jugador acierta, cuando toca de
// gusto y cuando deja pasar una nota. Las simples y las sostenidas se tratan
// igual, cada una sabe responder por si misma.
object partida {
	const puntosPorAcierto = 100
	const puntosPorError = 50

	// Bajo, para que la musica no tape el resto del juego
	const volumenDeLaMusica = 0.1

	// Milisegundos de error que le perdonamos al jugador
	const tolerancia = 160

	// Las que todavia no estan en el tablero, en el orden en que van a aparecer
	const porAparecer = []

	// Las que ya estan en el tablero
	const notas = []
	var property puntaje = 0
	var duracion = 0
	var audio = sonidoMudo

	method empezar(unaCancion) {
		puntaje = 0
		duracion = unaCancion.duracion()
		notas.clear()
		porAparecer.clear()
		porAparecer.addAll(unaCancion.notas())
		audio = reproductor.sonido(unaCancion.archivo())
		audio.volume(volumenDeLaMusica)
		reloj.arrancar()
		audio.play()
	}

	method terminar() {
		tablero.ocultar(self.visualesDeLasNotas())
		notas.clear()
		porAparecer.clear()
		audio.stop()
		audio = sonidoMudo

	}

	method termino() = reloj.tiempo() >= duracion

	// Si hay una nota a tiempo toca la mas cercana, y ella sabe que hacer.
	// Si no hay ninguna, fue de gusto
	method tocar() {
		if (self.hayNotaAlAlcance()) self.notaMasCercana().alTocar(self) else self.errar()
	}

	// El jugador solto la tecla: se le escapan las sostenidas que estaba manteniendo
	method soltar() {
		self.perderLasQue({ nota => nota.estaSiendoMantenida() })
	}

	// Corre todo el tiempo mientras se juega
	method actualizar() {
		self.mostrarLasQueEntran()
		self.perderLasQue({ nota => nota.sePaso(tolerancia) })
		notas.filter({ nota => nota.completada() }).forEach({ nota => self.acertar(nota) })
	}

	// El motor le pregunta la posicion a todos los visuales en cada cuadro, se vean
	// o no, asi que las notas entran al tablero recien cuando les toca. Como vienen
	// ordenadas, alcanza con mirar la primera
	method mostrarLasQueEntran() {
		if (!porAparecer.isEmpty() && porAparecer.first().estaPorEntrar()) {
			const nota = porAparecer.first()
			porAparecer.remove(nota)
			notas.add(nota)
			tablero.mostrar(nota.visuales())
			self.mostrarLasQueEntran()
		}
	}

	method hayNotaAlAlcance() = !self.notasAlAlcance().isEmpty()
	method notaMasCercana() = self.notasAlAlcance().min({ nota => nota.desfasaje() })
	method notasAlAlcance() = notas.filter({ nota => nota.estaAlAlcance(tolerancia) })
	method visualesDeLasNotas() = notas.flatMap({ nota => nota.visuales() })

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

	method perderLasQue(condicion) {
		notas.filter(condicion).forEach({ nota => self.perder(nota) })
	}

	method sacar(nota) {
		notas.remove(nota)
		tablero.ocultar(nota.visuales())
	}
}
