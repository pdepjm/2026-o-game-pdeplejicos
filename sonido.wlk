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
