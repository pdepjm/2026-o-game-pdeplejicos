import wollok.game.*
import partida.*
import pista.*
import visuales.*
import tablero.*
import cancion.*

// En cada momento hay una pantalla activa y el juego le delega todo a ella, asi
// que cambiar de pantalla es cambiar el objeto al que le hablamos. Las tres
// entienden los mismos mensajes sin compartir ninguna clase.
object juego {
	var pantalla = menuInicial

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

	method soltar() {
		pantalla.soltar()
	}

	method actualizar() {
		pantalla.actualizar()
	}

	method bajar() {
		pantalla.bajar()
	}
}

object menuInicial {
	const botones = [botonBed, botonProx1, botonProx2, botonProx3]
	const elementos = [bannerMenuInicial] + botones
	var indiceSeleccionado = 0

	method entrar() {
		tablero.mostrar(elementos)
		self.actualizarLuces()
	}

	method salir() {
		tablero.ocultar(elementos)
	}

	method confirmar() {
		// Los otros tres botones todavia no tienen cancion
		if (indiceSeleccionado == 0) {
			juego.irA(menu)
		}
	}

	// La flecha arriba mueve la seleccion hacia arriba
	method tocar() {
		indiceSeleccionado = (indiceSeleccionado - 1).max(0)
		self.actualizarLuces()
	}

	method bajar() {
		indiceSeleccionado = (indiceSeleccionado + 1).min(3)
		self.actualizarLuces()
	}

	method actualizarLuces() {
		botones.forEach({ b => b.seleccionado(false) })
		botones.get(indiceSeleccionado).seleccionado(true)
	}

	method soltar() {}
	method actualizar() {}
}

object menu {

	const carteles = [bannerInicio]

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

	method bajar() {}

	method soltar() {}

	method actualizar() {}

}

object jugando {
	const elementos = [receptor, marcador]

	method entrar() {
		tablero.mostrar(elementos)
		partida.empezar(bedGoesUp)
	}

	method salir() {
		partida.terminar()
		tablero.ocultar(elementos)
	}

	method confirmar() {}

	method tocar() {
		partida.tocar()
	}

	method bajar() {}

	method soltar() {
		partida.soltar()
	}

	method actualizar() {
		partida.actualizar()
		if (partida.termino()) juego.irA(resultado)
	}
}

object resultado {
	const carteles = [
		bannerFinal,
		puntajeFinal
	]

	method entrar() {
		tablero.mostrar(carteles)
	}

	method salir() {
		tablero.ocultar(carteles)
	}

	method confirmar() {
		juego.irA(menuInicial)
	}

	method tocar() {}
	method bajar() {}
	method soltar() {}
	method actualizar() {}
}
