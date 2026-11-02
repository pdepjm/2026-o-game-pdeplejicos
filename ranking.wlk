import wollok.game.*
import visuales.*
import juego.*

class EntryRanking {
	const property nombre
	const property puntaje
	const property esJugador
}

object ranking inherits Pantalla {
	const npcsBase = [
		new EntryRanking(nombre = "Maxi", puntaje = 10000, esJugador = false),
		new EntryRanking(nombre = "Tomas", puntaje = 8000, esJugador = false),
		new EntryRanking(nombre = "Facu", puntaje = 6000, esJugador = false),
		new EntryRanking(nombre = "German", puntaje = 5000, esJugador = false),
		new EntryRanking(nombre = "Agus", puntaje = 2500, esJugador = false)
	]
	
	var ultimoPuntajeJugador = 0
	var jugoPartida = false

	method registrarPuntaje(puntaje) {
		ultimoPuntajeJugador = puntaje
		jugoPartida = true
	}

    method obtenerTop5() {
		const lista = []
		lista.addAll(npcsBase)
		
		if (jugoPartida) {
			lista.add(new EntryRanking(nombre = "Jugador", puntaje = ultimoPuntajeJugador, esJugador = true))
		}
		lista.sortBy({ a, b => a.puntaje() > b.puntaje() })
		
		if (lista.size() > 5) {
			lista.remove(lista.last())
		}
		
		return lista
	}

	method actualizarPuestos() {
		const top5 = self.obtenerTop5()
		
		if (top5.size() >= 1) {
			const e = top5.get(0)
			posicionUno.image(if (e.esJugador()) "btn_pos1.png" else "btn_normal.png")
			cartelRanking1.text("1. " + e.nombre() + "   " + e.puntaje())
		}
		if (top5.size() >= 2) {
			const e = top5.get(1)
			posicionDos.image(if (e.esJugador()) "btn_pos2.png" else "btn_normal.png")
			cartelRanking2.text("2. " + e.nombre() + "   " + e.puntaje())
		}
		if (top5.size() >= 3) {
			const e = top5.get(2)
			posicionTres.image(if (e.esJugador()) "btn_pos3.png" else "btn_normal.png")
			cartelRanking3.text("3. " + e.nombre() + "   " + e.puntaje())
		}
		if (top5.size() >= 4) {
			const e = top5.get(3)
			posicionCuatro.image(if (e.esJugador()) "btn_pos4.png" else "btn_normal.png")
			cartelRanking4.text("4. " + e.nombre() + "   " + e.puntaje())
		}
		if (top5.size() >= 5) {
			const e = top5.get(4)
			posicionCinco.image(if (e.esJugador()) "btn_pos5.png" else "btn_normal.png")
			cartelRanking5.text("5. " + e.nombre() + "   " + e.puntaje())
		}
	}

	override method entrar() {
		super()
		robot.reiniciar()
		self.actualizarPuestos()
		game.onTick(2000, "animarRobotRanking", { => robot.siguiente() })
	}

	override method salir() {
		game.removeTickEvent("animarRobotRanking")
		super()
	}

	override method visuales() {
		self.actualizarPuestos()
		return [
			bannerRanking, 
			robot, 
			posicionUno, posicionDos, posicionTres, posicionCuatro, posicionCinco, 
			cartelRanking1, cartelRanking2, cartelRanking3, cartelRanking4, cartelRanking5
		]
	}

	override method confirmar() {
		juego.irA(menuInicial)
	}
}