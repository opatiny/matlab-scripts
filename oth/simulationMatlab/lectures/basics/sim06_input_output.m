%% SIM06 input/output

%% load/save
clear,clc

A=magic(5);  % create any data 
B=magic(6);     
% https://en.wikipedia.org/wiki/Magic_square

save data  % save total workspace in current directory in file data.mat 

save data1 B  % save variable B in current directory in file data1.mat 

clear       % clear workspace 
load data1 % read workspace from file data1.mat 
load data  % read workspace from file data.mat


% save in ASCII format instead binary .mat format
save '.\data.txt' A -ascii       

% every editor can read this file
! notepad data.txt
% show ASCII data in matlab with type 
type data.txt 

clear
load data.txt        % read into array named data
A=load('data.txt')   % read into array named data A

% alternatives
% readmatrix / writematrix    

%% operating system commands with a heading ! 
! dir   

%  there are also matlab commands (code does not depend on operating system)
% cd, copyfile, delete, mkdir, type, ...

% operating system commands and more
help general 

%% more output control with fprintf
clear,clc

% Create a file with an exponential table
x = 0:.1:1;
y = [x; exp(x)];

% fprintf uses format specification similar C
fid = fopen('exp.txt', 'w');
fprintf(fid, 'Zeit/s   Spannung/V \n');
fprintf(fid, '%6.2f %12.8f\n', y);
fclose(fid);

type exp.txt

data = readmatrix('exp.txt','NumHeaderLines',1)

%% more input control with fscanf (Low-Level I/O)
clear,clc

fid = fopen('exp.txt');
fscanf(fid,'%s %s',2);              % header
A = fscanf(fid, '%g %g', [2 inf]);  % data
fclose(fid);
A'

%% Flexibel: importdata/textscan
clear,clc

folder = './sim06_Dateien/';
data=load(strcat(folder, 'sim06_comma.txt'))     
% Problem 1: data in first line ist not numeric  (% comment first line)

data=load(strcat(folder, 'sim06_comma%.txt'))     
% Problem 2: decimal seperator is comma

% a) solution GUI: 
% HOME-importdata 
% Column delimiter Space
% Delimiter Options - decimal seperator - comma
% Range A2:H12 
% Output type - Numeric matrix
% import selection import data 

% b) solution script:  
% import selection generate function 
%    -> save importfile.m in current directory 
% more about matlab functions -> sim08
data = importfile(strcat(folder, 'sim06_comma.txt'))

%% exercise 6.1  
% read this file

type ./sim06_Dateien/sim06_temperature.txt
% and plot temparature over time

% data = importfile('./sim06_Dateien/sim06_temperature.txt')
data = sim06temperature;

plot(data(:,1), data(:,2));

%% read/write excel

num = xlsread('sim06_example.xls',2)   % Excel sheet 2

% to read non numerical data
% [num, text, raw] = xlsread('sim06_example.xls')
% text, raw are cell-arrays (-> sim16)

% doc xlswrite       


%% read/write binary files
% fread/fwrite

clear,clc
fid = fopen('sim06_temperature.txt', 'r');
data=fread(fid,[1,10]);    % read in 1x10-array  
fclose(fid);

% decode ASCII-format
char(data)

%% read web
url='https://www.oth-regensburg.de/typo3conf/ext/hsregensburg/Resources/Public/Images/oth-regensburg-logo.jpg';
rgb=webread(url);
imshow(rgb)

%% example: Letter frequencies in German/English  
% histogram (-> sim09)
clear,clf
name='James_Clerk_Maxwell';

lang='de';
url=['https://',lang,'.wikipedia.org/wiki/',name]
c=webread(url);
histogram(int8(c),int8('a'):int8('z')+1,'Normalization','probability');
hold on

lang='en';
url=['https://',lang,'.wikipedia.org/wiki/',name]
c=webread(url);
histogram(int8(c),[int8('a'):int8('z')+1],'Normalization','probability');

set(gca,'XTick',int8('aeiouy'))
set(gca,'XTickLabel',{'    a','    e','    i','    o','    u','    y'})
legend('de','en')

%% read textfiles 
clear,clc
% Read entire file as character array
txt = fileread('sample.xml')
% split into lines -> sim16 cellarray
line = regexp(txt, '\n', 'split')';
% make changes
line(2)={'<NEU!>'};
% save
writecell(line,'test.txt')

%% more I/O functions
help iofun


%% exercise 6.2
% the files sim06a.txt and sim06b.txt contain two measurements
% Create a line plot with all data
clear,clc


%% exercise 6.3
% use audioread.m to read the file sim06_sound.wav  
% and plot the amplitude of the two stereo channels over time [s]
% Please note the sampling rate -> doc audioread
clear,clc



