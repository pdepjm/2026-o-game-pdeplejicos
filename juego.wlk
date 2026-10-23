import wollok.game.*
import partida.*
import pista.*
import visuales.*
import tablero.*
import canciones.*
import dificultad.*

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
}

// Entrar y salir del tablero es igual para todas. Las teclas no hacen nada por
// defecto: cada pantalla redefine solo las que le importan
class Pantalla {
	method visuales()

	method entrar() {
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

}

// Donde se elige la cancion, con las flechas arriba y abajo
object menuInicial inherits Pantalla {
	const botones = [botonBed, botonDance, botonChained, botonFeelGood]
	const elementos = [bannerMenuInicial] + botones

	var indiceSeleccionado = 0

	override method visuales() = elementos

	override method entrar() {
		super()
		self.actualizarLuces()
	}

	override method confirmar() {
		juego.cancionElegida(self.botonSeleccionado().cancion())
		juego.irA(menu)
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
	
	override method configurar() {
        juego.irA(menuConfiguracion)
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

	override method visuales() = elementos

	override method entrar() {
		// dificultad general del juego (que por defecto es fácil)
		pista.usar(juego.dificultadElegida())
		super()
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
		if (partida.termino()) juego.irA(resultado)
	}
}

object resultado inherits Pantalla {
	const carteles = [bannerFinal, puntajeFinal]

	override method visuales() = carteles

	override method confirmar() {
		juego.irA(menuInicial)
	}
}

object menuConfiguracion inherits Pantalla {
	const botones = [botonFacil, botonNormal, botonDificil, botonExperto]
	const elementos = [bannerConfiguracion] + botones

	var indiceSeleccionado = 0

	override method visuales() = elementos

	override method entrar() {
		super()
		self.actualizarLuces()
	}

	override method confirmar() {
		// Guardamos la dificultad elegida en el juego y volvemos al menú inicial
		const d = self.botonSeleccionado().dificultad()
		juego.dificultadElegida(d)
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

	method actualizarLuces() {
		botones.forEach({ boton => boton.seleccionado(false) })
		self.botonSeleccionado().seleccionado(true)
	}
}
