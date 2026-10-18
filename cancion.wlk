import nota.*
import pista.*

// Como se llama, con que archivo suena y que notas hay que tocar.
//
// OJO: este archivo esta generado, no se edita a mano. Los tiempos estan en
// milisegundos desde que arranca el audio y salen de un archivo .chart de Clone
// Hero, pasado por un script aparte (primeros 30 segundos). Los carriles se
// repartieron con un patron, porque el chart que teniamos es de un solo traste.
// Las notas van ordenadas por tiempo, y la partida cuenta con eso.
object bedGoesUp {
	method nombre() = "Bed Goes Up"
	method artista() = "Dankmus"
	method archivo() = "bedGoesUp.ogg"
	method duracion() = 30000

	// Van en orden de tiempo (ver la nota de arriba)
	method notas() = [
		new NotaSimple(tiempo = 3503, carril = carrilDerecha),
		new NotaSimple(tiempo = 3947, carril = carrilArriba),
		new NotaSimple(tiempo = 4614, carril = carrilArriba),
		new NotaSimple(tiempo = 5059, carril = carrilArriba),
		new NotaSimple(tiempo = 5503, carril = carrilAbajo),
		new NotaSimple(tiempo = 5725, carril = carrilIzquierda),
		new NotaTrampa(tiempo = 6392, carril = carrilArriba),
		new NotaSimple(tiempo = 7059, carril = carrilAbajo),
		new NotaSimple(tiempo = 7503, carril = carrilIzquierda),
		new NotaSimple(tiempo = 8170, carril = carrilIzquierda),
		new NotaSimple(tiempo = 8614, carril = carrilDerecha),
		new NotaSimple(tiempo = 9059, carril = carrilDerecha),
		new NotaSimple(tiempo = 9503, carril = carrilArriba),
		new NotaSimple(tiempo = 9947, carril = carrilAbajo),
		new NotaSimple(tiempo = 10392, carril = carrilAbajo),
		new NotaSimple(tiempo = 10614, carril = carrilIzquierda),
		new NotaSimple(tiempo = 11059, carril = carrilIzquierda),
		new NotaSimple(tiempo = 11725, carril = carrilDerecha),
		new NotaSimple(tiempo = 12170, carril = carrilDerecha),
		new NotaSimple(tiempo = 12614, carril = carrilArriba),
		new NotaSimple(tiempo = 12836, carril = carrilAbajo),
		new NotaSimple(tiempo = 14170, carril = carrilArriba),
		new NotaSimple(tiempo = 14614, carril = carrilAbajo),
		new NotaTrampa(tiempo = 14947, carril = carrilDerecha),
		new NotaSimple(tiempo = 15281, carril = carrilAbajo),
		new NotaSimple(tiempo = 15725, carril = carrilIzquierda),
		new NotaSimple(tiempo = 16170, carril = carrilIzquierda),
		new NotaSimple(tiempo = 16614, carril = carrilDerecha),
		new NotaSimple(tiempo = 17059, carril = carrilDerecha),
		new NotaSimple(tiempo = 17503, carril = carrilArriba),
		new NotaSimple(tiempo = 17725, carril = carrilAbajo),
		new NotaSimple(tiempo = 18170, carril = carrilAbajo),
		new NotaTrampa(tiempo = 18503, carril = carrilDerecha),
		new NotaSimple(tiempo = 18836, carril = carrilIzquierda),
		new NotaSimple(tiempo = 19281, carril = carrilIzquierda),
		new NotaSimple(tiempo = 19725, carril = carrilDerecha),
		new NotaSimple(tiempo = 19947, carril = carrilArriba),
		new NotaSimple(tiempo = 21281, carril = carrilDerecha),
		new NotaSimple(tiempo = 21725, carril = carrilArriba),
		new NotaSimple(tiempo = 22392, carril = carrilArriba),
		new NotaSimple(tiempo = 22836, carril = carrilAbajo),
		new NotaSostenida(tiempo = 23059, carril = carrilAbajo, duracion = 268),
		new NotaSimple(tiempo = 23392, carril = carrilIzquierda),
		new NotaSimple(tiempo = 23725, carril = carrilDerecha),
		new NotaSimple(tiempo = 23947, carril = carrilArriba),
		new NotaSimple(tiempo = 24836, carril = carrilArriba),
		new NotaSimple(tiempo = 25281, carril = carrilArriba),
		new NotaSostenida(tiempo = 25725, carril = carrilAbajo, duracion = 380),
		new NotaSimple(tiempo = 26170, carril = carrilAbajo),
		new NotaTrampa(tiempo = 26392, carril = carrilDerecha),
		new NotaSimple(tiempo = 26614, carril = carrilIzquierda),
		new NotaSimple(tiempo = 27059, carril = carrilIzquierda),
		new NotaSimple(tiempo = 27503, carril = carrilDerecha),
		new NotaSimple(tiempo = 27947, carril = carrilArriba),
		new NotaSimple(tiempo = 28392, carril = carrilArriba),
		new NotaSimple(tiempo = 28836, carril = carrilAbajo),
		new NotaSostenida(tiempo = 29281, carril = carrilAbajo, duracion = 379),
		new NotaSimple(tiempo = 29725, carril = carrilIzquierda)
	]
}
