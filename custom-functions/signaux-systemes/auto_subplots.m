%% Plot N different discrete signals in subplots
function auto_subplots(signals, height, width) 
index = 1;
figure();
for i=1:height
    for j=1:width
        subplot(height,width,index);
        nn = 0:length(signals{index})-1;
        plot(nn,signals{index},'.');
        xlabel('n [-]');
        title(strcat('x', string(index), '[n]'));
        grid on;
        index = index+1;
    end
end
end