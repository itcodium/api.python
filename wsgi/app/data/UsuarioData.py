import sys
import mysql.connector
from  app.data import Database

class UsuarioData(Database):
	value = ""
	def __init__(self):
		print ('- Data.usuario')
	