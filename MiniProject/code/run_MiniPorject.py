""" running this script using subprocess to run Rscript for miniproject """
""" print the output and whether this script runs correctly"""


import subprocess as sp
import sys


"""define main function"""
def main(argv):

    ''' processing the R script to handle the data '''       
    p1 = sp.Popen(["Rscript", "data.R"], stdout=sp.PIPE, stderr=sp.PIPE) 
    res1 = p1.communicate()
    print("stdout:")
    print(res1[0].decode(encoding='utf-8'))
    if p1.returncode == 0:
        print("|========================================|\n Dealing with data Success! \n|========================================|")
    else:
        print("Error:", res1[0].decode(encoding='utf-8'))
        print("stderr:")
        print(res1[1].decode(encoding='utf-8'))

    
    ''' processing the R script to fit the Gompertz model'''
    p2 = sp.Popen(["Rscript", "Gompertz.R"], stdout=sp.PIPE, stderr=sp.PIPE) 
    res2 = p2.communicate()
    print("stdout:")
    print(res2[0].decode(encoding='utf-8'))
    if p2.returncode == 0:
        print("|========================================|\n Gompertz Model fitting Success! \n|========================================|")
    else:
        print("Error:", res2[0].decode(encoding='utf-8'))
        print("stderr:")
        print(res2[1].decode(encoding='utf-8'))
    

    ''' processing the R script to fit the logistic model'''
    p3 = sp.Popen(["Rscript", "Logistic.R"], stdout=sp.PIPE, stderr=sp.PIPE) 
    res3 = p3.communicate()
    print("stdout:")
    print(res3[0].decode(encoding='utf-8'))
    if p3.returncode == 0:
        print("|========================================|\n Logistic Model fitting Success! \n|========================================|")
    else:
        print("Error:", res3[0].decode(encoding='utf-8'))
        print("stderr:")
        print(res3[1].decode(encoding='utf-8'))


    ''' processing the R script to compare the model and plot '''
    p4 = sp.Popen(["Rscript", "Compare_Models_and_plot.R"], stdout=sp.PIPE, stderr=sp.PIPE) 
    res4 = p4.communicate()
    print("stdout:")
    print(res4[0].decode(encoding='utf-8'))
    if p4.returncode == 0:
        print("|========================================|\n Comparing Models Success! \n|========================================|")
    else:
        print("Error:", res4[0].decode(encoding='utf-8'))
        print("stderr:")
        print(res4[1].decode(encoding='utf-8'))


    ''' processing the tex script to generate the PDF file '''
    p5 = sp.Popen(["bash", "Compile_Latex.sh"], stdout = sp.PIPE, stderr = sp.PIPE)
    res5 = p5.communicate()
    print("stdout:")
    print(res5[0].decode(encoding='utf-8'))
    if p5.returncode == 0:
        print("|========================================|\n Compile Latex Done! \n|========================================|")
    else:
        print("Error:", res5[0].decode(encoding='utf-8'))
        print("stderr:")
        print(res5[1].decode(encoding='utf-8'))


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)