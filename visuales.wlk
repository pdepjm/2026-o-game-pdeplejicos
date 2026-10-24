import wollok.game.*
import partida.*
import pista.*
import combo.*
import bonus.*
import juego.*
import canciones.*
import dificultad.*
import ranking.*

object bannerFinal {
	method position() = game.at(4, 3)
	method image() = "banner_final.png"
}

object bannerInicio {
	method position() = game.at(4, 3)
	method image() = juego.cancionElegida().imagenBanner()
}

object bannerMenuInicial {
	method position() = game.at(4, 3)
	method image() = "banner_menu_inicial.png"
}



const blanco = "FFFFFFFF"

class Cartel {
	const property position
	const texto
	var property color = blanco

	method text() = texto
	method textColor() = color
}

// Una imagen suelta en el tablero, para los ejemplos del menu
class Muestra {
	const property position
	const property image
}

class Marcador {
	const property position
	const prefijo
	var property color = blanco

	method text() = prefijo + partida.puntaje().toString()
	method textColor() = color
}

// Cada boton del menu conoce la cancion que arranca y con que dificultad
class BotonNivel {
	const property position
	const property cancion
	const imgNormal
	const imgIluminado
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
	method dificultad() = cancion.dificultad()
	method confirmar() {
		juego.cancionElegida(cancion)
		juego.irA(menu)
	}
}

// Un cartel cuyo texto se calcula cada vez que se dibuja
class CartelQueCambia {
	const property position
	const texto

	method text() = texto.apply()
	method textColor() = blanco
}

const botonBed = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 6),
	cancion = bedGoesUp,
	imgNormal = "btn_bgd_normal.png",
	imgIluminado = "btn_bgd_luz.png",
	seleccionado = true
	
)

const botonDance = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 5),
	cancion = danceTheNight,
	imgNormal = "btn_dtn_normal.jpg",
	imgIluminado = "btn_dtn_luz.jpg"
)

const botonChained = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 4),
	cancion = chainedToTheRhythm,
	imgNormal = "btn_ctr_normal.jpg",
	imgIluminado = "btn_ctr_luz.jpg"
)

const botonFeelGood = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 3),
	cancion = feelGoodInc,
	imgNormal = "btn_fgi_normal.jpg",
	imgIluminado = "btn_fgi_luz.jpg"
)

object marcadorDeCombo {
	method position() = game.at(1, 8)
	method text() = combo.texto()
	method textColor() = blanco
}

// Avisa mientras la nota amarilla tiene prendido el bonus
object cartelDeBonus {
	const property position = game.at(0, 7)

	method image() = 
		if (combo.multiplicador() <= 1) {
			"bonus/bonus_apagado.png"
		} else {
			"bonus/bonus_" + combo.multiplicador() + ".png"
		}
}


const marcador = new Marcador(
	position = game.at(1, 9),
	prefijo = "PUNTAJE: ",
	color = blanco
)

const puntajeFinal = new Marcador(
	position = game.at(7.3, 5),
	prefijo = "PUNTAJE: ",
	color = blanco
)


class BotonDificultad {
	const property position
	const property dificultad
	const textoNormal
	const textoIluminado
	var property seleccionado = false

	method image() = if (seleccionado) textoIluminado else textoNormal
}

const botonFacil = new BotonDificultad(
	position = new PosicionPrecisa(x = 5.4, y = 6),
	dificultad = facil,
	textoNormal = "btn_facil_normal.png",
	textoIluminado = "btn_facil_luz.png",
	seleccionado = true
)

const botonNormal = new BotonDificultad(
	position = new PosicionPrecisa(x = 5.4, y = 5),
	dificultad = normal,
	textoNormal = "btn_normal_normal.png",
	textoIluminado = "btn_normal_luz.png"
)

const botonDificil = new BotonDificultad(
	position = new PosicionPrecisa(x = 5.4, y = 4),
	dificultad = dificil,
	textoNormal = "btn_dificil_normal.png",
	textoIluminado = "btn_dificil_luz.png"
)

const botonExperto = new BotonDificultad(
	position = new PosicionPrecisa(x = 5.4, y = 3),
	dificultad = experto,
	textoNormal = "btn_experto_normal.png",
	textoIluminado = "btn_experto_luz.png"
)

object bannerConfiguracion {
	method position() = game.at(4, 3)
	method image() = "banner_configuracion.png"

}

object tuercaConfiguracion {
	const property position = game.at(13, 0)
	const imgNormal = "tuerca.png"
	const imgIluminado = "tuerca_luz.png"
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
	method confirmar() {
		juego.irA(menuConfiguracion)
	}
}

object cartelDePrecision {
	const property position = new PosicionPrecisa(x = 10.6, y = 7.9)
	var imagenActual = "vacio.png" 

	method image() = imagenActual

	method perfecto() { imagenActual = "perfecto.png" }
	method bien() { imagenActual = "bien.png" }
	method mal() { imagenActual = "mal.png" }
	method fallaste() { imagenActual = "fallaste.png" }
	method limpiar() { imagenActual = "vacio.png" }
}

object trofeoRanking {
	const property position = game.at(1, 0)
	const imgNormal = "trofeo_normal.png"
	const imgIluminado = "trofeo_luz.png"
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
	
	method confirmar() {
		juego.irA(ranking)
	}
}
object bannerRanking {
	method position() = game.at(4, 1)
	method image() = "banner_ranking3.png" 
}

object robot {
	const property position = new PosicionPrecisa(x = 10.8, y = 8.1)
	const imagenes = [
        "bot/robot_contento.png", 
        "bot/robot_duda.png", 
        "bot/robot_enojo.png", 
        "bot/robot_serio.png"
    ]
    var indice = 0

    method image() = imagenes.get(indice)

    method siguiente() {
        indice = (indice + 1) % imagenes.size()
    }

    method reiniciar() {
        indice = 0
    }
}

// Clase base para las posiciones visuales del ranking
class PosicionRanking {
	const property position
	var property image = "btn_normal.png"
}

object posicionUno inherits PosicionRanking(position = new PosicionPrecisa(x = 5.4, y = 5)) {}
object posicionDos inherits PosicionRanking(position = new PosicionPrecisa(x = 5.4, y = 4)) {}
object posicionTres inherits PosicionRanking(position = new PosicionPrecisa(x = 5.4, y = 3)) {}
object posicionCuatro inherits PosicionRanking(position = new PosicionPrecisa(x = 5.4, y = 2)) {}
object posicionCinco inherits PosicionRanking(position = new PosicionPrecisa(x = 5.4, y = 1)) {}

// Clase para los textos del ranking
class CartelRanking {
	const property position
	var property text = ""
	method textColor() = blanco
}

object cartelRanking1 inherits CartelRanking(position = new PosicionPrecisa(x = 7.5, y = 4.8)) {}
object cartelRanking2 inherits CartelRanking(position = new PosicionPrecisa(x = 7.5, y = 3.8)) {}
object cartelRanking3 inherits CartelRanking(position = new PosicionPrecisa(x = 7.5, y = 2.8)) {}
object cartelRanking4 inherits CartelRanking(position = new PosicionPrecisa(x = 7.5, y = 1.8)) {}
object cartelRanking5 inherits CartelRanking(position = new PosicionPrecisa(x = 7.5, y = 0.8)) {}