import sys
from app.data import SessionKeysData
from app.bus import ErrorBus
from app.common import CipherData

class SessionKeysBus():
    sessionkeys = SessionKeysData()
    cBus=ErrorBus()
    def getSessionKeyByUser(self,usuario,password,lang):
        data = self.sessionkeys.getSessionKeyByUser(usuario,password,lang)
        test=CipherData()
        data[0]["uuid"]=test.encrypt(data[0]["uuid"]).decode()
        return data
    def getSessionkeysByUUID(self,uuid):
        return self.sessionkeys.getSessionkeysByUUID(uuid)
