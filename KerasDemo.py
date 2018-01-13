#This is a code showing how the data for figure 2 in https://arxiv.org/pdf/1708.03395.pdf have been generated
#More precisly, the inset in the last figure
#This is with 200 epochs, but 1000 epochs were used in the paper
#This is a 2-layer network attempting to classify a rule

import time
import numpy as np
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score

def heavy(x,a,b):
    sol=-1;
    if (x>a)&(x<b):
        sol=1;
    return sol

#This generate data according to the Symmetric door problem
def generate_binary_door(dim,alpha,kappa):
    nsample=int(2*dim*alpha)
    S_star=2*np.random.randint(0,2,dim)-1
    X=np.random.randn(nsample,dim);
    Z=np.dot(X,S_star)/np.sqrt(dim);
    for i in range(0,nsample):
        Z[i]=heavy(Z[i],-kappa,kappa)
    return X,Z


import keras
from keras.layers import Activation, Dense, Dropout
from keras.models import Sequential
from keras.optimizers import RMSprop
import numpy as np

N=2500
alphamin=1
alphamax=20
alpharange=range(alphamin,alphamax,1);
alpha_tab=np.zeros(alphamax);
loss_tab=np.zeros(alphamax);
acc_tab=np.zeros(alphamax);

inc=1;
for alpha in alpharange:
    X,y=generate_binary_door(N,alpha,0.674489)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.5, random_state=0)
    X_train_, X_valid, y_train_, y_valid = train_test_split(X_train, y_train, test_size=0.05, random_state=0)

    y_train_K = keras.utils.to_categorical(0.5*(y_train_+1),2)
    y_test_K = keras.utils.to_categorical(0.5*(y_test+1),2)
    y_valid_K = keras.utils.to_categorical(0.5*(y_valid+1),2)


    model = Sequential()
    model.add(Dense(64, activation='relu', input_shape=(N,)))
    model.add(Dropout(0.2))
    model.add(Dense(64, activation='sigmoid'))
    model.add(Dropout(0.2))
    #Dropout actually helps! Feel free to add more layer, here one has only 2 hidden layers (relu and sigmoids)
    model.add(Dense(2, activation='softmax'))

    model.compile(loss='categorical_crossentropy',optimizer=RMSprop(),metrics=['accuracy'])

    #This is with 200 epochs. We used 1000 epochs in the article. It seems that it takes time to espace the non informative region in the landscape.
    history = model.fit(X_train_, y_train_K,batch_size=1000,epochs=200,verbose=1,validation_data=(X_valid, y_valid_K))
    score = model.evaluate(X_test, y_test_K)
    score2 = model.evaluate(X_train_, y_train_K)

    print('Test loss:', score[0])
    print('Test accuracy:', score[1])
    alpha_tab[alpha]=alpha;
    loss_tab[alpha]=score2[0];
    acc_tab[alpha]=score[1];

print("Results for 2 hidden layers")
for alpha in alpharange:
    print(alpha_tab[alpha], " ", loss_tab[alpha] ," ", acc_tab[alpha])




