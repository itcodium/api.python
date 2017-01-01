
class UsuarioItem():
	idNoticia=0
	idLink=0
	seccion=""
	fecha=""
	titulo=""
	volanta=""
	copete=""
	autor=""
	autor_mail=""
	autor_copete=""
	parrafos=""
	fecha_creacion=None
	fecha_modificacion=None
	link_images=[]
	user=""
	def __str__(self):
		return '(idNoticia: %s,idLink: %s, seccion:%s,fecha: %s,titulo: %s,volanta: %s,copete: %s,autor: %s,autor_mail: %s,autor_copete: %s,parrafos: %s)' %(self.idNoticia,self.idLink,self.seccion,self.fecha,self.titulo,self.volanta,self.copete,self.autor,self.autor_mail,self.autor_copete,self.parrafos)