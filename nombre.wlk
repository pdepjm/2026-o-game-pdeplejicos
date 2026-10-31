// Las tres letras que el jugador deja en la tabla, estilo arcade. Se acuerda de
// las ultimas, asi la proxima vez no hay que volver a escribirlas.
object nombre {
	const abecedario = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	const largo = 3

	var property texto = "AAA"

	var posicion = 0

	// Como se ve mientras lo escribis: la letra que estas cambiando va marcada
	method textoEnEdicion() = (0 .. (largo - 1)).map({ lugar => self.comoSeVe(lugar) }).join(" ")

	method comoSeVe(lugar) =
		if (lugar == posicion) "[" + texto.charAt(lugar) + "]" else " " + texto.charAt(lugar) + " "

	method siguienteLetra() {
		self.correrLetra(1)
	}

	method letraAnterior() {
		self.correrLetra(-1)
	}

	method correrLetra(cuanto) {
		const actual = abecedario.indexOf(texto.charAt(posicion))
		const nueva = abecedario.charAt((actual + cuanto + abecedario.size()) % abecedario.size())
		texto = (0 .. (largo - 1)).map({ lugar =>
			if (lugar == posicion) nueva else texto.charAt(lugar)
		}).join("")
	}

	method irALaDerecha() {
		posicion = (posicion + 1).min(largo - 1)
	}

	method irALaIzquierda() {
		posicion = (posicion - 1).max(0)
	}
}
