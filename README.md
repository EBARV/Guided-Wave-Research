# A-Two-Step-Unsupervised-FBH-detection-Usingand-k-means-and-Spectral-CNN-Clustering
In this reposity, first a train set is obtained with the application of k-means clustering method optimized via Elbow method on a CFRP sample containing several FBHs. The result of clustering provided some TP and FP scan points, constituting the label of the train set. Afterwards, a simple specteral CNN structure is used to construct the final map.
<h2 align="center">
  <b>Results</b><br>
</h2>


| Model                                                                  | Paper                                            |Reconstruction | Samples |
|------------------------------------------------------------------------|--------------------------------------------------|---------------|---------|
| VAE ([Code][vae_code], [Config][vae_config])                           |[Link](https://arxiv.org/abs/1312.6114)           |    ![][2]     | ![][1]  |
| Conditional VAE ([Code][cvae_code], [Config][cvae_config])             |[Link](https://openreview.net/forum?id=rJWXGDWd-H)|    ![][16]    | ![][15] |
| WAE - MMD (RBF Kernel) ([Code][wae_code], [Config][wae_rbf_config])    |[Link](https://arxiv.org/abs/1711.01558)          |    ![][4]     | ![][3]  |
| WAE - MMD (IMQ Kernel) ([Code][wae_code], [Config][wae_imq_config])    |[Link](https://arxiv.org/abs/1711.01558)          |    ![][6]     | ![][5]  |
| Beta-VAE ([Code][bvae_code], [Config][bbvae_config])                   |[Link](https://openreview.net/forum?id=Sy2fzU9gl) |    ![][8]     | ![][7]  |
| Disentangled Beta-VAE ([Code][bvae_code], [Config][bhvae_config])      |[Link](https://arxiv.org/abs/1804.03599)          |    ![][22]    | ![][21] |
| Beta-TC-VAE ([Code][btcvae_code], [Config][btcvae_config])             |[Link](https://arxiv.org/abs/1802.04942)          |    ![][34]    | ![][33] |
| IWAE (*K = 5*) ([Code][iwae_code], [Config][iwae_config])              |[Link](https://arxiv.org/abs/1509.00519)          |    ![][10]    | ![][9]  |
| MIWAE (*K = 5, M = 3*) ([Code][miwae_code], [Config][miwae_config])    |[Link](https://arxiv.org/abs/1802.04537)          |    ![][30]    | ![][29] |
| DFCVAE   ([Code][dfcvae_code], [Config][dfcvae_config])                |[Link](https://arxiv.org/abs/1610.00291)          |    ![][12]    | ![][11] |
| MSSIM VAE    ([Code][mssimvae_code], [Config][mssimvae_config])        |[Link](https://arxiv.org/abs/1511.06409)          |    ![][14]    | ![][13] |
| Categorical VAE   ([Code][catvae_code], [Config][catvae_config])       |[Link](https://arxiv.org/abs/1611.01144)          |    ![][18]    | ![][17] |
| Joint VAE ([Code][jointvae_code], [Config][jointvae_config])           |[Link](https://arxiv.org/abs/1804.00104)          |    ![][20]    | ![][19] |
| Info VAE   ([Code][infovae_code], [Config][infovae_config])            |[Link](https://arxiv.org/abs/1706.02262)          |    ![][24]    | ![][23] |
| LogCosh VAE   ([Code][logcoshvae_code], [Config][logcoshvae_config])   |[Link](https://openreview.net/forum?id=rkglvsC9Ym)|    ![][26]    | ![][25] |
| SWAE (200 Projections) ([Code][swae_code], [Config][swae_config])      |[Link](https://arxiv.org/abs/1804.01947)          |    ![][28]    | ![][27] |
| VQ-VAE (*K = 512, D = 64*) ([Code][vqvae_code], [Config][vqvae_config])|[Link](https://arxiv.org/abs/1711.00937)          |    ![][31]    | **N/A** |
| DIP VAE ([Code][dipvae_code], [Config][dipvae_config])                 |[Link](https://arxiv.org/abs/1711.00848)          |    ![][36]    | ![][35] |
