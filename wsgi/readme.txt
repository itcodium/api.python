A. Packages python 2.7
	
	/test.py
		from folder_test.Sub_folder import DbClass
	/folder_test/__init__.py
		* el archivo init debe existir y puede estar vacio
		
	/folder_test/Sub_folder/db.py
	/folder_test/Sub_folder/__init__.py
	
			Contenido del archivo init
				from .db import DbClass
	
	Agregar en cada directorio un archivo:  __init__.py
	
	
B. Packages python 3.4
	
	/test.py
	/folder_test
	/folder_test/Sub_folder/db.py
	/folder_test/Sub_folder/__init__.py
	
	En python 3.4 no es necesario agragar el archivo "__init__.py" 
	en el directorio  /folder_test


0. Upgrade pip
	
	python -m pip install --upgrade pip

1. Installar mysql-connector
 
 	b. pip install mysql-connector-python (ver si es necesario)
 	   sudo pip install --allow-external mysql-connector-python mysql-connector-python
		P1G2ms77C3N4S

