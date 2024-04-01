import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from keras.layers import Conv3D, MaxPool3D, Flatten, Dense
from keras.layers import Dropout, Input, BatchNormalization,LeakyReLU
from sklearn.metrics import confusion_matrix, accuracy_score
from keras.losses import categorical_crossentropy,binary_crossentropy
from keras.optimizers import Adadelta,Adam,RMSprop
from keras.models import Model
from keras.activations import relu
import keras
import scipy.io as spio
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from keras.models import load_model
import keras_metrics as km 
from keras import models
from keras import layers
import keras_metrics as km
from sklearn.model_selection import train_test_split
plt.set_cmap('jet')

### Datasets loading 
X=np.load('FFT_2361/NEW_FBH_2361.npy')
X_Ref=np.load('FFT_2361/NEW_FBH_2361_ref.npy')
X=np.reshape(X, (85*51,2361))
X_Ref=np.reshape(X_Ref,(85*51,2361))
Targets=np.load("Whole_Testset.npy")
plt.imshow(Targets)

### Eneryg computation to check the dataset
def FBD(f1,f2):     
    FBDi=np.zeros([85,51])
    F_Res=125
    for i in range(85):
        for j in range(51):
            FBDi[i,j]=( np.sum(X[i,j,f1:f2+1]/X_Ref[i,j,f1:f2+1]) ) * (F_Res/(f2-f1))
    return FBDi

FBD_result=FBD(0,2360)
plt.imshow(FBD_result)
plt.show()

### Normalization
sc = StandardScaler()
X = sc.fit_transform(X)

### Using Elbow Method to specify the number of clusters 
wcss = []
for i in range(1, 6):
    kmeans = KMeans(n_clusters = i, init = 'k-means++', random_state = 42)
    kmeans.fit(X)
    wcss.append(kmeans.inertia_)
plt.plot(range(1, 6), wcss)
plt.title('The Elbow Method')
plt.xlabel('Number of clusters')
plt.ylabel('WCSS')
plt.show()

### K-means Implementation
kmeans=[]
y_kmeans=[]
for i in range(1,6):
    kmeans.append(KMeans(n_clusters = i+1, init = 'k-means++', random_state = 42))
    y_kmeans.append(kmeans[-1].fit_predict(X))

plt.imshow(np.reshape(y_kmeans[4],(85,51))) # Visualization the k-means results
plt.show()

### Determination of cluster numbers via PCA algorithm
X=np.load('FFT_2361/NEW_FBH_2361.npy')
X=X.reshape(1,85,51,2361)
pca = PCA(n_components = None)
X_train = pca.fit_transform(X)
explained_variance = pca.explained_variance_ratio_

kmeans=KMeans(n_clusters = 2, init = 'k-means++', random_state = 42)
y_kmeans=kmeans.fit_predict(X_train)

plt.plot(range(1, 2361), explained_variance[0:2360])
plt.title('PCA')
plt.xlabel('n_components')
plt.ylabel('variance_ratio')
plt.show()
plt.imshow(np.reshape(y_kmeans,(85,51)))

### Require fucntions for train and test set generation
def zero_pad(X, pad):   
    X_pad = np.pad(X,((0,0),(pad,pad),(pad,pad),(0,0)),mode='constant',constant_values=(0,0)) 
    return X_pad

def conv_forward(A_prev,stride,pad,f,n_c):   
    Z=[]
    (m, n_H_prev, n_W_prev) = A_prev.shape[0],A_prev.shape[1],A_prev.shape[2]
    (f, f) = f,f
    stride = stride
    pad = pad
    n_c=n_c
    n_H = int((n_H_prev-f+2*pad)/(stride))+1
    n_W =  int((n_W_prev-f+2*pad)/(stride))+1
    A_prev_pad = zero_pad(A_prev,pad)
    
    for i in range(m):     # loop over the batch of training examples
        a_prev_pad = A_prev_pad[i,:,:,:]   # Select ith training example's padded activation
        for h in range(n_H):  # loop over vertical axis of the output volume
            vert_start = h*stride
            vert_end = h*stride+f
            
            for w in range(n_W): # loop over horizontal axis of the output volume
                # Find the horizontal start and end of the current "slice" (≈2 lines)
                horiz_start = w*stride
                horiz_end = w*stride+f                
                for c in range(n_c):   # loop over channels (= #filters) of the output volume                     
                    # Use the corners to define the (3D) slice of a_prev_pad (See Hint above the cell). (≈1 line)
                    Z.append(a_prev_pad[vert_start:vert_end,horiz_start:horiz_end,:])                    
    return Z

### Extracting local patches from the maps and reshaping the result
Data=conv_forward(A_prev=X,stride=1,pad=3,f=7,n_c=1) # the whole dataset
Data_5D=np.zeros([4335,7,7,2361])
for i in range(len(Data)):
    Data_5D[i,:,:,:]=Data[i][:,:,:]
Data_5D=Data_5D.reshape(4335,7,7,2361,1)
Data_5D.shape
Data_5D=np.reshape(Data_5D,(4335,7,7,2361))
Data_5D[2001,3,3,123,0]==X.reshape(85*51,2361)[2001,123] #Checking

###Train and test set construction
Targets=Data_5D
Inputs=np.load('Whole_Inputs.npy')

Defect_index= np.argwhere(Targets == 1)
Train_x = np.zeros([68,7,7,2361])
for i in range (Train_x.shape[0]):
    x=Defect_index[i,0]
    Train_x[i]=Inputs[x]
np.save("Inputs_Defects",Train_x_defect)

nonDefect_index= np.argwhere(Targets == 0)
Train_x = np.zeros([3339,7,7,2361])
for i in range (Train_x.shape[0]):
    x=nonDefect_index[i,0]
    Train_x[i]=Inputs[x]
Train_x_nondefect = Train_x
np.save("Inputs_nonDefects",Train_x_nondefect) 

I_index= np.argwhere(Targets == 2)
Train_x = np.zeros([928,7,7,2361])
for i in range (Train_x.shape[0]):
    x=nonDefect_index[i,0]
    Train_x[i]=Inputs[x]
Train_x_I = Train_x
np.save("Inputs_I",Train_x_I) 

### Data undersamping
Inputs_ndft=np.load('Inputs_nonDefects.npy')
train_y=np.zeros([3339,])
train_y=pd.Series(train_y)
majority_class_indices=train_y[train_y.values== 0].index
np.random.seed(37)
random_majority_indices=np.random.choice(majority_class_indices,68,replace=False)
print(len(random_majority_indices))  

Train_x = np.zeros([68,7,7,2361])
for i in range (Train_x.shape[0]):
    x=random_majority_indices[i,]
    Train_x[i]=Inputs_ndft[x]
under_sample_Inputs_ndft=Train_x
np.save("Inputs_nondefects_undersample",under_sample_Inputs_ndft) 

### Spectreral CNN training 
nondfct = np.load('Inputs_nondefects_undersample.npy')
dfct = np.load('Inputs_Defects.npy')
Data = np.load('Whole_Inputs.npy')
X= np.concatenate((nondfct,dfct), axis=0)
Y= np.concatenate(((np.zeros((68,),dtype=np.int64)),(np.ones((68,),dtype=np.int64))), axis = 0)
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size = 0.2, random_state = 0)

model = models.Sequential()
model.add(layers.Conv2D(64, (3, 3), activation='relu', input_shape=(7,7,2361)))
model.add(layers.Flatten())
model.add(layers.Dense(128, activation='relu'))
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(1, activation='sigmoid'))

model.compile(optimizer='rmsprop',
loss='binary_crossentropy',
metrics=['accuracy', km.binary_f1_score()])
model.fit(X_train, y_train,validation_data=(X_test,y_test), epochs=50, batch_size=4)

c=model.predict(Data)
c=np.reshape(c,(85,51))

plt.imshow(c)
model.save('CNN.h5') 
np.save('Result_CNN.npy',c)
