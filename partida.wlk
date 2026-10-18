import wollok.game.*
import reloj.*
import sonido.*
import tablero.*
import combo.*
import bonus.*
import precision.*

// Las reglas y el puntaje: que pasa al acertar, al tocar de gusto, al caer en una
// trampa y al dejar pasar una nota
object partida {
	const puntosPorError = 50
	const puntosPorTrampa = 100

	// Bajo, para que la musica no tape el resto del juego
	const volumenDeLaMusica = 0.1

	// Milisegundos de error que le perdonamos al jugador
	const tolerancia = 160

	// De mas exigente a menos: gana la primera que alcanza
	const precisiones = [perfecto, bien, apenas]

	// Las que todavia no estan en el tablero, en el orden en que van a aparecer
	const porAparecer = []

	const notas = []

	var property puntaje = 0

	var property ultimoResultado = sinTocar

	var duracion = 0
	var audio = sonidoMudo

	method empezar(unaCancion) {
		puntaje = 0
		ultimoResultado = sinTocar
		combo.cortar()
		bonus.apagar()
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

	// Toca la mas cercana de ese carril, y ella sabe que hacer. Si no hay ninguna
	// a tiempo, fue de gusto
	method tocar(unCarril) {
		const alAlcance = self.notasAlAlcance(unCarril)
		if (alAlcance.isEmpty()) self.errar()
		else alAlcance.min({ nota => nota.desfasaje() }).alTocar(self)
	}

	// Al soltar se escapan las sostenidas que estaba manteniendo en ese carril
	method soltar(unCarril) {
		self.delCarril(unCarril).filter({ nota => nota.estaSiendoMantenida() })
			.forEach({ nota => self.perder(nota) })
	}

	// Corre todo el tiempo mientras se juega
	method actualizar() {
		self.mostrarLasQueEntran()
		notas.filter({ nota => nota.sePaso(tolerancia) }).forEach({ nota => nota.alPasarse(self) })
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

	method delCarril(unCarril) = notas.filter({ nota => nota.carril() == unCarril })

	method notasAlAlcance(unCarril) = self.delCarril(unCarril).filter({ nota => nota.estaAlAlcance(tolerancia) })

	method visualesDeLasNotas() = notas.flatMap({ nota => nota.visuales() })

	// Suma con el multiplicador que tenias, y recien ahi alarga la racha
	method acertar(nota) {
		const precision = self.precisionPara(nota)
		ultimoResultado = precision
		puntaje += precision.puntos() * combo.multiplicador() * bonus.multiplicador()
		combo.sumar()
		self.sacar(nota)
	}

	method acertarConBonus(nota) {
		bonus.prender()
		self.acertar(nota)
	}

	method precisionPara(nota) = precisiones.find({ precision => precision.alcanza(nota.desfasajeAlTocarla()) })

	method errar() {
		puntaje -= puntosPorError
		combo.cortar()
		ultimoResultado = fallo
	}

	method perder(nota) {
		self.errar()
		self.sacar(nota)
	}

	method caerEnTrampa(nota) {
		puntaje -= puntosPorTrampa
		combo.cortar()
		ultimoResultado = cayoEnTrampa
		self.sacar(nota)
	}

	// Dejarla pasar es lo que corresponde, asi que no cuesta nada
	method esquivar(nota) {
		self.sacar(nota)
	}

	method sacar(nota) {
		notas.remove(nota)
		tablero.ocultar(nota.visuales())
	}
}
