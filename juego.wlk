import wollok.game.*
import partida.*
import pista.*
import visuales.*
import tablero.*
import cancion.*

// cada pantalla decide como responder a las mismas acciones del juego
object juego {

	var property pantalla = menu

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

	method tocar() {
		pantalla.tocar()
	}

	method actualizar() {
		pantalla.actualizar()
	}

}

object menu {

	const carteles = [
		new Cartel(position = game.at(3, 10), texto = "WOLLOK HERO"),
		new Cartel(position = game.at(2, 8), texto = cancionDeEjemplo.nombre()),
		new Cartel(position = game.at(2, 6), texto = "ENTER para jugar"),
		new Cartel(position = game.at(2, 5), texto = "FLECHA ARRIBA para tocar las notas")
	]

	method entrar() {
		tablero.mostrar(carteles)
	}

	method salir() {
		tablero.ocultar(carteles)
	}

	method confirmar() {
		juego.irA(jugando)
	}

	method tocar() {}

	method actualizar() {}

}

object jugando {

	const elementos = [receptor, marcador]

	method entrar() {
		tablero.mostrar(elementos)
		partida.empezar(cancionDeEjemplo)
	}

	method salir() {
		partida.terminar()
		tablero.ocultar(elementos)
	}

	method confirmar() {}

	method tocar() {
		partida.tocar()
	}

	method actualizar() {
		partida.actualizar()
		if (partida.termino()) juego.irA(resultado)
	}

}

object resultado {

	const carteles = [
		new Cartel(position = game.at(4, 10), texto = "FIN"),
		puntajeFinal,
		new Cartel(position = game.at(2, 5), texto = "ENTER para volver al menu")
	]

	method entrar() {
		tablero.mostrar(carteles)
	}

	method salir() {
		tablero.ocultar(carteles)
	}

	method confirmar() {
		juego.irA(menu)
	}

	method tocar() {}

	method actualizar() {}

}
