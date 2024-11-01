class Nave {
  var velocidad = 0 
  var direccion = 0
  var combustible = 0

  method acelerar(cantidad) {
    velocidad = 100000.min(velocidad + cantidad)
  }
  method desacelerar(cantidad) {
    velocidad = 0.max(velocidad - cantidad)
  }
  method irHaciaElSol(){
    direccion = 10
  }
  method escaparDelSol(){
    direccion -= 10
  }
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  method acercarseUnPocoAlSol() {
    direccion = 10.min(direccion - 1) 
  }
  method alejarseUnPocoDelSol() {
    direccion = (-10).min(direccion - 1)
  }
  method prepararViaje() 
  
  method cargarCombustible(cantidad) {
    combustible += cantidad
  }
  method desCargarCombustible(cuanto) {
    combustible = 0.max(combustible - cuanto)
  }
  method accionAdicionalAlViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method estaTranquila() = combustible >= 4000 and velocidad <= 12000
  method recibirAmenza() {
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar()
  method relajo() = self.estaTranquila() and self.pocaActividad()
  method pocaActividad() 
}

class naveBaliza inherits Nave {
  var colorBaliza = "verde"
  var cambioColor = false

  method cambiarColorDeBaliza(colorNuevo) {
    if (not ["verde", "rojo" , "azul"].contains(colorNuevo)) 
      self.error("Color no permitido")
    colorBaliza = colorNuevo
    cambioColor = true
    }
  override method prepararViaje() {
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.accionAdicionalAlViaje()
  }
  override method estaTranquila() = super() and colorBaliza != "rojo"
  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
  override method pocaActividad() = not cambioColor
}

class navePasajero inherits Nave {
  var cantidadPasajeros = 0
  var racionesComida = 0
  var racionesBebidas = 0
  var cantRacionesServidas = 0

  method agregarPasajeros(cantidad) {
    cantidadPasajeros = cantidadPasajeros + cantidad
  }
  method vaciar() {
    cantidadPasajeros = 0
  }
  method cargarComida(cantidad) {
    racionesComida += cantidad
  }
  method cargarBebida(cantidad) {
    racionesBebidas += cantidad
  }
  override method prepararViaje() {
    self.cargarComida(4 * cantidadPasajeros)
    self.cargarBebida(6 * cantidadPasajeros)
    self.acercarseUnPocoAlSol()
    self.accionAdicionalAlViaje()
  }
  override method escapar(){
    self.acelerar(velocidad)
  }
  override method avisar(){
    racionesComida = 0.max(racionesComida - cantidadPasajeros)
    cantRacionesServidas = cantRacionesServidas + racionesComida
    racionesBebidas = 0.max(racionesBebidas - cantidadPasajeros * 2)
  }

  override method pocaActividad() = cantRacionesServidas < 50
}

class NaveCombate inherits Nave {
  const mensajes = []
  var estaInvisible = false
  var misilesDesplegados = false

  method ponerseVisible() {
    estaInvisible = false
  }
  method ponerseInvisible() {
    estaInvisible = true
  }
  method estaInvisible() = estaInvisible
  method desplegarMisiles() {
    misilesDesplegados = true
  }
  method replegarMisiles() {
    misilesDesplegados = false
  }
  method misilesDesplegados() = misilesDesplegados
  method emitirMensaje(unMensaje) {
    mensajes.add(unMensaje)
  }
  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method emitioMensaje(mensaje) = mensajes.contains(mensaje) 
  method esEscueta() = mensajes.all(m => m.size() <= 30)
  override method prepararViaje() {
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión.")
    self.accionAdicionalAlViaje()
  }
  override method accionAdicionalAlViaje() {
    super()
    self.acelerar(15000)
  }
  override method estaTranquila() = super() and not misilesDesplegados 
  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }
  override method pocaActividad() = true
}

class NaveSigilosa inherits NaveCombate {
  override method estaTranquila() = super() and not estaInvisible
  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}


class NaveHospital inherits NavePasajero {
  var quirofanosPreparados = false
  
  override method recibirAmenaza(){
    super()
    quirofanosPreparados = true
  }
}