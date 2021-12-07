import numpy as np

def res_1(val):
    return True if val==0.5 else False
def res_2(val):
    return True if val== (3/4.0) else False

def res_3(val):
    return True if val== ((1/2.0)*(1/2.0)*(1/2.0)) else False

def res_4(val):
    #Probabiliti of have X in all events: 
    #(1/2)*(1/2)*(1/2)*(1/2) =(1/16)
    return True if val == ((1/16.0) + (1/16.0)) else False
def res_5(val):
    # cinco diferentes posibilidades de encontrar 3 heads
    return True if val == (5*(1/16.0)) else False
def res_6(val):
    #P(X_2 =H) =  P(x_2 = H |x_1 =H)*P(x_1 =H ) +  P(x_2 = H |x_1 =T)*P(x_1 =T )
    #P(X_2 =H) =  P(x_2 = H |x_1 =H)*P(x_1 =H ) +  (1 - P(x_2 = T |x_1 =T))*P(x_1 =T )
    return False if not np.allclose(val,  (0.9*0.5 + 0.2*0.5),-0.001,atol=1e-3) else True
def res_7(val):
    return True if val==0.2 else False

def res_8(val):
    return True if val==0.4 else False

def res_9(val):
    #P(D_2= sunny) = P(D2:sunny | D1:sunny)*P(D_1=sunny) +  P(D2:sunny | D1:ranny)*P(D_1=ranny)
    return False if not np.allclose(val, (0.9*0.8 +0.1*0.6) ,-0.001,atol=1e-3) else True
   
    
def res_10(val):
    #P(D_2= sunny) = P(D2:sunny | D1:sunny)*P(D_1=sunny) +  P(D2:sunny | D1:ranny)*P(D_1=ranny)
    return False if not np.allclose(val, (0.78*0.8 +0.22*0.6)  ,-0.001,atol=1e-3) else True

def result_ca1(val):
    return True if val==0.99 else False

def result_ca2(p_yesc, p_notc, p_yesnegc, p_notnegc):
    return True if (p_yesc== 0.009 and p_notc == 0.001 and p_yesnegc == 0.198 and p_notnegc ==0.792) else False
    
def result_ca3(val):
    # P(+,C) = P(+,C)/(P(+,C) + P(+,\negC))
    return False if not np.allclose(val, (0.009/(0.009 + 0.198))  ,-0.001,atol=1e-3) else True
    
    




 
    
