class UsuarioItem():
	id=0
	nombre=""
	apellido=""
	usuario=""
	habilitado=0
	creado_por=""
	modificado_por=""
	fecha_creacion=None
	fecha_modificacion=None

	def __str__(self):
		return '(id: %s,nombre: %s,apellido: %s,usuario: %s,habilitado: %s,creado_por: %s,modificado_por: %s,fecha_creacion: %s,fecha_modificacion: %s' %(self.id,self.nombre,self.apellido,self.usuario,self.habilitado,self.creado_por,self.modificado_por,self.fecha_creacion,self.fecha_modificacion)



