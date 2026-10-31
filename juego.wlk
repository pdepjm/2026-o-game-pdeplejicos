import wollok.game.*
import partida.*
import pista.*
import visuales.*
import tablero.*
import canciones.*
import dificultad.*
import tablaDePuntajes.*
import nombre.*
import estadisticas.*
import colores.*

// La dificultad elegida se enciende en la tele que esta dibujada en el fondo
const teleDeDificultad = new MuestraQueCambia(
	position = new PosicionPrecisa(x = 10.25, y = 7.75),
	imagen = { juego.dificultadElegida().imagenTele() }
)

// En cada momento hay una pantalla activa y el juego le delega todo a ella, asi
// que cambiar de pantalla es cambiar el objeto al que le hablamos
object juego {
	var pantalla = menuInicial

	var property cancionElegida = bedGoesUp
	var property dificultadElegida = facil

	method empezar() {
		pantalla.entrar()
	}

	method irA(otraPantalla) {
		pantalla.salir()
		pantalla = otraPantalla
		pantalla.entrar()
	}

	method confirmar() {
		pantalla.confirmar()
	}

	method tocar(unCarril) {
		pantalla.tocar(unCarril)
	}

	method soltar(unCarril) {
		pantalla.soltar(unCarril)
	}

	method subir() {
		pantalla.subir()
	}

	method bajar() {
		pantalla.bajar()
	}

	method anterior() {
		pantalla.anterior()
	}

	method siguiente() {
		pantalla.siguiente()
	}

	method actualizar() {
		pantalla.actualizar()
	}
}

// Entrar y salir del tablero es igual para todas. Las teclas no hacen nada por
// defecto: cada pantalla redefine solo las que le importan
class Pantalla {
	method visuales()

	method fondo() = "fondo_luz.png"

	method entrar() {
		game.boardGround(self.fondo())
		tablero.mostrar(self.visuales())
	}

	method salir() {
		tablero.ocultar(self.visuales())
	}

	method confirmar() {}
	method tocar(_unCarril) {}
	method soltar(_unCarril) {}
	method subir() {}
	method bajar() {}
	method anterior() {}
	method siguiente() {}
	method actualizar() {}
}

// Donde se arma la partida: la cancion con las flechas arriba y abajo, y la
// dificultad con las de los costados
object menuInicial inherits Pantalla {
	const botones = [botonBed, botonDance, botonChained, botonFeelGood]
	const dificultades = [facil, normal, dificil, experto]

	const carteles = [
		new Cartel(position = game.at(2, 2), texto = "ARRIBA Y ABAJO: TEMA"),
		new Cartel(position = game.at(2, 1), texto = "IZQUIERDA Y DERECHA: DIFICULTAD"),
		teleDeDificultad
	]

	const elementos = [bannerMenuInicial] + botones + carteles

	var indiceSeleccionado = 0
	var indiceDificultad = 0

	override method visuales() = elementos

	override method entrar() {
		super()
		self.actualizarLuces()
	}

	override method confirmar() {
		juego.cancionElegida(self.botonSeleccionado().cancion())
		juego.irA(menu)
	}

	override method anterior() {
		self.elegirDificultad(indiceDificultad - 1)
	}

	override method siguiente() {
		self.elegirDificultad(indiceDificultad + 1)
	}

	method elegirDificultad(indice) {
		indiceDificultad = indice.max(0).min(dificultades.size() - 1)
		juego.dificultadElegida(dificultades.get(indiceDificultad))
	}

	method botonSeleccionado() = botones.get(indiceSeleccionado)

	override method subir() {
		indiceSeleccionado = (indiceSeleccionado - 1).max(0)
		self.actualizarLuces()
	}

	override method bajar() {
		indiceSeleccionado = (indiceSeleccionado + 1).min(botones.size() - 1)
		self.actualizarLuces()
	}

	method actualizarLuces() {
		botones.forEach({ boton => boton.seleccionado(false) })
		self.botonSeleccionado().seleccionado(true)
	}
}

// La cancion elegida, con la explicacion de cada flecha
object menu inherits Pantalla {
	const carteles = [
		bannerInicio,
		teleDeDificultad,
		new CartelQueCambia(position = game.at(4, 9), color = amarillo, texto = {
			juego.cancionElegida().nombre() + " - " + juego.cancionElegida().artista() +
				"   [" + juego.dificultadElegida().nombre() + "]"
		}),
		new Cartel(position = game.at(1, 2), texto = "QUE ES CADA FLECHA"),
		new Muestra(position = game.at(1, 1), image = "nota_arriba.png"),
		new Cartel(position = game.at(2, 1), color = verde, texto = "TOCALA"),
		new Muestra(position = game.at(4, 1), image = "sostenida_arriba.png"),
		new Cartel(position = game.at(5, 1), color = celeste, texto = "MANTENELA"),
		new Muestra(position = game.at(8, 1), image = "trampa_arriba.png"),
		new Cartel(position = game.at(9, 1), color = violeta, texto = "NO LA TOQUES"),
		new Muestra(position = game.at(12, 1), image = "bonus_arriba.png"),
		new Cartel(position = game.at(13, 1), color = amarillo, texto = "VALE DOBLE")
	]

	override method visuales() = carteles

	override method confirmar() {
		juego.irA(jugando)
	}
}

object jugando inherits Pantalla {
	const elementos = receptores + [marcador, marcadorDeCombo, cartelDeBonus, cartelDePrecision]

	override method visuales() = elementos

	override method entrar() {
		// La velocidad se fija antes de crear las notas, porque la cola de las
		// sostenidas se arma contando filas
		pista.usar(juego.dificultadElegida())
		super()
		partida.empezar(juego.cancionElegida(), juego.dificultadElegida())
	}

	override method salir() {
		partida.terminar()
		super()
	}

	override method tocar(unCarril) {
		partida.tocar(unCarril)
	}

	override method soltar(unCarril) {
		partida.soltar(unCarril)
	}

	override method actualizar() {
		partida.actualizar()
		if (partida.termino()) juego.irA(ingresoDeNombre)
	}
}

// Las tres letras que van a quedar en la tabla: arriba y abajo cambian la letra,
// los costados se mueven entre ellas
object ingresoDeNombre inherits Pantalla {
	const carteles = [
		new Cartel(position = game.at(4, 7), texto = "PONE TU NOMBRE"),
		new CartelQueCambia(position = game.at(6, 5), texto = { nombre.textoEnEdicion() }),
		new CartelQueCambia(position = game.at(4, 3), texto = { "PUNTAJE: " + partida.puntaje() }),
		new Cartel(position = game.at(3, 1), texto = "ENTER PARA ANOTARTE")
	]

	override method visuales() = carteles

	override method subir() {
		nombre.siguienteLetra()
	}

	override method bajar() {
		nombre.letraAnterior()
	}

	override method anterior() {
		nombre.irALaIzquierda()
	}

	override method siguiente() {
		nombre.irALaDerecha()
	}

	override method confirmar() {
		tablaDePuntajes.anotar(juego.cancionElegida(), juego.dificultadElegida(),
			partida.puntaje(), nombre.texto())
		juego.irA(resultado)
	}
}

object resultado inherits Pantalla {
	const carteles = [
		bannerFinal,
		puntajeFinal,
		new CartelQueCambia(position = game.at(1, 8), color = amarillo,
			texto = { "TOP 5  " + juego.dificultadElegida().nombre() }),
		new Cartel(position = game.at(12, 8), color = amarillo, texto = "COMO TE FUE"),
		new CartelQueCambia(position = game.at(12, 7), color = verde,
			texto = { "PERFECTAS " + estadisticas.perfectas() }),
		new CartelQueCambia(position = game.at(12, 6), color = celeste,
			texto = { "BIEN      " + estadisticas.bien() }),
		new CartelQueCambia(position = game.at(12, 5),
			texto = { "APENAS    " + estadisticas.apenas() }),
		new CartelQueCambia(position = game.at(12, 4), color = rojo,
			texto = { "ERRADAS   " + estadisticas.erradas() }),
		new CartelQueCambia(position = game.at(12, 3), color = naranja,
			texto = { "RACHA     " + estadisticas.rachaMaxima() })
	] + (1 .. 5).map({ lugar =>
		// el primer puesto va resaltado
		new CartelQueCambia(position = game.at(1, 8 - lugar), color = self.colorDelPuesto(lugar),
			texto = { tablaDePuntajes.renglon(lugar, juego.cancionElegida(), juego.dificultadElegida()) })
	})

	method colorDelPuesto(lugar) = if (lugar == 1) amarillo else blanco

	override method visuales() = carteles

	override method confirmar() {
		juego.irA(menuInicial)
	}
}
