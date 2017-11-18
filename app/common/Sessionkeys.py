class SessionKeysItem():
	uuid=""
	id_usuario=0
	usuario=""
	password=""
	expiration=None
	created=None

	def __str__(self):
		return '(uuid: %s,id_usuario: %s,expiration: %s,created: %s' %(self.uuid,self.id_usuario,self.expiration,self.created)



