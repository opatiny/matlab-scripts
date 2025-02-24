%% Plot many discrete signals in subplots
function auto_subplots(signals) 
index = 1;
figure();
for i=1:2
    for j=1:3
        subplot(3,2,index);
        nn = 0:length(signals{index})-1;
        plot(nn,signals{index},'.');
        xlabel('n [-]');
        title(strcat('x', string(index), '[n]'));
        grid on;
        index = index+1;
    end
end
end