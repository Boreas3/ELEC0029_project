import numpy as np
import scipy.io as sio
test = sio.loadmat('matlab.mat')
Inc = np.array(test['Inc'])

deltaP = np.array(test['deltaP'])
deltaQ = np.array(test['deltaQ'])
deltaP_dic = dict(zip(Inc[0], deltaP))
deltaQ_dic = dict(zip(Inc[0], deltaQ))

text_file = open("inc.txt", "w")
for i in Inc[0]:
    text_file.write('increase load {:}%\n'.format(i*100-100))
    # text_file.write('D1\n')
    # text_file.write('B101\n')
    # text_file.write('{:} {:}\n'.format(deltaP_dic[i][0], deltaQ_dic[i][0]))
    # text_file.write('D1\n')
    # text_file.write('B102\n')
    # text_file.write('{:} {:}\n'.format(deltaP_dic[i][1], deltaQ_dic[i][1]))
    # text_file.write('D1\n')
    # text_file.write('B103\n')
    # text_file.write('{:} {:}\n'.format(deltaP_dic[i][2], deltaQ_dic[i][2]))
    # text_file.write('D1\n')
    # text_file.write('B106\n')
    # text_file.write('{:} {:}\n'.format(deltaP_dic[i][3], deltaQ_dic[i][3]))
    # text_file.write('BT\n')
    # text_file.write('L306-304\n')
    text_file.write('end_contingency\n')
text_file.close()