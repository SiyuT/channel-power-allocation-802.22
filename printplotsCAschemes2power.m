% plot performance of 4 distributed schemes under two ways deciding the
% maximal power map
%  output1: average Power
%  output2: average QuasiSINR
%  output3: sinr on end users


function printplotsCAschemes2power(plotLog, n, powerHistory, averageSinrHistory, SINR_ETs_random, SINR_ETs_whitecat, SINR_ETs_whitecase, SINR_ETs_noregret, SINR_ETs_lindo, powerHistory2, averageSinrHistory2, SINR_ETs_random2, SINR_ETs_whitecat2, SINR_ETs_whitecase2, SINR_ETs_noregret2, SINR_ETs_lindo2)
% the latter snrRatio_random, snrRatio_whitecat, snrRatio_whitecase,
% snrRatio_noregret are sinr on each WBS in the last run, which is a
% intersection for sinr in one run

% 2nd data is cvx
            
figure(plotLog+1);        


%   average qusai SINR on reference position
%             subplot(2,1,1)

%             labels = {'Maximal power map obtained from LP' 'Maximal power map obtained from CVX'};
%             h1 = bar([mean(powerHistory2,2)';mean(powerHistory,2)']);
%             set(gca, 'XTick', 1:2, 'XTickLabel', labels);
%             grid on
%             title(['Averaged average power consumption of all WBs over different simulations'])
%             ylabel(['transmission power (W)']);
%             l1 = legend('Rand', 'WhiteCat', 'WhiteCase',  'Noreg');
%             set(l1, 'Box', 'off');
%             set(l1,'Location','North');
%             set(l1,'Orientation','horizon');

% use barweb function 
handle1=barweb([mean(powerHistory2,2)';mean(powerHistory,2)'], [1.96*std(powerHistory2,1,2)'/sqrt(n); 1.96*std(powerHistory,1,2)'/sqrt(n)], [], {'linear optimization formulation'; 'convex optimization formulation'}, [], [], 'Average transmission power of each WBS (W)', bone, 'y', {'random allocation'; 'whiteCat'; 'whiteCase'; 'noregret learning' ; 'optimization'}, 2, 'plot')
set(handle1.legend,'Location','southeast', 'FontSize', 10, 'Color', 'R');
    set(handle1.legend, 'xcolor', 'w','ycolor', 'w');
% the x coordinate of the two groups are 1 and 2
%axis([0.45 2.55 20 40]);

figure(plotLog+2);              
            
%             subplot(2,1,2)
%             h2= bar([mean(averageSinrHistory2,2)'; mean(averageSinrHistory,2)']); 
%             set(gca, 'XTick', 1:2, 'XTickLabel', labels);            
%             grid on
%             title(['Averaged average qusai SINR of all WBs over different simulations'])
%             ylabel(['qusai SINR (db)']);

handle2=barweb([mean(averageSinrHistory2,2)';mean(averageSinrHistory,2)'], [1.96*std(averageSinrHistory2,1,2)'/sqrt(n); 1.96*std(averageSinrHistory,1,2)'/sqrt(n)], [], {'linear optimization formulation'; 'convex optimization formulation'}, [], [], 'Average Quasi SINR of each WBS (dB)', bone, 'y', {'random allocation'; 'whiteCat'; 'whiteCase'; 'noregret learning' ; 'optimization'}, 2, 'plot')
set(handle2.legend,'Location','southeast', 'FontSize', 10, 'Color', 'R');
    set(handle2.legend, 'xcolor', 'w','ycolor', 'w');
% the x coordinate of the two groups are 1 and 2
%axis([0.45 2.55 0 10]);

figure (plotLog+3)
% h = cdfplot(SINR_ETs_random; SINR_ETs_whitecat; SINR_ETs_whitecase; SINR_ETs_noregret);
    h1 = cdfplot(SINR_ETs_random);
    set(h1, 'Color','k', 'LineStyle', '-');
    hold on
    h2 = cdfplot(SINR_ETs_whitecat);
    set(h2, 'Color','g', 'LineStyle', '-');
    hold on
    h3 = cdfplot(SINR_ETs_whitecase);
    set(h3, 'Color', 'r', 'LineStyle', '-');
    hold on
    h4 = cdfplot(SINR_ETs_lindo);
    set(h4,'Color','m','LineStyle', '-');
    hold on
    h5 = cdfplot(SINR_ETs_noregret);
    set(h5,'Color','b',  'LineStyle', '-');
    
    
    % the other group:
    h1cvx = cdfplot(SINR_ETs_random2);
    set(h1cvx, 'Color','k', 'LineStyle', '-.');
    hold on
    h2cvx = cdfplot(SINR_ETs_whitecat2);
    set(h2cvx, 'Color','g', 'LineStyle', '-.');
    hold on
    h3cvx = cdfplot(SINR_ETs_whitecase2);
    set(h3cvx, 'Color', 'r', 'LineStyle', '-.');
    hold on
    h4 = cdfplot(SINR_ETs_lindo2);
    set(h4,'Color','m',  'LineStyle', '-.');
    hold on
    h5cvx = cdfplot(SINR_ETs_noregret2);
    set(h5cvx,'Color','b',  'LineStyle', '-.');    
% 	axis([15 30 0.4 1]);% lower SINR part figure
    %axis([1 100 0 1]);
    axis([1 100 0 1]);

%       A nice way to have specific y scale    
%     % Convert y-axis values to percentage values by multiplication
%     a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
%     % Create a vector of '%' signs
%     pct = char(ones(size(a,1),1)*'%'); 
%     % Append the '%' signs after the percentage values
%     new_yticks = [char(a),pct];
%     'Reflect the changes on the plot
%     set(gca,'yticklabel',new_yticks);

    
%    set (gcf,'Position',[232 246 560 300]); % size of plot
%    set(gca, 'Position', [.13 .17 .80 .74]); % the percentage of X, Y axis in the plot
    set(gca, 'XScale', 'log');
    legend('LP-random', 'LP-whiteCat','LP-whiteCase',  'LP-optimization','LP-noregretLearning', 'CVX-random', 'CVX-whiteCat','CVX-whiteCase',  'CVX-optimization','CVX-noregret', 'Location', 'southeast');
%, 'EdgeColor', 'W'
% legend('boxoff');
    set(legend, 'xcolor', 'w','ycolor', 'w');

    title('Cumulative distribution of SINR on end terminals for different distributed schemes');
   
    xlabel('SINR (dB)');
    ylabel('X 100%')
    magnify;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure (plotLog+4)
% h = cdfplot(SINR_ETs_random; SINR_ETs_whitecat; SINR_ETs_whitecase; SINR_ETs_noregret);
SINR_ETs_random = 6*(1e+6)*log2(1.+SINR_ETs_random);
    h1 = cdfplot(SINR_ETs_random);
    set(h1, 'Color','k', 'LineStyle', '-');
    hold on
    
SINR_ETs_whitecat = 6*(1e+6)*log2(1.+SINR_ETs_whitecat);
    h2 = cdfplot(SINR_ETs_whitecat);
    set(h2, 'Color','g', 'LineStyle', '-');
    hold on
    
SINR_ETs_whitecase = 6*(1e+6)*log2(1.+SINR_ETs_whitecase);  
    h3 = cdfplot(SINR_ETs_whitecase);
    set(h3, 'Color', 'r', 'LineStyle', '-');
    hold on
    
SINR_ETs_lindo = 6*(1e+6)*log2(1.+SINR_ETs_lindo);    
    h4 = cdfplot(SINR_ETs_lindo);
    set(h4,'Color','m','LineStyle', '-');
    hold on
    
SINR_ETs_noregret = 6*(1e+6)*log2(1.+SINR_ETs_noregret);     
    h5 = cdfplot(SINR_ETs_noregret);
    set(h5,'Color','b',  'LineStyle', '-');
    
    
    % the other group:
SINR_ETs_random2 = 6*(1e+6)*log2(1.+SINR_ETs_random2);    
    h1cvx = cdfplot(SINR_ETs_random2);
    set(h1cvx, 'Color','k', 'LineStyle', '-.');
    hold on
    
SINR_ETs_whitecat2 = 6*(1e+6)*log2(1.+SINR_ETs_whitecat2);      
    h2cvx = cdfplot(SINR_ETs_whitecat2);
    set(h2cvx, 'Color','g', 'LineStyle', '-.');
    hold on
    
SINR_ETs_whitecase2 = 6*(1e+6)*log2(1.+SINR_ETs_whitecase2);      
    h3cvx = cdfplot(SINR_ETs_whitecase2);
    set(h3cvx, 'Color', 'r', 'LineStyle', '-.');
    hold on
    
SINR_ETs_lindo2 = 6*(1e+6)*log2(1.+SINR_ETs_lindo2);       
    h4 = cdfplot(SINR_ETs_lindo2);
    set(h4,'Color','m',  'LineStyle', '-.');
    hold on
    
SINR_ETs_noregret2 = 6*(1e+6)*log2(1.+SINR_ETs_noregret2);         
    h5cvx = cdfplot(SINR_ETs_noregret2);
    set(h5cvx,'Color','b',  'LineStyle', '-.');    
% 	axis([15 30 0.4 1]);% lower SINR part figure
    %axis([1 100 0 1]);
    axis([1 100 0 1]);

%       A nice way to have specific y scale    
%     % Convert y-axis values to percentage values by multiplication
%     a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
%     % Create a vector of '%' signs
%     pct = char(ones(size(a,1),1)*'%'); 
%     % Append the '%' signs after the percentage values
%     new_yticks = [char(a),pct];
%     'Reflect the changes on the plot
%     set(gca,'yticklabel',new_yticks);

    
%    set (gcf,'Position',[232 246 560 300]); % size of plot
%    set(gca, 'Position', [.13 .17 .80 .74]); % the percentage of X, Y axis in the plot
    set(gca, 'XScale', 'log');
    
    
        % multiplication
        a=[cellstr(num2str(get(gca, 'ytick')'*100))];
        % create a vector of '%' signs
        pct = char(ones(size(a,1),1)*'%');
        % append the '%' signs after the percentage values
        new_yticks =[char(a), pct];
        % reflect the changes on the plot
        set(gca, 'yticklabel', new_yticks);
        
        
    legend('LP-random', 'LP-whiteCat','LP-whiteCase',  'LP-optimization','LP-noregretLearning', 'CVX-random', 'CVX-whiteCat','CVX-whiteCase',  'CVX-optimization','CVX-noregret', 'Location', 'southeast');
%, 'EdgeColor', 'W'
% legend('boxoff');
    set(legend, 'xcolor', 'w','ycolor', 'w');

    title('Cumulative distribution of throughput on end terminals for different distributed schemes');
   
    xlabel('bits/s');
%     ylabel('X 100%')
    magnify;

    
    

