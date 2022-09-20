import os
from numpy import loadtxt


os.system("./ls_script.sh")


out_arr = loadtxt('output.txt', dtype='str')

#myDataXd --> my_data_xd

for file in out_arr:
    d_file = file
    if(!file.islower()):
        for i in range(0,len(file))
            if(file[i].isupper()):
                
            else
                print()
    

