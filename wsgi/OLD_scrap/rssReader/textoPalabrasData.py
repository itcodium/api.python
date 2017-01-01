import os
import sys
import inspect

current_folder = os.path.realpath(
    os.path.abspath(
        os.path.split(
            inspect.getfile(
                inspect.currentframe()
            )
     )[0]
   )
)
folder_parts = current_folder.split(os.sep)
previous_folder = os.sep.join(folder_parts[0:-2])
sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)

import sys
import mysql.connector
from  scrap.db import StopwordsDataBase

class TextoPalabrasData(StopwordsDataBase):
	value = ""
	def setValue(self,value):
		self.value = value
	def connect(self):
		self.cnn.connect()
	def close(self):
		self.cnn.close()	
	def insert(self,texto_id,palabra,repeticiones,orden,creado_por):
		self.cnn.connect()
		cursor = self.cnn.cursor()
		try:
			cursor.callproc('textoPalabrasInsert',[texto_id,palabra,repeticiones,orden,creado_por])
			self.cnn.commit()
		except mysql.connector.Error as err:
			print("- Noticias Insert -",err)
		except:
			print('- Noticias Insert - Unexpected error:', sys.exc_info()[0])
			raise
		finally:
			cursor.close()
			self.cnn.close()		

class TextoData(StopwordsDataBase):
	value = ""
	def setValue(self,value):
		self.value = value

	def SetFechaProceso(self,texto_id):
		self.cnn.connect()
		cursor = self.cnn.cursor()
		try:
			cursor.callproc('textoSetFechaProceso',[texto_id])
			self.cnn.commit()
		except mysql.connector.Error as err:
			print("- TextoData textoSetFechaProceso -",err)
		except:
			print('- TextoData textoSetFechaProceso - Unexpected error:', sys.exc_info()[0])
			raise
		finally:
			cursor.close()
			self.cnn.close()			