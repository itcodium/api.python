class ErrorItem():
	id_error=0
	lang=""
	value=""
	message=""
	fecha_creacion=None

	def __str__(self):
		return '(id_error: %s,lang: %s,value: %s,message: %s,fecha_creacion: %s' %(self.id_error,self.lang,self.value,self.message,self.fecha_creacion)



