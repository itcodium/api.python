from flask import jsonify
from flask_json import JsonError
from .support_jsonp import support_jsonp_error

 

class CustomException():
    
    def showCustomException(self,err,parameters):
        print("#SCE1") 
        status=500
        if len(err.args)==1:
            if str(type(err))=="<class 'NameError'>":
                data={"status":"ERROR", "message": str(err).replace("'","")}
            else:    
                data={"status":"ERROR", "message": err.args[0]}
            return support_jsonp_error(data,parameters) 
        if len(err.args)>1:
            if err.args[1]=="A0000":
                status=401
        data={"status":"ERROR", "message": err.args[0],"error_code": err.args[1]}
        error_data= jsonify(data) 
        return support_jsonp_error(data,parameters) 


'''
class CustomException():
    def showCustomException(self,err,parameters):
        print("#SCE1") 
        status=500
        if len(err.args)==1:
            print("#SCE2",type(err),str(err).replace("'",""))
            if str(type(err))=="<class 'NameError'>":
                data={"status":"ERROR", "message": str(err).replace("'","")}
                print("#Error",data)
            else:    
                data={"status":"ERROR", "message": err.args[0]}

            return support_jsonp_error(data,parameters) # 
            #raise JsonError(status_=500,status="ERROR",message= err.args[0]) 
        print("#SCE3")     
        if len(err.args)>1:
            if err.args[1]=="A0000":
                status=401
        print("#SCE4")         
        #raise JsonError(status_=200,status="ERROR",message= err.args[0],error_code= err.args[1])
        data={"status":"ERROR", "message": err.args[0],"error_code": err.args[1]}
        error_data= jsonify(data)  #jsonify(status="ERROR",message=err.args[0],error_code=err.args[1])
        return support_jsonp_error(data,parameters) # 
               
        #return "{status:\"ERROR\",message:\""+ err.args[0]+"\",error_code:\""+ err.args[1]+"\"}"


'''