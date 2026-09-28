import nota.*

// Cuando se llama, con que archivo suena y en que momentos hay que tocar.
// OJO: este archivo esta generado, no se edita a mano. Los tiempos estan en
// milisegundos desde que arranca el audio y salen de tools/generar_cancion.py
object bedGoesUp {
	method nombre() = "Bed Goes Up"
	method artista() = "Dankmus"
	method archivo() = "bedGoesUp.ogg"
	method duracion() = 30000

	method notas() = [
		new Nota(tiempo = 3503),
		new Nota(tiempo = 3947),
		new Nota(tiempo = 4614),
		new Nota(tiempo = 5059),
		new Nota(tiempo = 5503),
		new Nota(tiempo = 5725),
		new Nota(tiempo = 7059),
		new Nota(tiempo = 7503),
		new Nota(tiempo = 8170),
		new Nota(tiempo = 8614),
		new Nota(tiempo = 9059),
		new Nota(tiempo = 9503),
		new Nota(tiempo = 9947),
		new Nota(tiempo = 10392),
		new Nota(tiempo = 10614),
		new Nota(tiempo = 11059),
		new Nota(tiempo = 11725),
		new Nota(tiempo = 12170),
		new Nota(tiempo = 12614),
		new Nota(tiempo = 12836),
		new Nota(tiempo = 14170),
		new Nota(tiempo = 14614),
		new Nota(tiempo = 15281),
		new Nota(tiempo = 15725),
		new Nota(tiempo = 16170),
		new Nota(tiempo = 16614),
		new Nota(tiempo = 17059),
		new Nota(tiempo = 17503),
		new Nota(tiempo = 17725),
		new Nota(tiempo = 18170),
		new Nota(tiempo = 18836),
		new Nota(tiempo = 19281),
		new Nota(tiempo = 19725),
		new Nota(tiempo = 19947),
		new Nota(tiempo = 21281),
		new Nota(tiempo = 21725),
		new Nota(tiempo = 22392),
		new Nota(tiempo = 22836),
		new NotaSostenida(comienzo = new Nota(tiempo = 23059), duracion = 268),
		new Nota(tiempo = 23392),
		new Nota(tiempo = 23725),
		new Nota(tiempo = 23947),
		new Nota(tiempo = 24836),
		new Nota(tiempo = 25281),
		new NotaSostenida(comienzo = new Nota(tiempo = 25725), duracion = 380),
		new Nota(tiempo = 26170),
		new Nota(tiempo = 26614),
		new Nota(tiempo = 27059),
		new Nota(tiempo = 27503),
		new Nota(tiempo = 27947),
		new Nota(tiempo = 28392),
		new Nota(tiempo = 28836),
		new NotaSostenida(comienzo = new Nota(tiempo = 29281), duracion = 379),
		new Nota(tiempo = 29725)
	]

}
