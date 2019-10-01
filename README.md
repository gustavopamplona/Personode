# Personode

Personode is a toobox written in MATLAB designed to make the identification of fMRI spatial independent component analysis (ICA) components into resting-state networks (RSNs) easier.

## Requirements

 - MATLAB R2013A or newer
 - SPM12 (get at https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)
 - MarsBaR (get at http://marsbar.sourceforge.net/)

## A Quick Tutorial

 - Download the .RAR file and extract in a folder of your preference.
 - Set Personode's path to Matlab. Make sure that both SPM12 and Marsbar paths are also included (do not include "spm2", "spm5", and "spm99" contained in Marsbar folder).
 - Type Personode in Matlab's command window.
 - In "Source Files Main Options":
	- Specify the number of subjects;
	- In "Input files mode", if "Automatic" is selected, only ICA file from first subject will be required. If "Manual" is selected, one needs to manually select subjects' files for analysis;
	- There are two modes of ROIs definition: spherical ROIs (radius can be altered) and probabilistic irregular ROIs. Select one of them;
	- Specify the output folder.
- In "Defining Paths", ICA files must be loaded. GIFT toolbox (download at http://mialab.mrn.org/software/gift/) for Matlab can be used to create the components.
- In "Templates Definition", choose the resting-state network(s) you would like to identify.
- In "Are ICA maps coregistered", answer yes if images have already MNI dimensions. Answer no if you want the toolbox to perform coregistration for you (in this case, you need also to specify an MNI-normalized anatomical file in a forthcoming SPM window).
	- If images are already with the right dimensions, one can navigate across components using the GUI buttons (slice, threshold, subject, component, refresh image)
- In "Describing ROI features", select the info you would like to obtain from the ROIs definition process.
- In "How will the nodes be created", select either "Separated" for creating a mask with an atlas labeling (integer numbers as labels) or "As a network" as a binary mask for networks.
- Press Start.
- A Manual selection window will appear showing, in the left side, the resting-state network template you want to identify and the three most probable components to be classified. You can navigate using xyz buttons. Probability values are also shown to help with the classification. One can select a component and then press Next. If more than one RSN was selected to be identified, one can also skip the current component to be defined later.
- Nifti masks and TXT info files will be saved in the specified output folder.
