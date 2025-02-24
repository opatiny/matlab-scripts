%% sim 16 more data types
% string, structure, cell, table

%% -------------------------------------------------------------------------
%% I Characters und strings
%% -------------------------------------------------------------------------
clear,clc

a=1        % array
b='Hallo'  % character
b1=[b,b]
b2=[b;b]   % character array
b2(2,:)
b2(3,:)='world'
% alle all rows in a character array must be of equal size
b2(4,:)='wide'  

% char() appends blank characters
b3 = char('world','wide','web')
% what strtrim () undoes
strtrim(b3(3,:))

strtrim('  jjh fds   ')

% Since 2017a there is the more flexible data type: string
b3 = ["world";"wide";"web"]
% join, split, compare, edit, find replace, ...
% https://de.mathworks.com/help/matlab/characters-and-strings.html


% even more flexible are the data types structure, cell and table
% they allow mixing of data types (string, array, ...)

%% -------------------------------------------------------------------------
%% II structure (vgl. C) 
%% -------------------------------------------------------------------------
% structures are similar to cells (multiple data types), but are access
% using property names and not indices
clear,clc

% create with .
A.Name='Meier';
A.GebDat='2.2.1980';
A.PLZ=93053;
A.data=[1,2,3; 11, 12 13]

% 
fieldnames(A)

% access with .
A.Name(1)='R'

% structures can help to organize the 
% workspace in large projects
clear
MAT.matA.rho=1;     % density
MAT.matA.visc=2;    % viscosity
MAT.matB.rho=1;

MAT.matB.visc=2;

GEO.bauteilA.l=1;   % length
GEO.bauteilA.b=2;   % width
GEO.bauteilA.h=2;   % height

GEO.bauteilB.l=1;    
GEO.bauteilB.b=2;    

% Parameter passing from and to functions is clearer
% e.g. statik_struct = calcfct(GEO.deviceA, MAT.deviceA)

% example
clf
h=plot(1:9,(1:9).^2,'-r*');
title('hallo')
x=handle2struct(h)
% figure info: Color, Marker, Data, ...
x.properties

%% example importdata
% reads file content into a structure
clear,clc
[X,delimiter,headerlines] = importdata('sim16_data.csv')
% X.data contains numeric values in a double array
X.data
% X.textdata contains text in a cell-array
X.textdata       

%% -------------------------------------------------------------------------
%% III cell 
%% -------------------------------------------------------------------------
% the fields are not addressed via names, like struct, but via 
% numerical indexing as with the array data type
clear,clc

% cell
B={'Meier','2.2.1980','93053'}
% Watch out: [ instead { -> String
Bs=['Meier','2.2.1980','93053']

% also allows to combine different data types into one unit
B{4}=ones(3)
B{5}=@(x) x.^2

% Overview
celldisp(B)
cellplot(B)

%% Create cell arrays
% There is a difference between cell-indexing () and content-indexing {}
clear
% example: At the position xy of a lake the 
% water temperature is measured at different depths
xy_Lage=[2,2];  % xy-coordinates on the lake [m]
z_T=[3,15;      % depth z[m], temperature T[°C]
     4,14;
     5,12];

% combine to a cell-array using curly bracket
Messung = {xy_Lage,z_T}
celldisp(Messung)

Messung{1,2}(end,:)
% or
clear Messung
Messung(1) = {xy_Lage};
Messung(2) = {z_T};
cellplot(Messung)

% also complex structures can be defined
% e.g. measurements on different days

Tag = 1;    % day 1: various measurements on three locations
MessReihe{Tag,1}= {[2,2],[  3,15;   4,14;   5,12]}                      
MessReihe{Tag,2}= {[2,3],[3.5,16; 4.5,11; 5.5, 9]}
MessReihe{Tag,3}= {[3,4],[  1,19;   2,18]}

% day 3: 3 measurements on location 5
MessReihe{3,5}={[2,3],[2,14; 4,10; 6, 8]}   

% day 2: no measurements
[MessReihe{2,:}]=deal('no measurements');  
cellplot(MessReihe)

% access
ort_array = Messung{1}  % content {} returns data type array
ort_cell = Messung(1)   % pointer () returns data type cell 

Tag=1;Ort=2;
MessReihe{Tag,Ort}{1} % Index 1 = coordinates of location
MessReihe{Tag,Ort}{2} % Index 2 = measured values (depth, temperature)
MessReihe{Tag,Ort}{2}(3,:) % (depth, temperature) of measurement 3

% day 4 = day 2 
MessReihe(4,:)=MessReihe(2,:),cellplot(MessReihe)
% delete day 4 
MessReihe(4,:)=[],cellplot(MessReihe)

%% exercise 16.1: 

B={'Meier','2.2.1980','93053'}
% Mr. Meier -> Mr. Maier
B{1} = 'Maier' 


% delete the last measurement on day 3 at location 5  (6m,8°C) 
MessReihe{3,5}{2}(end,:) = [], cellplot(MessReihe)
%% example varargin 
% Variable-length input argument list 
% e.g. plot command
% plot(x)
% plot(x,y)
% plot(x,y,'r')
% plot(x,y,'color',[.5 .7 .3],'linestyle','-.')
% the parameters are saved in the cell-array varargin 
%
% function varargout =  myfunction(varargin)
% help varargin, nargin, varargout, nargout

%% example xlsread 
% [num,TXT,RAW]=xlsread(FILE)
% TXT, RAW are cell-arrays
[num,TXT,RAW]=xlsread('sim06_example')


%% -------------------------------------------------------------------------
%% IV Table 
%% -------------------------------------------------------------------------
% the data type of columns can be different
% but the number of rows must be the same
clear,clc
voltage=[10; 20; 30; 40 ; 50];
current=[0.01; 0.02; 0.03; 0.04; 0.05];
power=voltage.*current;

% content of tables can be accessed with name or index
T = table(voltage, current, power)
T.R = voltage./current
T(1:3,:)
% access content
T{1:3,:}

% read variable names
varnames = T.Properties.VariableNames

% add column names
time  = {'8:00'; '9:00'; '10:00'; '10:30'; '11:15'};
T.Properties.RowNames = time

% Table variables can be assigned description and units
T.Properties

% a part of a table can be accessed by name or index
T({'8:00','10:30'},:)
T([1,4],:)
T('9:00',{'current', 'power'})

%% exercise 16.2 
% Swap voltage and current in the table
T(:,[2,1,3:end])

%% read table
T = readtable('sim16_data.csv','ReadRowNames',true)

%% exercise 16.3
% add a column 'TestAvg' to T, which contains the mean value of the three
% test results

% caution with brackets!!!
round = T(:,[2:end])
curly = T{:,[2:end]}

T.TestAvg = mean(T{:,[2:end]},2)


%% Grouping variables
varfun(@mean,T,'InputVariables','TestAvg',...
    'GroupingVariables','Gender')

% similar: arrayfun, cellfun, structfun
% Hint: HOME - Find Files - containing text: arrayfun

% change variable names
T.Properties.VariableNames{end} = 'Mittelwert'

%% Conversion between the data types
clear, clc
% data pf polymers in cell-array
% name, abbreviation, melting temperature, Crystallization temperature, density
Polymer_Cell = {'Polyethylene',   'PE',  135,  56, 0.96;
    'Polypropylene',              'PP',  171,  86, 0.95;
    'Polyoxymethylene',           'POM', 180,  90, 1.42;
    'Polyethylene terephthalate', 'PET', 266, 158, 1.38};

% convert to structure
Field = {'Name', 'Abbreviation', 'Melting', 'Crystallization', 'Density'};
dimensions = 2;
Polymer_Structure = cell2struct(Polymer_Cell, Field, dimensions);

% convert to table
Polymer_Table = cell2table(Polymer_Cell, 'VariableNames', Field)

% read melting temperature of PET
PET_Melting = Polymer_Cell{4,3}
PET_Melting = Polymer_Structure(4).Melting
PET_Melting = Polymer_Table.Melting(4)
PET_Melting = Polymer_Table{4,3}

%% Stacked Plot

load outdoors
outdoors(1:3,:)
degreeSymbol = char(176);
newYlabels = {'RH (%)',['T (' degreeSymbol 'F)'],'P (in Hg)'};
stackedplot(outdoors,'Title','Weather Data','DisplayLabels',newYlabels)

%% Stacked Plot not only for table data

stackedplot(0:4:20,randi(100,6,3))
