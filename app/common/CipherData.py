import os
from cryptography.fernet import Fernet


#http://docs.python-guide.org/en/latest/scenarios/crypto/
# $ pip install cryptography

class CipherData:
    SECRET_FERNET_KEY='BP04_l7C3wByNiEaEiseNiP0ZrqZ7s3qL-mkG8eHlJY='
    
    crypto = Fernet(SECRET_FERNET_KEY)
    def encrypt( self, data ):
        string_text = str( data)
        return self.crypto.encrypt(bytes(data.encode()))

    def decrypt( self, data ):
    	return self.crypto.decrypt(data)





