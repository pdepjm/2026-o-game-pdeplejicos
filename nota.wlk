import wollok.game.*
import pista.*
import reloj.*

class Nota {

	const tiempo

	method image() = "nota.png"

	method position() = game.at(pista.columna(), pista.filaPara(self.cuantoFalta()))

	method cuantoFalta() = tiempo - reloj.tiempo()

	method desfasaje() = self.cuantoFalta().abs()

	method estaAlAlcance(tolerancia) = self.desfasaje() <= tolerancia

	method sePaso(tolerancia) = self.cuantoFalta() < tolerancia.invert()

}
