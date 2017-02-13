class PerfilModuloItem():
	id_perfil_modulo=0
	id_perfil=0
	id_modulo=0
	enanbled=0
	creado_por=""
	fecha_creacion=None
	modificado_por=""
	fecha_modificacion=None

	def __str__(self):
		return '(id_perfil_modulo: %s,id_perfil: %s,id_modulo: %s,enabled:%s,creado_por: %s,fecha_creacion: %s,modificado_por: %s,fecha_modificacion: %s' %(self.id_perfil_modulo,self.id_perfil,self.id_modulo,self.enabled,self.creado_por,self.fecha_creacion,self.modificado_por,self.fecha_modificacion)



