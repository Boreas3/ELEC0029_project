import numpy as np
f=open("G:\\Mon Drive\\newcyclecode\\test_folder\\incpower.txt", "r")
V_B101 = np.zeros(101)
V_B102 = np.zeros(101)
V_B103 = np.zeros(101)
V_B106 = np.zeros(101)
fl =f.readlines()
i = 0
for x in fl:
    y = x.split() 
    if not y:
        pass
    else:
        if y[0] == 'voltage':
            if y[3] == 'B101':
                i += 1
                V_B101[i] = y[5]
            if y[3] == 'B102':
                V_B102[i] = y[5]
            if y[3] == 'B103':
                V_B103[i] = y[5]
            if y[3] == 'B106':
                V_B106[i] = y[5]
print(V_B10)

