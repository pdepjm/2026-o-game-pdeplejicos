import wollok.game.*
import partida.*
import pista.*

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

class Marcador {
	const property position
	const prefijo
	var property color = blanco

	method text() = prefijo + partida.puntaje().toString()
	method textColor() = color
}

class BotonNivel {
	const property position
	const imgNormal
	const imgIluminado
	var property seleccionado = false

	method image() = if (seleccionado) imgIluminado else imgNormal
}

const botonBed = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 6),
	imgNormal = "btn_bgd_normal.png",
	imgIluminado = "btn_bgd_luz.png",
	seleccionado = true
)

const botonProx1 = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 5),
	imgNormal = "btn_prox_normal.png",
	imgIluminado = "btn_prox_luz.png"
)

const botonProx2 = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 4),
	imgNormal = "btn_prox_normal.png",
	imgIluminado = "btn_prox_luz.png"
)

const botonProx3 = new BotonNivel(
	position = new PosicionPrecisa(x = 5.4, y = 3),
	imgNormal = "btn_prox_normal.png",
	imgIluminado = "btn_prox_luz.png"
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
