% Parameters setting
syms k_1 k_2 k_3 k_4 k_5

figure()
parameterValues = [0.9055 0.4257 716.8168 712.2395 305.3670 356.7264 -3.8875 17.7607 -29.2293];
%parameterValues = [0.9055 0.4257 1 1 0 0 -3.8875 17.7607 -29.2293];
plotLensDistortion(parameterValues);
