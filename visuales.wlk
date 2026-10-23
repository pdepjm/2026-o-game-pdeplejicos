import wollok.game.*
import partida.*
import pista.*
import combo.*
import bonus.*
import juego.*
import canciones.*
import dificultad.*

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