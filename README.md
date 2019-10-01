# Personode

Personode is a toobox written in MATLAB designed to make the identification of fMRI spatial independent component analysis (ICA) components into resting-state networks (RSNs) easier.

## Requirements

 - MATLAB R2013A or newer
 - SPM12 (get at https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)
 - MarsBaR (`marsbar-0.44` is included. Alternatively, get at http://marsbar.sourceforge.net/)

## A Quick Tutorial

 - Download the compressed file (get at https://www.nitrc.org/projects/personode) and extract it in a folder of your preference or clone this repository to your desktop.
 - Set Personode's path to Matlab. Make sure that both SPM12 and MarsBaR paths are also included (do not include "spm2", "spm5", and "spm99" contained in MarsBaR folder).
 - Type Personode in Matlab's command window.
 - In "Source Files Main Options":
	- Specify the number of subjects;
	- In "Input files mode", if "Automatic" is selected, only ICA file from first subject will be required. If "Manual" is selected, one needs to manually select subjects' files for analysis;
	- There are two modes of ROIs definition: spherical ROIs (radius can be altered) and probabilistic irregular ROIs. Select one of them;
	- Specify the output folder.
- In "Defining Paths", ICA spatial component files must be loaded. GIFT toolbox (download at http://mialab.mrn.org/software/gift/) for Matlab can be used to create the components.
- In "Templates Definition", choose the resting-state network(s) you would like to identify.
- In "Are ICA maps coregistered" answer yes if the images already have MNI dimensions. Answer no if you want the toolbox to perform coregistration for you (in this case, you need also to specify an MNI-normalized anatomical file in a forthcoming SPM window).
	- If the images are already of the right dimensions, you can navigate through the components using the GUI buttons (slice, threshold, subject, component, refresh image) 
- In "Describing ROI features" select the information that you would like to obtain from the ROI definition process. 
- In "How will the nodes be created", select either "Separated" for creating a mask with an atlas labeling (integer numbers as labels) or "As a network" as a binary mask for networks.
- Press Start.
- A Manual selection window will appear showing, in the left side, the resting-state network template you want to identify and the three most probable components to be classified. You can navigate using xyz buttons. Probability values are also shown to help with the classification. One can select a component and then press Next. If more than one RSN was selected to be identified, one can also skip the current component to be defined later.
- Nifti masks and TXT info files will be saved in the specified output folder.

# References

 - \[MarsBaR\] Matthew Brett, Jean-Luc Anton, Romain Valabregue, Jean-Baptiste Poline. _Region of interest analysis using an SPM toolbox_ \[abstract\] Presented at the 8th International Conference on Functional Mapping of the Human Brain, June 2-6, 2002, Sendai, Japan. Available on CD-ROM in NeuroImage, Vol 16, No 2.
 - \[SPM12\] Penny, W. D., Friston, K. J., Ashburner, J. T., Kiebel, S. J., & Nichols, T. E. (Eds.). (2007). Statistical parametric mapping: the analysis of functional brain images.
