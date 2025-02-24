%% Quick script to record and save sound
clc; clear; close all;

recordingLength = 3; % [s] - recording length
fe = 20000; % [Hz] - sampling frequency
filename = 'recording.wav'; % - File to save to

recorder = audiorecorder(fe,16,1);
fprintf('Start recording...')
recordblocking(recorder,recordingLength);
fprintf('End recording.')
xt = getaudiodata(recorder);
play(recorder);

audiowrite(filename, xt, fe);