%___________PERSONODE____________%
% Written by Gustavo Pamplona, MSc
% Version 1.0, February 2017
% Requirements: MATLAB 2013a, Marsbar (http://marsbar.sourceforge.net/)
%
% Contact: gsppamplona@gmail.com

function Personode

clear all;close all; clc;

%% Frames
% Main frame
P = struct(...
    'Source2',          0,...
    'Source4',          0,...
    'Source5',          0,...
    'BtnAll',           0,...
    'BtnICAfile',       0,...
    'BtnICAgroup',      0,...
    'BtnTemp',          0,...
    'BtnTXTAll',        0,...
    'BtnTXT',           0,...
    'Separated',        1,...
    'Network',          0,...
    'NrSubj',           0,...
    'thrValue',         1,...
    'lastComp',         1,...
    'compSelected',     1,...
    'lastCompValue',    0,...
    'lastSlice',        45,...
    'sliceSelected',    1,...
    'lastSliceValue',   0,...
    'compFirst',        1,...
    'ICAgroup',         [],...
    'ICAfile',          [],...
    'files',            [],...
    'creationMode',     'i',...
    'subjValue',        1,...
    'loadImagesDone',   0,...
    'CoregYes',         0,...
    'radius',           4,...
    'output',           0 ...
    );

[P.workPath, ~, ~]= fileparts(mfilename('fullpath'));

handles_gui.hF = figure;

leftMF       = 300;
bottomMF     = 0;
widthMF      = 860;
heightMF     = 680;

textHeight   = 20;
textShift    = 4;

set(handles_gui.hF, ...
    'position', [leftMF bottomMF widthMF heightMF], ...
    'numbertitle', 'off', ...
    'name', 'Personode', ...
    'resize', 'off', ...
    'tag', 'hF', ...
    'menubar', 'none');

%% Frame 1: Source files main options
leftF1       = 20;
bottomF1     = 470;
heightF1     = 200;
widthF1      = 340;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1 bottomF1 widthF1 heightF1]);  

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+10 bottomF1+heightF1-25 widthF1-20 20], ...
    'FontSize', 10,...
    'FontWeight', 'bold',...
    'string', 'Source Files Main Options');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+25 bottomF1+heightF1-54 widthF1-50 20], ...
    'string', '# of Subjects:');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'position', [leftF1+110 bottomF1+heightF1-50 40 20], ...
    'callback', {@subjectsField_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'on',...
    'tag', 'edNrSubj');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+25 bottomF1+heightF1-75 widthF1-50 20], ...
    'string', 'Input files mode:');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Automatic (specify only first file in a series)',...
    'Value', 0,...
    'pos',[leftF1+25 bottomF1+heightF1-90 widthF1-26 20],...
    'callback', {@btnSource4_press},...
    'Enable', 'on',...
    'tag', 'btnSource4');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Manual',...
    'Value', 0,...
    'pos',[leftF1+25 bottomF1+heightF1-110 widthF1-130 20],...
    'callback', {@btnSource5_press},...
    'Enable', 'on',...
    'tag', 'btnSource5');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+25 bottomF1+heightF1-130 widthF1-50 20], ...
    'string', 'ROIs definition:');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Spheres',...
    'Value', 0,...
    'pos',[leftF1+25 bottomF1+heightF1-145 80 20],...
    'callback', {@btnSource6_press},...
    'Enable', 'on',...
    'tag', 'btnSource6');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+100 bottomF1+heightF1-149 50 20], ...
    'string', 'Radius:');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'position', [leftF1+150 bottomF1+heightF1-145 25 20], ...
    'callback', {@radius_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'off',...
    'String', 4,...
    'tag', 'edRadius');
uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+175 bottomF1+heightF1-149 40 20], ...
    'string', 'mm');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Irregular',...
    'Value', 0,...
    'pos',[leftF1+240 bottomF1+heightF1-145 90 20],...
    'callback', {@btnSource7_press},...
    'Enable', 'on',...
    'tag', 'btnSource7');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF1+25 bottomF1+heightF1-184 90 20], ...
    'string', 'Output Folder:');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'position', [(leftF1+110) bottomF1+heightF1-180 180 textHeight], ...
    'BackgroundColor', 'white',...
    'tag', 'edOutput',...
    'Enable', 'on',...
    'Selected','on',...
    'string', [P.workPath filesep 'Output_files' filesep ]);
uicontrol('style', 'pushbutton', ...
    'Parent',handles_gui.hF,...
    'position', [(leftF1+300) bottomF1+heightF1-180 30 textHeight], ...
    'tag', 'edOutputBtn',...
    'Enable', 'on',...
    'Selected','off',...
    'string', '...', ...
    'callback', {@OutputBtn_press});

%% Frame 2: Paths definition
leftF2       = 370;
bottomF2     = 550;
heightF2     = 120;
widthF2      = 480;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF2 bottomF2 widthF2 heightF2]);  

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF2+5 (bottomF2+heightF2-25) 420 20], ...
    'FontSize', 10,...
    'FontWeight', 'bold',...
    'string', 'Defining Paths');

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [(leftF2+5) (bottomF2+heightF2-70-textShift) 120 textHeight], ...
    'string', 'ICA Group File:');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'position', [(leftF2+125) bottomF2+heightF2-70 305 textHeight], ...
    'BackgroundColor', 'white',...
    'tag', 'edICAGroup',...
    'Enable', 'on',...
    'Selected','on',...
    'string', '...');
uicontrol('style', 'pushbutton', ...
    'Parent',handles_gui.hF,...
    'position', [(leftF2+440) bottomF2+heightF2-70 30 textHeight], ...
    'tag', 'edICAGroupBtn',...
    'Enable', 'on',...
    'Selected','off',...
    'string', '...', ...
    'callback', {@ICAGroupChoose_press});

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [(leftF2+5) (bottomF2+heightF2-100-textShift) 120 textHeight], ...
    'string', 'Individual ICA Files:');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'HorizontalAlignment', 'left', ...
    'position', [(leftF2+125) bottomF2+heightF2-100 305 textHeight], ...
    'BackgroundColor', 'white',...
    'tag', 'edICAComp',...
    'Enable', 'off',...
    'Selected','on',...
    'callback', {@ICACompChoose_text},...
    'string', '...');
uicontrol('style', 'pushbutton', ...
    'Parent',handles_gui.hF,...
    'position', [(leftF2+440) bottomF2+heightF2-100 30 textHeight], ...
    'tag', 'edICACompBtn',...
    'Enable', 'off',...
    'Selected','off',...
    'string', '...', ...
    'callback', {@ICACompChoose_press});

%% Frame 3: "Templates Definition" 
leftF3       = 20;
bottomF3     = 150;
widthF3      = 340;
heightF3     = 300;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF3 bottomF3 widthF3 heightF3]);   

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF3+15 (bottomF3+heightF3-25) widthF3-20 20], ...
    'FontSize', 10,...
    'FontWeight', 'bold',...
    'string', 'Templates Definition');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','All',...
    'Value', 0,...
    'pos',[leftF3+15 bottomF3+heightF3-50 100 20],...
    'callback', {@btnAllTemp_press},...
    'tag', 'btnAll');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Dorsal Attention',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-80 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp01');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Auditory',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-100 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp02');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Basal Ganglia',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-120 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp03');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Cerebellum',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-140 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp04');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Cognition/Emotion',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-160 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp05');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Default Mode, Dorsal/Posterior',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-180 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp06');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Default Mode, Medial',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-200 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp07');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Executive Control',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-220 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp08');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Frontoparietal, Left',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-240 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp09');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Frontoparietal, Right',...
    'Value', 0,...
    'pos',[leftF3+5 bottomF3+heightF3-260 190 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp10');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Ventral Stream, Left',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-80 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp11');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Ventral Stream, Right',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-100 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp12');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Postcentral',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-120 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp13');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Precentral',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-140 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp14');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Precuneus',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-160 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp15');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Salience',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-180 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp16');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Sensorimotor',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-200 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp17');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Visual, Primary I',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-220 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp18');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Visual, Primary II',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-240 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp19');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Visual, Medial',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-260 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp20');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Visual, Higher Level',...
    'Value', 0,...
    'pos',[leftF3+195 bottomF3+heightF3-280 140 20],...
    'callback', {@btnTemp_press},...
    'tag', 'btnTemp21');

%% Frame 4: "Coregistration" 
leftF4       = 20;
bottomF4     = 40;
widthF4      = 340;
heightF4     = 90;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF4 bottomF4 widthF4 heightF4]);   

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF4+15 (bottomF4+heightF4-25) widthF4-20 20], ...
    'FontSize', 9,...
    'FontWeight', 'bold',...
    'string', 'Are ICA maps coregistered?');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Yes',...
    'Enable', 'off',...
    'Value', 0,...
    'pos',[leftF4+15 bottomF4+heightF4-45 widthF4-20 20],...
    'callback', {@btnYesCoreg_press},...
    'tag', 'btnYesCoreg');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','No',...
    'Enable', 'off',...
    'Value', 0,...
    'pos',[leftF4+15 bottomF4+heightF4-65 widthF4-20 20],...
    'callback', {@btnNoCoreg_press},...
    'tag', 'btnNoCoreg');

%% Frame 5: "Describing ROIs features" 
leftF5       = 370;
bottomF5     = 40;
widthF5      = 260;
heightF5     = 170;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF5 bottomF5 widthF5 heightF5]);   

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF5+15 (bottomF5+heightF5-25) widthF5-20 20], ...
    'FontSize', 9,...
    'FontWeight', 'bold',...
    'string', 'Describing ROIs features?');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','All',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-50 widthF5-20 20],...
    'callback', {@btnTXTAll_press},...
    'tag', 'btnTXTAll');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Peak Value',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-80 widthF5-20 20],...
    'callback', {@btnTXT_press},...
    'tag', 'btnTXT01');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','"Real World" Coordinates',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-100 widthF5-20 20],...
    'callback', {@btnTXT_press},...
    'tag', 'btnTXT02');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','MNI Coordinates',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-120 widthF5-20 20],...
    'callback', {@btnTXT_press},...
    'tag', 'btnTXT03');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Network name',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-140 widthF5-20 20],...
    'callback', {@btnTXT_press},...
    'tag', 'btnTXT04');

uicontrol('Style','checkbox',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Component Number',...
    'Value', 0,...
    'pos',[leftF5+15 bottomF5+heightF5-160 widthF5-20 20],...
    'callback', {@btnTXT_press},...
    'tag', 'btnTXT05');

%% Start button
uicontrol('style', 'pushbutton', ...
    'Parent',handles_gui.hF,...
    'position', [700 35 100 35], ...
    'FontWeight', 'bold',...
    'FontSize', 11,...
    'tag', 'btnStart',...
    'callback', {@start_press},...
    'Enable', 'off',...
    'string', 'Start');

%% Show MNI Template
VallMNI=spm_vol(deblank([P.workPath filesep 'Images_example' filesep 'avg152T1.nii']));
P.temp=spm_read_vols(VallMNI);
P.MNI=uint8(P.temp(:,:,45)*256);

handles_gui.P0 = uipanel;

leftP0       = 0.430;
bottomP0     = 0.317;
widthP0      = 0.380;
heightP0     = 0.454;

set(handles_gui.P0,...
    'title','Image',...
    'FontSize',10,...
    'FontName','Arial',...
    'FontWeight','Bold',...
    'Visible', 'on',...
    'tag', 'P0',...
    'ButtonDownFcn', {@dispIMG_press},...
    'Clipping', 'on',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'Position', [leftP0 bottomP0 widthP0 heightP0]); 
handles.A0 = axes;
set(handles.A0,'Parent',handles_gui.P0,...
    'ActivePositionProperty', 'Position',...
    'Position', [0.05 -0.05 1 1],...
    'NextPlot', 'replacechildren'); % replacechildren 

imshow(rot90(P.MNI), 'Parent', handles.A0);

%% Figure features

leftF6       = 720;
bottomF6     = 222;
widthF6      = 150;
heightF6     = 20;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF6-15 bottomF6+25 widthF6-5 270]); 

% Select Slice
uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold',...
    'position', [leftF6-10 bottomF6+265 40 20], ...
    'string', 'Slice');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6-10 bottomF6+245 40 20], ...
    'callback', {@sliceSelect_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'off',...
    'String', '45',...
    'tag', 'sliceSelect');
uicontrol('style', 'slider', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6 bottomF6+40 20 200], ...
    'callback', {@sliceBtnSlider_press},...
    'Selected', 'off',...
    'Enable', 'off',...
    'Max', 91,...
    'Min', 1, ...
    'Value', 45, ...
    'SliderStep', [1/90,1/9],...
    'tag', 'sliceBtnSlider');

% Select Threshold
uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold',...
    'position', [leftF6+50 bottomF6+180 70 20], ...
    'string', 'Threshold');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6+75 bottomF6+160 30 20], ...
    'callback', {@thrSelect_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'off',...
    'String', '1',...
    'tag', 'thrSelect');

% Select Subject
uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold',...
    'position', [leftF6+50 bottomF6+120 70 20], ...
    'string', 'Subject');
uicontrol('style', 'pop', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6+50 bottomF6+100 70 20], ...
    'callback', {@subjSelect_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'off',...
    'string', 'Subject',...
    'tag', 'subjSelect');

% Select Component
uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold',...
    'position', [leftF6+50 bottomF6+60 70 20], ...
    'string', 'Component');
uicontrol('style', 'edit', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6+70 bottomF6+40 30 20], ...
    'callback', {@compSelect_press},...
    'BackgroundColor', 'white',...
    'Selected', 'on',...
    'Enable', 'off',...
    'String', '1',...
    'tag', 'compSelect');
uicontrol('style', 'slider', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6+100 bottomF6+40 15 20], ...
    'callback', {@compbtnSlider_press},...
    'Selected', 'off',...
    'Enable', 'off',...
    'tag', 'compBtnSlider');

% Refresh button
uicontrol('style', 'pushbutton', ...
    'Parent',handles_gui.hF,...
    'position', [leftF6+10 bottomF6 widthF6-50 heightF6], ...
    'FontWeight', 'bold',...
    'tag', 'btnRefresh',...
    'callback', {@refresh_press},...
    'Enable', 'off',...
    'string', 'Refresh Image');

%% Frame 6: "How will the nodes be created?" 

leftF6       = 640;
bottomF6     = 80;
widthF6      = 210;
heightF6     = 130;

uicontrol('style', 'frame', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF6 bottomF6 widthF6 heightF6]);

uicontrol('style', 'text', ...
    'Parent',handles_gui.hF,...
    'BackgroundColor', [0.85 0.85 0.85],...
    'position', [leftF6+15 (bottomF6+heightF6-25) widthF6-20 20], ...
    'FontSize', 9,...
    'FontWeight', 'bold',...
    'string', 'How will the nodes be created?');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','Separated',...
    'Value', 1,...
    'pos',[leftF6+15 bottomF6+heightF6-60 widthF6-20 20],...
    'callback', {@btnSeparated_press},...
    'tag', 'btnSeparated');

uicontrol('Style','Radio',...
    'Parent',handles_gui.hF,...
    'FontWeight', 'bold',...
    'BackgroundColor', [0.85 0.85 0.85],...
    'String','As a network',...
    'Value', 0,...
    'pos',[leftF6+15 bottomF6+heightF6-80 widthF6-20 20],...
    'callback', {@btnNetwork_press},...
    'tag', 'btnNetwork');

guidata(handles_gui.hF, P);

set(handles_gui.hF, 'HandleVisibility', 'callback');

return

function sliceSelect_press(src, ~)
handles = guihandles(src);
P = guidata(src);

slice = str2double(get(handles.sliceSelect, 'string'));

if slice<1
    slice=1;
elseif slice>size(P.MNI,1)
    slice=size(P.MNI,1);
end

set(handles.sliceSelect, 'string', num2str(slice));
set(handles.sliceBtnSlider, 'Value', slice);
P.lastSlice=slice;
P.sliceSelected=1;
set(src,'Value',slice/100);
guidata(handles.hF, P);
refresh_press(src)

return

function sliceBtnSlider_press(src, ~)
handles = guihandles(src);
P = guidata(src);

slice = round(get(src,'Value'));

if P.sliceSelected==1
    if get(src,'Value')<P.lastSlice
        slice=P.lastSlice-1;
    else
        slice=P.lastSlice+1;
    end
end 

if slice<1
    slice=slice+1;
elseif slice>size(P.MNI,1)
    slice=slice-1;
else
    set(handles.sliceSelect, 'string', num2str(slice));
end

set(src,'Value', slice);
P.lastSlice=slice;
P.sliceSelected=0;
guidata(handles.hF,P);
refresh_press(src)

return

function thrSelect_press(src, ~)
handles = guihandles(src);
P = guidata(src);

P.thrValue=str2num(get(handles.thrSelect, 'String'));

guidata(handles.hF, P);
refresh_press(src)

return

function subjSelect_press(src, ~)
handles = guihandles(src);
P = guidata(src);

P.subjValue=get(handles.subjSelect, 'value');

guidata(handles.hF, P);
refresh_press(src)

return

function compSelect_press(src, ~)
handles = guihandles(src);
P = guidata(src);

comp = str2double(get(handles.compSelect, 'string'));

if comp<1
    comp=1;
elseif comp>size(P.ICAfile,1)
    comp=size(P.ICAfile,1);
end

set(handles.compSelect, 'string', num2str(comp));
P.lastComp=comp;
P.compSelected=1;
set(src,'Value',comp/100);
guidata(handles.hF, P);
refresh_press(src)

return

function compbtnSlider_press(src, ~)
handles = guihandles(src);
P = guidata(src);

if P.compFirst==1
    set(handles.compBtnSlider, 'Value', 1);
    set(handles.compBtnSlider, 'Min', 1);
    set(handles.compBtnSlider, 'Max', size(P.image,4));
    set(handles.compBtnSlider, 'SliderStep', [1/(size(P.image,4)-1) 10*(1/(size(P.image,4)-1))]);
end

comp = round(get(src,'Value'));

if P.compSelected==1
    if get(src,'Value')<P.lastCompValue
        comp=P.lastComp-1;
    else
        comp=P.lastComp+1;
    end
end 

if comp<1
    comp=comp+1;
elseif comp>size(P.image,4)
    comp=comp-1;
else
    set(handles.compSelect, 'string', num2str(comp));
end

set(src,'Value', comp);
P.lastComp=comp;
P.compFirst=0;
P.lastCompValue=get(src,'Value');
P.compSelected=0;
guidata(handles.hF,P);
refresh_press(src)

return

function refresh_press(src, evt)
handles = guihandles(src);
P = guidata(src);

P.NrCompImage = str2double(get(handles.compSelect, 'string'));
 
handles.A0 = axes;
set(handles.A0,'Parent',handles.P0,...
    'ActivePositionProperty', 'Position',...
    'Position', [0.05 -0.05 1 1],...
    'NextPlot', 'replacechildren'); 

C1=P.temp(:,:,P.lastSlice);
if P.subjValue<2
    Vall=spm_vol(deblank(P.ICAgroup));
    P.image=spm_read_vols(Vall);
    C2=(P.image(:,:,P.lastSlice,P.NrCompImage))>P.thrValue;
    P.prevIndex=0;
else
    index=P.subjValue-1;
    if index~=P.prevIndex
        Vall=spm_vol(deblank(char(P.ICAfile(:,index))));
        P.image=spm_read_vols(Vall);
        P.prevIndex=index;
    end
    C2=(P.image(:,:,P.lastSlice,P.NrCompImage))>P.thrValue;
end
    
B=rot90(imoverlay(C1,C2,[1 0 0]));
imshow(B, 'Parent', handles.A0);

guidata(handles.hF,P);

return

function subjectsField_press(src, evt)
handles = guihandles(src);
P = guidata(src);

P.NrSubj = str2double(get(handles.edNrSubj, 'string'));

if P.NrSubj>0
    if P.Source4==1 || P.Source5==1
        set(handles.edICAComp, 'Enable', 'on');
        set(handles.edICACompBtn, 'Enable', 'on');
    end
else
    P.NrSubj=0;
    set(handles.edICAComp, 'Enable', 'off');
    set(handles.edICACompBtn, 'Enable', 'off');
end

guidata(handles.hF, P);
enable_start(src)

return

function btnSource4_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.Source4==0
    P.Source4=1;
    P.Source5=0;
    set(handles.btnSource5, 'Value', 0);
    if P.NrSubj>0
        set(handles.edICAComp, 'Enable', 'on');
        set(handles.edICACompBtn, 'Enable', 'on');
    end
else
    P.Source4=0;
    P.Source5=1;
    set(handles.btnSource4, 'Value', 0);
    set(handles.edICAComp, 'Enable', 'off');
    set(handles.edICACompBtn, 'Enable', 'off');
end

guidata(handles.hF, P);
enable_start(src)

return

function btnSource5_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.Source5==0
    P.Source5=1;
    P.Source4=0;
    set(handles.btnSource4, 'Value', 0);
    if P.NrSubj>0
        set(handles.edICAComp, 'Enable', 'on');
        set(handles.edICACompBtn, 'Enable', 'on');
    end
else
    P.Source5=0;
    P.Source4=1;
    set(handles.btnSource5, 'Value', 0);
    set(handles.edICAComp, 'Enable', 'off');
    set(handles.edICACompBtn, 'Enable', 'off');
end

guidata(handles.hF, P);
enable_start(src)

return

function btnTXTAll_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.BtnTXTAll==0
    P.BtnTXTAll=1;
    set(handles.btnTXT01, 'Value', 1);
    set(handles.btnTXT02, 'Value', 1);
    set(handles.btnTXT03, 'Value', 1);
    set(handles.btnTXT04, 'Value', 1);
    set(handles.btnTXT05, 'Value', 1);
    set(handles.btnTXTAll, 'Value', 1);
else
    P.BtnTXTAll=0;
    set(handles.btnTXT01, 'Value', 0);
    set(handles.btnTXT02, 'Value', 0);
    set(handles.btnTXT03, 'Value', 0);
    set(handles.btnTXT04, 'Value', 0);
    set(handles.btnTXT05, 'Value', 0);
    set(handles.btnTXTAll, 'Value', 0);
end

guidata(handles.hF, P);
enable_start(src)
return

function btnTXT_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.BtnTXT=1;
set(handles.btnTXTAll, 'Value', 0);

guidata(handles.hF, P);
enable_start(src)
return

function btnYesCoreg_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.CoregYes=1;

set(handles.btnNoCoreg, 'Value', 0);

guidata(handles.hF, P);
loadImages(src,P.ICAgroup)
enable_start(src)
return

function btnNoCoreg_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.CoregYes=0;

set(handles.btnYesCoreg, 'Value', 0);

guidata(handles.hF, P);
loadImages(src,P.ICAgroup)
enable_start(src)
return

function btnSource6_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.sphere=1;

set(handles.btnSource7, 'Value', 0);
set(handles.edRadius, 'Enable', 'on');

guidata(handles.hF, P);
enable_start(src)
return

function btnSource7_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.sphere=0;

set(handles.btnSource6, 'Value', 0);
set(handles.edRadius, 'Enable', 'off');

guidata(handles.hF, P);
enable_start(src)
return

function radius_press(src, evt)
handles = guihandles(src);
P = guidata(src);

P.radius = str2double(get(handles.edRadius, 'string'));

guidata(handles.hF, P);
enable_start(src)

return

function btnSeparated_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.Separated==0
    P.Separated=1;
    P.Network=0;
    set(handles.btnSeparated, 'Value', 1);
    set(handles.btnNetwork, 'Value', 0);
    P.creationMode='i';
else
    P.Separated=0;
    P.Network=1;
    set(handles.btnSeparated, 'Value', 0);
    set(handles.btnNetwork, 'Value', 1);
    P.creationMode='c';
end

guidata(handles.hF, P);
enable_start(src)

return

function btnNetwork_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.Network==0
    P.Network=1;
    P.Separated=0;
    set(handles.btnNetwork, 'Value', 1);
    set(handles.btnSeparated, 'Value', 0);
    P.creationMode='c';
else
    P.Network=0;
    P.Separated=1;
    set(handles.btnNetwork, 'Value', 0);
    set(handles.btnSeparated, 'Value', 1);
    P.creationMode='i';
end

guidata(handles.hF, P);
enable_start(src)

return

function btnAllTemp_press(src, evt)
handles = guihandles(src);
P = guidata(src);

if P.BtnAll==0
    P.BtnAll=1;
    set(handles.btnTemp01, 'Value', 1);
    set(handles.btnTemp02, 'Value', 1);
    set(handles.btnTemp03, 'Value', 1);
    set(handles.btnTemp04, 'Value', 1);
    set(handles.btnTemp05, 'Value', 1);
    set(handles.btnTemp06, 'Value', 1);
    set(handles.btnTemp07, 'Value', 1);
    set(handles.btnTemp08, 'Value', 1);
    set(handles.btnTemp09, 'Value', 1);
    set(handles.btnTemp10, 'Value', 1);
    set(handles.btnTemp11, 'Value', 1);
    set(handles.btnTemp12, 'Value', 1);
    set(handles.btnTemp13, 'Value', 1);
    set(handles.btnTemp14, 'Value', 1);
    set(handles.btnTemp15, 'Value', 1);
    set(handles.btnTemp16, 'Value', 1);
    set(handles.btnTemp17, 'Value', 1);
    set(handles.btnTemp18, 'Value', 1);
    set(handles.btnTemp19, 'Value', 1);
    set(handles.btnTemp20, 'Value', 1);
    set(handles.btnTemp21, 'Value', 1);
    set(handles.btnAll, 'Value', 1);
else
    P.BtnAll=0;
    set(handles.btnTemp01, 'Value', 0);
    set(handles.btnTemp02, 'Value', 0);
    set(handles.btnTemp03, 'Value', 0);
    set(handles.btnTemp04, 'Value', 0);
    set(handles.btnTemp05, 'Value', 0);
    set(handles.btnTemp06, 'Value', 0);
    set(handles.btnTemp07, 'Value', 0);
    set(handles.btnTemp08, 'Value', 0);
    set(handles.btnTemp09, 'Value', 0);
    set(handles.btnTemp10, 'Value', 0);
    set(handles.btnTemp11, 'Value', 0);
    set(handles.btnTemp12, 'Value', 0);
    set(handles.btnTemp13, 'Value', 0);
    set(handles.btnTemp14, 'Value', 0);
    set(handles.btnTemp15, 'Value', 0);
    set(handles.btnTemp16, 'Value', 0);
    set(handles.btnTemp17, 'Value', 0);
    set(handles.btnTemp18, 'Value', 0);
    set(handles.btnTemp19, 'Value', 0);
    set(handles.btnTemp20, 'Value', 0);
    set(handles.btnTemp21, 'Value', 0);
    set(handles.btnAll, 'Value', 0);
end

guidata(handles.hF, P);
enable_start(src)
return

function btnTemp_press(src, evt)
handles = guihandles(src);
P = guidata(src);
P.BtnTemp=1;
set(handles.btnAll, 'Value', 0);

guidata(handles.hF, P);
enable_start(src)
return

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function OutputBtn_press(src, evt)

handles = guihandles(src);
P = guidata(src);

P.output=uigetdir(cd);
set(handles.edOutput, 'string', P.output);

guidata(handles.hF, P);

return

function ICAGroupChoose_press(src, evt)

handles = guihandles(src);
P = guidata(src);

cd(P.workPath);

[P.fileGroup,path] = uigetfile({'*.nii', ['Select the ICA map (*.nii) for the group']}, 'MultiSelect', 'off');
P.ICAgroup=[path P.fileGroup];
P.BtnICAgroup=1;

set(handles.edICAGroup, 'string', P.ICAgroup);

guidata(handles.hF, P);

loadImages(src,P.ICAgroup)

return

function ICACompChoose_text(src, evt)

handles = guihandles(src);
S = get(handles.edICAComp, 'String');

if isempty(S)
    set(handles.btnYesCoreg, 'Enable', 'off');
    set(handles.btnNoCoreg, 'Enable', 'off');
else
    set(handles.btnYesCoreg, 'Enable', 'on');
    set(handles.btnNoCoreg, 'Enable', 'on');
end

return


function ICACompChoose_press(src, evt)

handles = guihandles(src);
P = guidata(src);

cd(P.workPath);
P.NrSubj = str2double(get(handles.edNrSubj, 'string'));
strICAfile=[];

if P.Source4==0
        [file,path] = uigetfile({ '*.nii',  ['Select the ICA map (*.nii) for every subject to be included in the analysis']}, 'MultiSelect', 'on');
        for i=1:P.NrSubj
            pathName(i)=cellstr(path);
            P.fileName(i)=cellstr(file(i));
        end
        file=char(file(1));
else
    [file,path] = uigetfile({ '*.nii',  'Select the ICA map (*.nii) of the first subject for the analysis'}, 'MultiSelect', 'off');
    wheressub=findstr(file,'sub');
    firstSub=str2num(file(1,wheressub+3:wheressub+5));
    for i=1:P.NrSubj
        pathName(i)=cellstr(path);
        if length(num2str(i+firstSub-1))==1
            P.fileName(i)=cellstr([file(1,[1:wheressub+2]) '00' num2str(i+firstSub-1) file(1,[wheressub+6:end])]);
        elseif length(num2str(i+firstSub-1))==2
            P.fileName(i)=cellstr([file(1,[1:wheressub+2]) '0' num2str(i+firstSub-1) file(1,[wheressub+6:end])]);
        else
            P.fileName(i)=cellstr([file(1,[1:wheressub+2]) num2str(i+firstSub-1) file(1,[wheressub+6:end])]);
        end
    end
end

for j=1:P.NrSubj
    tmp_path=char(pathName(j));
    tmp_file=char(P.fileName(j));
    n_files=size(spm_vol(deblank([tmp_path tmp_file])),1);
    
    if file == 0
        set(handles.edICAComp, 'string', 'Not Valid');
    else
        for i=1:n_files
            if i>9
                ICAfilePath(i,:)=[tmp_path tmp_file ',' num2str(i)];
            else
                ICAfilePath(i,:)=[tmp_path tmp_file ',' num2str(i) ' '];
            end
        end
        
        ICAfile(:,j)=cellstr(ICAfilePath);
        clear ICAfilePath
    end
    strICAfile=[strICAfile '"' ICAfile{1,j} '"; '];
    P.BtnICAfile=1;
end

P.ICAfile=ICAfile;
set(handles.edICAComp, 'string', strICAfile(1,1:end-2));
set(handles.sliceSelect, 'string', num2str(45));
set(handles.compSelect, 'string', num2str(1));
set(handles.btnYesCoreg, 'Enable', 'on');
set(handles.btnNoCoreg, 'Enable', 'on');


guidata(handles.hF, P);
enable_start(src)

loadImages(src)

return

function loadImages(src, evt)
handles = guihandles(src);
P = guidata(src);

Vall0=spm_vol(deblank(P.ICAgroup));
zica0=spm_read_vols(Vall0);
    
if length(get(handles.edICAGroup,'String'))>3
    zica=zica0;
    files1{:,1}=P.ICAgroup;
    P.files=files1;
    groupSelected=1;
else
    groupSelected=0;
end

if length(get(handles.edICAComp,'String'))>3
    for subj=1:P.NrSubj
        whereiscomma=strfind(P.ICAfile{1,subj},',');
        files2{:,subj}=P.ICAfile{1,subj}(1:whereiscomma-1);
    end
    P.files=files2;
    indivSelected=1;
else
    indivSelected=0;
end

if length(get(handles.edICAGroup,'String'))>3
    if length(get(handles.edICAComp,'String'))>3
        P.files=[files1 files2];
    end
end

P.image=zica0;
P.nrComp=size(P.image,4);

guidata(handles.hF, P);
enable_refresh(src)

return

function enable_refresh(src, evt) 

handles = guihandles(src);
P = guidata(src);
if ~isempty(P.image) && P.CoregYes==1
    P.loadImagesDone=1;
    set(handles.btnRefresh, 'Enable', 'on');
    set(handles.sliceSelect, 'Enable', 'on');
    set(handles.sliceBtnSlider, 'Enable', 'on');
    set(handles.thrSelect, 'Enable', 'on');
    set(handles.subjSelect, 'Enable', 'on');
    set(handles.subjSelect, 'string', char(P.files(:)));
    set(handles.compSelect, 'Enable', 'on');
    set(handles.compBtnSlider, 'Enable', 'on');
else
    P.loadImagesDone=0;
    set(handles.btnRefresh, 'Enable', 'off');
    set(handles.sliceSelect, 'Enable', 'off');
    set(handles.sliceBtnSlider, 'Enable', 'off');
    set(handles.thrSelect, 'Enable', 'off');
    set(handles.subjSelect, 'Enable', 'off');
    set(handles.compSelect, 'Enable', 'off');
    set(handles.compBtnSlider, 'Enable', 'off');
end

guidata(handles.hF, P);
return

function enable_start(src, evt) 

handles = guihandles(src);
P = guidata(src);
if (P.Source4==1 || P.Source5==1) && (P.BtnAll==1 || P.BtnTemp==1) && (P.BtnTXTAll==1 || P.BtnTXT==1) && (P.BtnICAfile==1 || P.BtnICAgroup==1)
    set(handles.btnStart, 'Enable', 'on');
end

guidata(handles.hF, P);
return

function start_press(src, evt)

handles = guihandles(src);
P = guidata(src);

if P.CoregYes==0
    disp('Running Coregister. Please wait...')
    matlabbatch{1,1}.spm.spatial.coreg.estwrite.ref={[P.workPath filesep 'Images_example' filesep 'avg152T1.nii,1']};
    
    CoregSourcePath=[P.workPath filesep 'Images_example' filesep 'No coregistered images'];
    
        CoregSourceFile=spm_select(Inf,'image','Select a normalized anatomical file',[],CoregSourcePath,'^w',1);
    
        matlabbatch{1,1}.spm.spatial.coreg.estwrite.source=cellstr(CoregSourceFile);
        matlabbatch{1,1}.spm.spatial.coreg.estwrite.other{1,1}=P.ICAgroup;
        if P.Source4 == 1 || P.NrSubj ~= 0
            len=1;
            for j=1:P.NrSubj
                for i=1:size(P.ICAfile,1)
                    matlabbatch{1,1}.spm.spatial.coreg.estwrite.other{len+1,1}=P.ICAfile{i,j};
                    len=length(matlabbatch{1,1}.spm.spatial.coreg.estwrite.other);
                end
            end
        end
        disp('Registering ICA files...')
        spm('defaults','fmri')            % Set defaults
        spm_jobman('initcfg');            % Initialise batch system
        spm_get_defaults('cmdline',true); % Use cmdline mode
        spm_jobman('run',matlabbatch);
        nameBefore_group=P.ICAgroup;
        whereSlash=findstr(nameBefore_group,filesep );
        P.ICAgroup=[nameBefore_group([1:whereSlash(end)]) 'r' nameBefore_group([whereSlash(end)+1:end])];
    
    for j=1:P.NrSubj
        for i=1:size(P.ICAfile,1)
            nameBefore=char(P.ICAfile{i,j});
            whereSlash=findstr(nameBefore,filesep );
            P.ICAfile(i,j)=cellstr([nameBefore([1:whereSlash(end)]) 'r' nameBefore([whereSlash(end)+1:end])]);
        end
    end
    P.image=[];
    guidata(handles.hF, P);
    loadImages(src)
    handles = guihandles(src);
    P = guidata(src);
end

disp('ICA Classification Started. Please wait...')

% get ROIs mask files
TempsPath=[P.workPath filesep 'Networks' filesep];
NodesPath=[P.workPath filesep 'Nodes_old' filesep];

k=1;
if get(findobj(handles.hF,'Tag','btnTemp01'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,3 '];
    NetworkName(k,:)=['Dorsal Attention               '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp02'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,18'];
    NetworkName(k,:)=['Auditory                       '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp03'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,19'];
    NetworkName(k,:)=['Basal_Ganglia                  '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp04'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,16'];
    NetworkName(k,:)=['Cerebellum                     '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp05'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,10'];
    NetworkName(k,:)=['Cognition/Emotion              '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp06'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,1 '];
    NetworkName(k,:)=['Default Mode, Dorsal/Posterior '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp07'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,8 '];
    NetworkName(k,:)=['Default Mode, Medial           '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp08'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,17'];
    NetworkName(k,:)=['Executive Control              '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp09'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,7 '];
    NetworkName(k,:)=['Frontoparietal, Left           '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp10'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,6 '];
    NetworkName(k,:)=['Frontoparietal, Right          '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp11'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,22'];
    NetworkName(k,:)=['Ventral Stream, Left           '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp12'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,14'];
    NetworkName(k,:)=['Ventral Stream, Right          '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp13'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,11'];
    NetworkName(k,:)=['Postcentral                    '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp14'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,12'];
    NetworkName(k,:)=['Precentral                     '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp15'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,21'];
    NetworkName(k,:)=['Precuneus                      '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp16'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,15'];
    NetworkName(k,:)=['Salience                       '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp17'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,13'];
    NetworkName(k,:)=['Sensorimotor                   '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp18'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,20'];
    NetworkName(k,:)=['Visual, Primary I              '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp19'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,9 '];
    NetworkName(k,:)=['Visual, Primary II             '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp20'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,5 '];
    NetworkName(k,:)=['Visual, Medial                 '];
    k=k+1;
end
if get(findobj(handles.hF,'Tag','btnTemp21'),'Value')==1
    Filename1(k,:)=[TempsPath 'rfMRI_ICA_d25.nii,2 '];
    NetworkName(k,:)=['Visual, Higher Level           '];
    k=k+1;
end

Vall2=spm_vol(deblank(Filename1));
temp=spm_read_vols(Vall2);
n2=size(temp,4); % number of templates

ClassifyDone=0;
if P.loadImagesDone==0
    loadImages(src)
end

compVec=[];

vec(1)=handles.btnTemp01.Value;
vec(2)=handles.btnTemp02.Value;
vec(3)=handles.btnTemp03.Value;
vec(4)=handles.btnTemp04.Value;
vec(5)=handles.btnTemp05.Value;
vec(6)=handles.btnTemp06.Value;
vec(7)=handles.btnTemp07.Value;
vec(8)=handles.btnTemp08.Value;
vec(9)=handles.btnTemp09.Value;
vec(10)=handles.btnTemp10.Value;
vec(11)=handles.btnTemp11.Value;
vec(12)=handles.btnTemp12.Value;
vec(13)=handles.btnTemp13.Value;
vec(14)=handles.btnTemp14.Value;
vec(15)=handles.btnTemp15.Value;
vec(16)=handles.btnTemp16.Value;
vec(17)=handles.btnTemp17.Value;
vec(18)=handles.btnTemp18.Value;
vec(19)=handles.btnTemp19.Value;
vec(20)=handles.btnTemp20.Value;
vec(21)=handles.btnTemp21.Value;
tmp_names=find(vec==1);

for subj=1:(P.NrSubj+1)
    
    if ClassifyDone==0
        disp(['Classifying networks for the group'])
        ClassifyDone=1;
        
        %% Spatial correlation computation loop
        Vall=spm_vol(deblank(P.ICAgroup));
        classImage=spm_read_vols(Vall);
        for i=1:n2 % templates
            for j=1:P.nrComp % ICA components
                if P.NrSubj<=1
                    M=corrcoef(temp(:,:,:,i),classImage(:,:,:,j,1),'rows','complete');
                else
                    M=corrcoef(temp(:,:,:,i),P.image(:,:,:,j,subj),'rows','complete');
                end
                N(i,j)=M(1,2);
            end
            [Y(i,:),I(i,:)]=sort(N(i,:),2,'descend'); % ranks correlations (Y is the spatial correlation value, I is the ICA component)
        end
        
        %% Classification loop
        class=zeros(1,n2); % class is the vector of already classified networks
        a=zeros(n2,P.nrComp); % a is the matrix of spatial correlations between component and most probable network
        b=zeros(n2,P.nrComp);
        a0=zeros(n2,P.nrComp); % a0 is the matrix of most probable network for a given component
        b0=zeros(n2,P.nrComp);
        D=zeros(n2,1);
        value=zeros(n2,P.nrComp);
        n_class_comp=0;
        prob=zeros(n2,P.nrComp);
        S.skip=0;
        tmp_not_def=n2;
        compVec=[];
        
        i=1;
        while i<=P.nrComp && tmp_not_def>0
            i
            if S.skip~=1
                for j=1:n2
                    k=1;
                    while a(j,i)==0
                        if nnz(I(j,k)==class)==0 % excludes already classified ICA components
                            a0(j,i)=I(j,k); % selects most probable ICA component
                            a(j,i)=Y(j,k); % selects first correlation value
                            k=k+1;
                        else
                            k=k+1;
                        end
                    end
                    if n_class_comp<P.nrComp-2
                        while b(j,i)==0
                            if nnz(I(j,k)==class)==0 % excludes already classified ICA components
                                b0(j,i)=I(j,k); % selects second most probable ICA component
                                b(j,i)=Y(j,k); % selects second correlation value
                                k=k+1;
                            else
                                k=k+1;
                            end
                        end
                        D(j,i)=(a(j,i)-b(j,i))*a(j,i); % difference between first and second spatial correlation values, excluding already classified ICA components
                        %         D(j,i)=a(j,i)-b(j,i);
                    else
                        D(j,i)=a(j,i);
                    end
                end
             
                [value(:,i),index]=sort(D(:,i),1,'descend'); % ranks difference (value is the difference value and index indicates where the most probable ICA component is alocated)
            end

            if S.skip~=1
                j=1;
            else
                j=sel_index+1;
            end
            
            while j<=length(class)
                if class(index(j))==0
                    idx_temp=index(j); % if no, the most probable component is selected (if not already classified to another template)
                    cor_values=N(idx_temp,:);
                    pos_cor_values=cor_values(cor_values>0);
                    prob=N(idx_temp,:)/sum(pos_cor_values)*100;
                    [prob_order,prob_index]=sort(prob,'descend');
                    prob_order(prob_order<0)=0;
                    sel_index=j;
                    break
                else
                    j=j+1;
                end
            end
            
            k=1;
            while 1==1
                if nnz(prob_index(k)==class)==0
                    sel_first_comp=prob_index(k);
                    sel_prob(1)=prob_order(k);
                    k=k+1;
                    break
                else
                    k=k+1;
                end
            end
            while 1==1
                if k<=P.nrComp-1
                    if nnz(prob_index(k)==class)==0
                        sel_second_comp=prob_index(k);
                        sel_prob(2)=prob_order(k);
                        k=k+1;
                        break
                    else
                        k=k+1;
                    end
                else
                    sel_second_comp=0;
                    sel_prob(2)=0;
                    sel_third_comp=0;
                    sel_prob(3)=0;
                    break
                end
            end
            if sel_second_comp~=0
                while 1==1
                    if k<=P.nrComp
                        if nnz(prob_index(k)==class)==0
                            sel_third_comp=prob_index(k);
                            sel_prob(3)=prob_order(k);
                            break
                        else
                            k=k+1;
                        end
                    else
                        sel_third_comp=0;
                        sel_prob(3)=0;
                        break
                    end
                end
            end
            if sel_prob(1)<=100
                if sel_second_comp~=0
                    img2=classImage(:,:,:,sel_second_comp);
                else
                    img2=classImage(:,:,:,sel_third_comp+1);
                end
                if sel_third_comp~=0
                    img3=classImage(:,:,:,sel_third_comp);
                else
                    img3=classImage(:,:,:,sel_third_comp+1);
                end
                S=manual_selection(temp(:,:,:,idx_temp),classImage(:,:,:,sel_first_comp), img2, img3, sel_prob, tmp_names(idx_temp), sel_second_comp, sel_third_comp);
                if S.skip~=1
                    if S.select(1)==1
                        class(idx_temp)=sel_first_comp;
                    elseif S.select(2)==1
                        class(idx_temp)=sel_second_comp;
                    else
                        class(idx_temp)=sel_third_comp;
                    end
                    clear sel_temp sel_first_comp sel_second_comp sel_third_comp
                end
            else
                class(idx_temp)=sel_first_comp;
                clear sel_temp sel_first_comp sel_second_comp sel_third_comp
            end
            if S.skip~=1
                n_class_comp=n_class_comp+1;
                i=i+1;
                tmp_not_def=n2-nnz(class)
            else
                tmp_not_def=tmp_not_def-1
                clear sel_temp sel_first_comp sel_second_comp sel_third_comp
            end
            class
        end
        tmp_names(find(class==0))=[];
    end
    
    classNetworkName=NetworkName;
    
    idx=subj-1;
    if idx>0
        wheressub=findstr(char(P.ICAfile(1,idx)),'sub');
        actualSubj=str2num(P.ICAfile{1,idx}(wheressub(end)+3:wheressub(end)+5));
    end
        
    if subj<=1
        fprintf(['\n' 'Positioning nodes for group ICA' '\n'])
        exc=[];
    elseif subj>1
        fprintf(['\n' 'Positioning nodes for subject ' num2str(actualSubj) '\n'])
    else % P.Source3==0
        fprintf(['\n' 'Positioning nodes for subject ' num2str(actualSubj) '\n'])
    end
    
    Vall=spm_vol(char(P.files(subj)));    
    image=spm_read_vols(Vall);
    
    [peak_value,compVec,x,y,z,MNIx,MNIy,MNIz,atlasInfo,exc,mask]=findPeaks(tmp_names,image,class,subj,compVec,exc,P.Separated,P.workPath);
    
    exc_network=[];
    j=1;
    compVecUni=unique(compVec);
    while j<=n2
        if class(j)==0 || nnz(class(j)==compVecUni)==0
            exc_network=[exc_network j];
        end
        j=j+1;
    end
    classNetworkName(exc_network,:)=[];

    if P.sphere == 1
        r=P.radius; % radius
    end
    
    if P.output == 0
        P.output=get(handles.edOutput, 'string');
    end
    
    if subj<=1
        outputFolder=([P.output filesep 'Group' filesep ]);
    elseif subj>1
        if subj==1
            outputFolder=([P.output filesep 'Group' filesep]);
        else
        if nnz(num2str(actualSubj))==1
            outputFolder=([P.output filesep 'Sub00' num2str(actualSubj) filesep]);
        elseif nnz(num2str(actualSubj))==2
            outputFolder=([P.output filesep 'Sub0' num2str(actualSubj) filesep]);
        else
            outputFolder=([P.output filesep 'Sub' num2str(actualSubj) filesep]);
        end
        end
    else
        if nnz(num2str(actualSubj))==1
            outputFolder=([P.output filesep 'Sub00' num2str(actualSubj) filesep]);
        elseif nnz(num2str(actualSubj))==2
            outputFolder=([P.output filesep 'Sub0' num2str(actualSubj) filesep]);
        else
            outputFolder=([P.output filesep 'Sub' num2str(actualSubj) filesep]);
        end
    end
    
    mkdir(outputFolder)
    
    roisListName='roi0';
    if exist('roisList')
        clear roisList info_cell
    end
    
    if subj<=1
        TXTfilename=[outputFolder 'ROIs_Description_group.txt'];
    elseif subj>1
        if subj==1
            TXTfilename=[outputFolder 'ROIs_Description_group.txt'];
        else
            TXTfilename=[outputFolder 'ROIs_Description_subj' num2str(actualSubj) '.txt'];
        end
    else
        TXTfilename=[outputFolder 'ROIs_Description_subj' num2str(actualSubj) '.txt'];
    end

    HeaderInfo=spm_vol([P.workPath filesep 'Images_example' filesep 'avg152T1.nii']);
    info_cell=[];
    network=1;
    for j=1:length(class)
        if class(j)~=0
            vec_comp=find(compVec==class(j));
            for m=1:length(vec_comp)
                if P.sphere==1
                    sphere_info = struct('label',(['sphere_' num2str(r) '_' num2str(MNIx(vec_comp(m))) '_' num2str(MNIy(vec_comp(m))) '_' num2str(MNIz(vec_comp(m)))]),'centre',[MNIx(vec_comp(m)) MNIy(vec_comp(m)) MNIz(vec_comp(m))],'radius', r); % in mm
                    clear sphere_roi
                    sphere_roi = maroi_sphere(sphere_info);
                    saveroi(sphere_roi, [outputFolder roisListName(1:end-(length(num2str(vec_comp(m)))-1)) num2str(vec_comp(m)) '.mat']);
                end
                roisList(m,:)=[outputFolder roisListName(1:end-(length(num2str(vec_comp(m)))-1)) num2str(vec_comp(m)) '.mat'];
            end
            if length(num2str(network))<=1
                str_network=['0' num2str(network)];
            else
                str_network=[num2str(network)];
            end
            if subj<=1
                if P.sphere==1
                    mars_rois2img(roisList, [outputFolder 'roisMask_group_network' str_network '.nii'],atlasInfo,P.creationMode)
                else
                    HeaderInfo.fname = [outputFolder 'roisMask_group_network' str_network '.nii'];
                    HeaderInfo.private.dat.fname = HeaderInfo.fname;
                    HeaderInfo.n=[1,1];
                    HeaderInfo.dt=[16 0];
                    spm_write_vol(HeaderInfo,mask(:,:,:,network));
                end
            elseif subj>1
                if subj==1
                    if P.sphere==1
                        mars_rois2img(roisList, [outputFolder 'roisMask_group_network' str_network '.nii'],atlasInfo,P.creationMode)
                    else
                        HeaderInfo.fname = [outputFolder 'roisMask_group_network' str_network '.nii'];
                        HeaderInfo.private.dat.fname = HeaderInfo.fname;
                        HeaderInfo.n=[1,1];
                        HeaderInfo.dt=[16 0];
                        spm_write_vol(HeaderInfo,mask(:,:,:,network));
                    end
                else
                    if P.sphere==1
                        mars_rois2img(roisList, [outputFolder 'roisMask_subj' num2str(actualSubj) '_network' str_network '.nii'],atlasInfo,P.creationMode)
                    else
                        HeaderInfo.fname = [outputFolder 'roisMask_subj' num2str(actualSubj) '_network' str_network '.nii'];
                        HeaderInfo.private.dat.fname = HeaderInfo.fname;
                        HeaderInfo.n=[1,1];
                        HeaderInfo.dt=[16 0];
                        spm_write_vol(HeaderInfo,mask(:,:,:,network));
                    end
                end
            else
                if P.sphere==1
                    mars_rois2img(roisList, [outputFolder 'roisMask_subj' num2str(actualSubj) '_network' str_network '.nii'],atlasInfo,P.creationMode)
                else
                    HeaderInfo.fname = [outputFolder 'roisMask_subj' num2str(actualSubj) '_network' str_network '.nii'];
                    HeaderInfo.private.dat.fname = HeaderInfo.fname;
                    HeaderInfo.n=[1,1];
                    HeaderInfo.dt=[16 0];
                    spm_write_vol(HeaderInfo,mask(:,:,:,network));
                end
            end
            
            if size(info_cell,1)==0
                ini=size(info_cell,1);
            else
                ini=size(info_cell,1)-1;
            end
            
            fid=fopen(TXTfilename,'w');
            
            info_cell{1,1}='Network';
            formatSpec = '%6s \r\n';
            for i=(ini+1):(ini+length(roisList(:,1)))
                info_cell{i+1,1}=num2str(network);
            end
            
            k=2;
            n=1;
            info_cell{1,2}='Label';
            formatSpec=[formatSpec(1:end-4) '%12s' formatSpec(end-4:end)];
            for i=(ini+1):(ini+length(roisList(:,1)))
                info_cell{i+1,k}=num2str(n);
                n=n+1;
            end
            k=k+1;
            if get(findobj(handles.hF,'Tag','btnTXT01'),'Value')==1
                info_cell{1,k}='Peak Value';
                formatSpec=[formatSpec(1:end-4) '%12s' formatSpec(end-4:end)];
                for i=(ini+1):(ini+length(roisList(:,1)))
                    info_cell{i+1,k}=num2str(peak_value(i));
                end
                k=k+1;
            end
            if get(findobj(handles.hF,'Tag','btnTXT02'),'Value')==1
                info_cell{1,k}='x';
                info_cell{1,k+1}='y';
                info_cell{1,k+2}='z';
                formatSpec=[formatSpec(1:end-4) '%12s %12s %12s' formatSpec(end-4:end)];
                for i=(ini+1):(ini+length(roisList(:,1)))
                    info_cell{i+1,k}=num2str(x(i));
                    info_cell{i+1,k+1}=num2str(y(i));
                    info_cell{i+1,k+2}=num2str(z(i));
                end
                k=k+3;
            end
            if get(findobj(handles.hF,'Tag','btnTXT03'),'Value')==1
                info_cell{1,k}='MNIx';
                info_cell{1,k+1}='MNIy';
                info_cell{1,k+2}='MNIz';
                formatSpec=[formatSpec(1:end-4) '%12s %12s %12s' formatSpec(end-4:end)];
                for i=(ini+1):(ini+length(roisList(:,1)))
                    info_cell{i+1,k}=num2str(MNIx(i));
                    info_cell{i+1,k+1}=num2str(MNIy(i));
                    info_cell{i+1,k+2}=num2str(MNIz(i));
                end
                k=k+3;
            end
            if get(findobj(handles.hF,'Tag','btnTXT04'),'Value')==1
                info_cell{1,k}='Resting State Network';
                formatSpec=[formatSpec(1:end-4) '%22s' formatSpec(end-4:end)];
                for i=(ini+1):(ini+length(roisList(:,1)))
                    if i==1
                        p=1;
                    elseif compVec(i)~=compVec(i-1)
                        p=p+1;
                    end
                    info_cell{i+1,k}=deblank(classNetworkName(p,:));
                end
                k=k+1;
            end
            if get(findobj(handles.hF,'Tag','btnTXT05'),'Value')==1
                info_cell{1,k}='Component Number';
                formatSpec=[formatSpec(1:end-4) '%12s' formatSpec(end-4:end)];
                for i=(ini+1):(ini+length(roisList(:,1)))
                    info_cell{i+1,k}=num2str(compVec(i));
                end
            end
            
            clear vec_comp roisList
            network=network+1;
            
            delete([outputFolder '*.mat'])
        end
    end
    
    [nrows,ncols] = size(info_cell);
    for row = 1:nrows
        fprintf(fid,formatSpec,info_cell{row,:});
    end
    
    fclose(fid);

end

return