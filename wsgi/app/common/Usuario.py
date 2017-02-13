class UsuarioItem():
	id_usuario=0
	usuario=""
	nombre=""
	apellido=""
	email=""
	password=""
	id_perfil=0
	vigencia_desde=None
	vigencia_hasta=None
	creado_por=""
	fecha_creacion=None
	modificado_por=""
	fecha_modificacion=None

	def __str__(self):
		return '(id_usuario: %s,usuario: %s,nombre: %s,apellido: %s,email: %s,password: %s,id_perfil: %s,vigencia_desde: %s,vigencia_hasta: %s,creado_por: %s,fecha_creacion: %s,modificado_por: %s,fecha_modificacion: %s' %(self.id_usuario,self.usuario,self.nombre,self.apellido,self.email,self.password,self.id_perfil,self.vigencia_desde,self.vigencia_hasta,self.creado_por,self.fecha_creacion,self.modificado_por,self.fecha_modificacion)



