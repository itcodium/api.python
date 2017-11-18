class PerfilItem():
	id_perfil=0
	perfil=""
	vigencia_desde=None
	vigencia_hasta=None
	creado_por=""
	fecha_creacion=None
	modificado_por=""
	fecha_modificacion=None

	def __str__(self):
		return '(id_perfil: %s,perfil: %s,vigencia_desde: %s,vigencia_hasta: %s,creado_por: %s,fecha_creacion: %s,modificado_por: %s,fecha_modificacion: %s' %(self.id_perfil,self.perfil,self.vigencia_desde,self.vigencia_hasta,self.creado_por,self.fecha_creacion,self.modificado_por,self.fecha_modificacion)



