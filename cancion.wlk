import nota.*

object cancionDeEjemplo {

	method nombre() = "Ritmo de prueba"

	method duracion() = 20000

	method tiempos() = [
		2000, 2500, 3000, 4000, 4500, 5000, 6000, 6400, 6800, 7200,
		8000, 9000, 9500, 10000, 11000, 11500, 12000, 13000, 14000, 14400,
		14800, 16000, 17000, 18000, 19000
	]

	method notas() = self.tiempos().map({ tiempo => new Nota(tiempo = tiempo) })

}
