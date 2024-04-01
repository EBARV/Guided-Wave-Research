# Defect detection in a CFRP containing FBH defects using Unet structure trained on successive wavenumber filtering result
In this project, first RMS maps corresponding to different center frequency of the Insert dataset are obtained
Then with constructing a hyper image constructed from abovementioned maps, the data for training is obtained.
For training, multiple patches of this hyper image are extracted. Then, a UNET structure is trained with such 
hyper windows. At the end, the trained model is tested on a FBH dataset. 
The input data can not be made available. 

