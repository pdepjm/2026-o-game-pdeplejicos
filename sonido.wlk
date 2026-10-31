import wollok.game.*

object reproductor {
	var proveedor = game

	method proveedor(unProveedor) {
		proveedor = unProveedor
	}

	method sonido(archivo) = proveedor.sound(archivo)
}

object sonidoMudo {
	method play() {}
	method stop() {}
	method volume(_volumen) {}
}

object proveedorMudo {
	method sound(_archivo) = sonidoMudo
}

// Los dos sonidos cortos de la partida. Se piden de nuevo en cada golpe porque
// un Sound de Wollok no se puede volver a reproducir una vez que sono.
object efectos {
	method sonoUnAcierto() {
		reproductor.sonido("acierto.ogg").play()
	}

	method sonoUnError() {
		reproductor.sonido("error.ogg").play()
	}
}
