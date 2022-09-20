import os
from numpy import loadtxt


os.system("./ls_script.sh")

old_names = []
new_names = []

with open("old_names.txt") as file:
    for line in file:
        old_names.append(line.rstrip())




forbiden_chars = ['!','@','#','$','^','&','*','(',')','%']

rename_files = False;

try:
	f = open("rename_files.sh","x")
	rename_files = True;
except:
	print("File \'rename_files.sh\' exists do you want to overwrite the file? [y/n]")
	ans = input()
	if(ans.lower() == 'y'):
		os.remove("rename_files.sh")
		print('rename_files.sh has been overwritten')
		f = open("rename_files.sh","x")
		rename_files = True;
	elif(ans.lower() == 'n'):
		print("file \'rename_files.sh\' needs to be deleted or renamed\nterminating ...")
	else:
		print("invalid input file \'rename_files.sh\' needs to be deleted or renamed\nterminating ...")

if(rename_files):
    f.write("#!/bin/bash\n")
    for name in old_names:
        upper_chars = []
        first_letter = False
        for f_char in forbiden_chars:
            if(f_char in name):
                name = name.replace(f_char,'')
        for i in range(len(name)):
            if(name[i].isupper()):
                if(i == 0):
                    first_letter = True
                upper_chars.append(name[i])                                                
        for i in range(len(upper_chars)):
            if(i == 0):
                name = name.replace(upper_chars[i],upper_chars[i].lower()) if first_letter else name.replace(upper_chars[i],f"_{upper_chars[i].lower()}")    
            else:
                name = name.replace(upper_chars[i],f"_{upper_chars[i].lower()}") 
        new_names.append(name)        
    for i in range(len(old_names)):
        f.write(f"mv {old_names[i]} {new_names[i]}\n")
    f.close()
    print("Script for renaming files has been generated do you want to execute the script? (Strongly recommended to read the script) [y/n]")
    ans = input()
    if(ans.lower() == "y"):
        os.chmod("rename_files.sh",0o555)
        os.system("./rename_files.sh")
        print("Do you want to remove the temp files (\'rename_files.sh\' \'old_names.txt\')? [y/n]")
        ans = input()
        if(ans.lower() == "y"):
            os.remove("rename_files.sh")
            os.remove("old_names.txt")
        elif(ans.lower() == "n"):
            print("No temp files deleted")
        else:
            print("invalid input\nNo temp files deleted")

