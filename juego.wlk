import wollok.game.*
import visuales.*
import tablero.*

// En cada momento hay una pantalla activa y el juego le delega todo a ella
// cambiar de pantalla es cabmiar el objeto
// todas las pantallas entienden los mismos metodos
// por lo tanto ahi hay polimorfimso
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

}

object menu {

	const carteles = [
		new Cartel(position = game.at(3, 10), texto = "WOLLOK HERO"),
		new Cartel(position = game.at(2, 6), texto = "ENTER para jugar")
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

}

object jugando {

	const carteles = [
		new Cartel(position = game.at(2, 7), texto = "FLECHA ARRIBA para terminar")
	]

	method entrar() {
		tablero.mostrar(carteles)
	}

	method salir() {
		tablero.ocultar(carteles)
	}

	method confirmar() {}

	method tocar() {
		juego.irA(resultado)
	}

}

object resultado {

	const carteles = [
		new Cartel(position = game.at(4, 10), texto = "FIN"),
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

}
