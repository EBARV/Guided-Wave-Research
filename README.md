# Guided-Wave-Research

Code and notes from my research on guided waves for non-destructive testing and structural health monitoring of composite (CFRP) plates: damage imaging, defect detection with deep learning, and signal processing.

Each folder is a self-contained project that used to be its own repository; its full commit history is preserved here.

| Folder | Project | Language |
|---|---|---|
| [SWF-Unet](SWF-Unet) | Defect detection in a CFRP plate with flat-bottom holes (FBH): a U-Net trained on successive wavenumber filtering (SWF) results of the guided wavefield | Python (Jupyter) |
| [Unsupervised-FBH-detection](Unsupervised-FBH-detection) | Two-step unsupervised FBH detection in the guided wavefield: k-means clustering to build the training set, then a spectral CNN | Python |
| [Weighted-Band-Power](Weighted-Band-Power) | Weighted Bandpower (WBP): bandpower damage imaging with distance-dependent attenuation compensation | MATLAB |
| [LFM-Separation-using-DFrFT](LFM-Separation-using-DFrFT) | Separation of overlapping linear frequency modulated (LFM) signals with the discrete fractional Fourier transform | MATLAB |

Each project keeps its own README and license in its folder.
