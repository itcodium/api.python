import os
import sys
import inspect
import datetime
# Get the current folder, which is the input folder
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
previous_folder = os.sep.join(folder_parts[0:-1])


sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)



from ${Package}.common import ${ClassName}Item
from ${Package}.bus import ${ClassName}Bus

cBus=${ClassName}Bus()
item=${ClassName}Item()

${Params}

print ("0)------------------ Insert -------------------------")
print (cBus.insert(item))

print ("1)------------------- GetAll ------------------------")
items=cBus.getAll()
print ("1) 	",items)

print ("2)------------------ GetById ------------------------")
getItem=cBus.getById(items[0]["id"])
print (getItem)

print ("3)------------------- Update ------------------------")

#item.id=getItem[0]["id"]
#datetime.datetime.now()

${Params}

cBus.update(item)
getItem=cBus.getById(items[0]["id"])
print (getItem)

print ("4)------------------ Delete ------------------------")
print (cBus.delete(item.id))
 