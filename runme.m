% *************************************************************************
% RUNME
% *************************************************************************
%
% ABOUT:
% This program calculates peritumoral border of the lesion.
% 
% Please reference the below article if you use the features deriven by 
% this code.
%
% REFERENCE:
%
% [1] Tunali et al. (2018)."Stability and reproducibility of computed 
% tomography radiomic features extracted from peritumoral regions of lung
% cancer lesions."
%
%  
% For questions: <Ilke.Tunali@moffitt.org>
%
% HISTORY:
%
% Created: June 2018
%
% --> Copyright (C) 2018 Ilke Tunali
% *************************************************************************

lung_mask = 'lung_mask'; % if you have a lung mask
%lung_mask = 'no_lung_mask'; % if you do not use a lung mask
border_size = 3; % selected border size. ex: border_size = 3 for 3 mm.
r = regionprops(maskTmr,'centroid');
cent = [round(r.Centroid)];
pxSpac = infor(1).PixelSpacing; %infor = DICOM Info
foo = maskTmr(:,:,cent(3));
p = regionprops (foo,'MajorAxisLength');
maxDia = round(max([p.MajorAxisLength]).*pxSpac(1));

if isempty(maxDia)
    maxDia = 0;
end

sz = size(maskTmr);
sEs2 = round(border_size/pxSpac(1)); % size of the peritumoral region in mm's.
        
if strcmp( lung_mask,'lung_mask')
            
    Mask = outside_border(maskTmr,MaskLung,sEs2,1); % when using lung mask masking
            
else
    
    Mask = outside_border(maskTmr,ones(sz),sEs2,1); % when using no lung mask was used 
          
end     
