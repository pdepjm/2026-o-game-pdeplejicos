import wollok.game.*
import partida.*
import pista.*
import combo.*
import bonus.*
import cancion.*
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
	const property dificultad
	const imgNormal
	const imgIluminado
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
}

// Un cartel cuyo texto se calcula cada vez que se dibuja
class CartelQueCambia {
	const property position
	const texto

	method text() = texto.apply()
	method textColor() = blanco
}

const botonBed = new BotonNivel(
	dificultad = facil,
	position = new PosicionPrecisa(x = 5.4, y = 6),
	cancion = bedGoesUp,
	imgNormal = "btn_bgd_normal.png",
	imgIluminado = "btn_bgd_luz.png",
	seleccionado = true
)

const botonDance = new BotonNivel(
	dificultad = normal,
	position = new PosicionPrecisa(x = 5.4, y = 5),
	cancion = danceTheNight,
	imgNormal = "btn_danceTheNight_normal.png",
	imgIluminado = "btn_danceTheNight_luz.png"
)

const botonChained = new BotonNivel(
	dificultad = dificil,
	position = new PosicionPrecisa(x = 5.4, y = 4),
	cancion = chainedToTheRhythm,
	imgNormal = "btn_chainedToTheRhythm_normal.png",
	imgIluminado = "btn_chainedToTheRhythm_luz.png"
)

const botonFeelGood = new BotonNivel(
	dificultad = experto,
	position = new PosicionPrecisa(x = 5.4, y = 3),
	cancion = feelGoodInc,
	imgNormal = "btn_feelGoodInc_normal.png",
	imgIluminado = "btn_feelGoodInc_luz.png"
)

// El multiplicador que tenes ahora
object marcadorDeCombo {
	method position() = game.at(1, 8)
	method text() = combo.texto()
	method textColor() = blanco
}

// Avisa mientras la nota amarilla tiene prendido el bonus
object cartelDeBonus {
	method position() = game.at(1, 7)
	method text() = bonus.texto()
	method textColor() = blanco
}

// Lo ultimo que te paso: PERFECTO, BIEN, APENAS, MAL o TRAMPA!
object cartelDePrecision {
	method position() = game.at(12, 5)
	method text() = partida.ultimoResultado().texto()
	method textColor() = blanco
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
