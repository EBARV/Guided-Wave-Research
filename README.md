# Defect detection in a CFRP containing FBH defects using Unet structure trained on successive wavenumber (SWF) filtering result
In this project, first successive numdamage maps corresponding to different center frequency of the Insert dataset are obtained after applying SWF.
Then with constructing a hyper image constructed from previously obtained maps, train set is constructed.
For training, multiple patches of this hyper image are extracted. Then, a UNET structure is trained with such 
hyper windows. At the end, the trained model is tested on a FBH dataset. 
