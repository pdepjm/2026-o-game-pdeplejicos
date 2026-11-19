import wollok.game.*
import partida.*
import pista.*
import visuales.*
import tablero.*
import canciones.*
import dificultad.*
import ranking.*

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

	method actualizar() {
		pantalla.actualizar()
	}

	method configurar() {
    pantalla.configurar()
	}

	method izquierda() {
		pantalla.izquierda()
	}

	method derecha() {
		pantalla.derecha()
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
	method actualizar() {}
	method configurar() {}
	method izquierda() {}
	method derecha() {}

}

// Donde se elige la cancion, con las flechas arriba y abajo
object menuInicial inherits Pantalla {
	const botones = [botonBed, botonDance, botonChained, botonFeelGood]
	const opciones = botones + [tuercaConfiguracion, trofeoRanking]
	// Agregamos cartelDeBonus aquí para que se vea el bonus apagado
	const elementos = [bannerMenuInicial, cartelDeBonus, teleDeDificultad] + opciones
	var indiceSeleccionado = 0
	var columnaSeleccionada = 1

	override method visuales() = elementos


	override method entrar() {
		super()
		// Al volver del ranking o de la configuracion la seleccion arranca de
		// nuevo en los temas: si no, el siguiente Enter te devolvia a la
		// pantalla de la que venias y no habia forma de empezar a jugar
		columnaSeleccionada = 1
		self.actualizarLuces()
	}

	override method confirmar() {
		if (columnaSeleccionada == 0) {
			trofeoRanking.confirmar()
		} else if (columnaSeleccionada == 1) {
			self.opcionSeleccionada().confirmar()
		} else if (columnaSeleccionada == 2) {
			tuercaConfiguracion.confirmar()
		}
	}
	
	override method configurar() {
		juego.irA(menuConfiguracion)
	}

	method opcionSeleccionada() = botones.get(indiceSeleccionado)

override method subir() {
		if (columnaSeleccionada == 1) {
			indiceSeleccionado = (indiceSeleccionado - 1).max(0)
			self.actualizarLuces()
		}
	}

	override method bajar() {
		if (columnaSeleccionada == 1) {
			indiceSeleccionado = (indiceSeleccionado + 1).min(botones.size() - 1)
			self.actualizarLuces()
		}
	}

	// Navegación horizontal
	override method izquierda() {
		if (columnaSeleccionada == 2) {
			columnaSeleccionada = 1
			self.actualizarLuces()
		} else if (columnaSeleccionada == 1) {
			columnaSeleccionada = 0
			self.actualizarLuces()
		}
	}

	override method derecha() {
		if (columnaSeleccionada == 0) {
			columnaSeleccionada = 1
			self.actualizarLuces()
		} else if (columnaSeleccionada == 1) {
			columnaSeleccionada = 2
			self.actualizarLuces()
		}
	}

	method actualizarLuces() {
		botones.forEach({ boton => boton.seleccionado(false) })
		trofeoRanking.seleccionado(false)
		tuercaConfiguracion.seleccionado(false)

		if (columnaSeleccionada == 0) {
			trofeoRanking.seleccionado(true)
		} else if (columnaSeleccionada == 1) {
			self.opcionSeleccionada().seleccionado(true)
		} else if (columnaSeleccionada == 2) {
			tuercaConfiguracion.seleccionado(true)
		}
	}

}

// La cancion elegida, con la explicacion de cada flecha
object menu inherits Pantalla {
	const carteles = [
		bannerInicio,
		cartelDeBonus,
		teleDeDificultad,
		new Muestra(position = game.at(1, 1), image = "nota_arriba.png"),
		new Cartel(position = game.at(2, 1), texto = "TOCALA"),
		new Muestra(position = game.at(4, 1), image = "sostenida_arriba.png"),
		new Cartel(position = game.at(5, 1), texto = "MANTENELA"),
		new Muestra(position = game.at(8, 1), image = "trampa_arriba.png"),
		new Cartel(position = game.at(9, 1), texto = "NO LA TOQUES"),
		new Muestra(position = game.at(12, 1), image = "bonus_arriba.png"),
		new Cartel(position = game.at(13, 1), texto = "VALE DOBLE")
	]

	override method visuales() = carteles

	override method confirmar() {
		juego.irA(jugando)
	}
}

object jugando inherits Pantalla {
	const elementos = receptores + [marcador, marcadorDeCombo, cartelDeBonus, cartelDePrecision]

	
	override method fondo() = "fondo_luz.png"

	override method visuales() = elementos

	override method entrar() {
        super() 
        
        // Configuración y arranque de la partida
        pista.usar(juego.dificultadElegida())
        partida.empezar(juego.cancionElegida())
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
		if (partida.termino()){
			juego.irA(resultado)
			ranking.registrarPuntaje(partida.puntaje())
		}
	}
}

object resultado inherits Pantalla {
	const carteles = [bannerFinal, puntajeFinal, cartelDeBonus]

	override method visuales() = carteles

	override method confirmar() {
		juego.irA(menuInicial)
	}
}

object menuConfiguracion inherits Pantalla {
	const botones = [botonFacil, botonNormal, botonDificil, botonExperto]
	const elementos = [bannerConfiguracion, teleDeDificultad] + botones

	var indiceSeleccionado = 0

	override method visuales() = elementos

	override method entrar() {
		super()
		self.actualizarLuces()
	}

	override method confirmar() {
		juego.irA(menuInicial)
	}

	method botonSeleccionado() = botones.get(indiceSeleccionado)

	override method subir() {
		indiceSeleccionado = (indiceSeleccionado - 1).max(0)
		self.actualizarLuces()
	}

	override method bajar() {
		indiceSeleccionado = (indiceSeleccionado + 1).min(3)
		self.actualizarLuces()
	}

	// Moverse ya elige: la tele del fondo muestra en el momento con que
	// dificultad vas a jugar
	method actualizarLuces() {
		botones.forEach({ boton => boton.seleccionado(false) })
		self.botonSeleccionado().seleccionado(true)
		juego.dificultadElegida(self.botonSeleccionado().dificultad())
	}
}
