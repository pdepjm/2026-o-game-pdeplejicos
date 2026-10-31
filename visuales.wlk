import wollok.game.*
import partida.*
import pista.*
import combo.*
import bonus.*
import colores.*
import canciones.*
import dificultad.*

object bannerFinal {
	method position() = game.at(4, 3)
	method image() = "banner_final.png"
}

object bannerInicio {
	method position() = game.at(4, 3)
	method image() = "banner_inicio.png"
}

object bannerMenuInicial {
	method position() = game.at(4, 3)
	method image() = "banner_menu_inicial.png"
}

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

// Una imagen que se decide cada vez que se dibuja
class MuestraQueCambia {
	const property position
	const imagen

	method image() = imagen.apply()
}

class Marcador {
	const property position
	const prefijo
	var property color = blanco

	method text() = prefijo + partida.puntaje().toString()
	method textColor() = color
}

// Cada boton del menu conoce la cancion que arranca
class BotonNivel {
	const property position
	const property cancion
	const imgNormal
	const imgIluminado
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
}

// Un cartel cuyo texto se calcula cada vez que se dibuja
class CartelQueCambia {
	const property position
	const texto

	var property color = blanco

	method text() = texto.apply()
	method textColor() = color
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
	imgNormal = "btn_danceTheNight_normal.png",
	imgIluminado = "btn_danceTheNight_luz.png"
)

const botonChained = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 4),
	cancion = chainedToTheRhythm,
	imgNormal = "btn_chainedToTheRhythm_normal.png",
	imgIluminado = "btn_chainedToTheRhythm_luz.png"
)

const botonFeelGood = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 3),
	cancion = feelGoodInc,
	imgNormal = "btn_feelGoodInc_normal.png",
	imgIluminado = "btn_feelGoodInc_luz.png"
)

// El multiplicador que tenes ahora
object marcadorDeCombo {
	method position() = game.at(1, 8)
	method text() = combo.texto()
	method textColor() = combo.color()
}

// Avisa mientras la nota amarilla tiene prendido el bonus
object cartelDeBonus {
	method position() = game.at(1, 7)
	method text() = bonus.texto()
	method textColor() = amarillo
}

// Lo ultimo que te paso se enciende en la tele que esta dibujada en el fondo
const cartelDePrecision = new MuestraQueCambia(
	position = new PosicionPrecisa(x = 10.6, y = 7.9),
	imagen = { partida.ultimoResultado().imagen() }
)

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
