

fileType = '.eps';
addpath('C:\Users\MetxChris\Documents\MATLAB\MMM Package\Supporting Functions');
addpath('C:\Users\MetxChris\Documents\MATLAB\MMM Package\Required Files');
filePath = 'C:\Users\MetxChris\Documents\Potts\';

tickFontSize = '\fontsize{9}{10}\selectfont ';
labelFontSize = '\fontsize{11}{10}\selectfont ';
varFontSize = '\fontsize{14}{12}\selectfont ';
textPosX = 1.93;
textPosY = 2.73;

% Color Order = {Blue, Green, Red, Purple, Orange, Yellow, Black, Gray}
lineColor = {...
    [0.094 0.353 0.663], [0.933 0.180 0.184], [0 0.549 0.282],          ...
    [0.4 0.173 0.569],   [0.957 0.490 0.137], [251/255 184/255 39/255],  ...
    1-[0 0.549 0.282], 1-[0.933 0.180 0.184], ...
    [0.3 0.3 0.3],       [0.7 0.7 0.7],  ...
    [0.0 0.253 0.563], [0.833 0.080 0.084], [0 0.449 0.182],          ...
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255],  ...
        [0.094 0.353 0.663], [0.933 0.180 0.184], [0 0.549 0.282],          ...
    [0.4 0.173 0.569],   [0.957 0.490 0.137], [251/255 184/255 39/255],  ...
    1-[0 0.549 0.282], 1-[0.933 0.180 0.184], ...
    [0.3 0.3 0.3],       [0.7 0.7 0.7],  ...
    [0.0 0.253 0.563], [0.833 0.080 0.084], [0 0.449 0.182],          ...
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255],  ...
        [0.094 0.353 0.663], [0.933 0.180 0.184], [0 0.549 0.282],          ...
    [0.4 0.173 0.569],   [0.957 0.490 0.137], [251/255 184/255 39/255],  ...
    1-[0 0.549 0.282], 1-[0.933 0.180 0.184], ...
    [0.3 0.3 0.3],       [0.7 0.7 0.7],  ...
    [0.0 0.253 0.563], [0.833 0.080 0.084], [0 0.449 0.182],          ...
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255],  ...
        [0.094 0.353 0.663], [0.933 0.180 0.184], [0 0.549 0.282],          ...
    [0.4 0.173 0.569],   [0.957 0.490 0.137], [251/255 184/255 39/255],  ...
    1-[0 0.549 0.282], 1-[0.933 0.180 0.184], ...
    [0.3 0.3 0.3],       [0.7 0.7 0.7],  ...
    [0.0 0.253 0.563], [0.833 0.080 0.084], [0 0.449 0.182],          ...
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255],  ...
    }; 

%     [~,~]=dos('taskkill /f /im "i_view32.exe"');
sizeScale = 0.75;

bs      = 10.5;            %Base Font-Size
titS    = bs + 1.0;       %Title Size
subS    = bs -1.5;     %Subtitle Size
legS    = bs + 0.5;     %Legend Size
tickS   = bs + 0;       %Tick Label Size
labS    = bs +2.0;        %Axis Label Size
uS      = bs;           %Units Size


axesWidth  = 2.8*sizeScale;   %Width of Axes
axesHeight = 1.9*sizeScale;   %Height of Axes

bs = bs*sizeScale;
titS = titS *sizeScale;
subS = subS*sizeScale;
legS = legS*sizeScale;
tickS = tickS*sizeScale;
labS = labS*sizeScale;
uS=uS*sizeScale;
    
useTitle    = 0;    %Use Axes Title
useSubTitle = 1;    %Use Axes Subtitle
plotMode =1;

for varNumber = 1010
 
    % Default Arguments
    plotTitle='';subTitle='';
    plotRes=1;yA='';minR=0;maxR=1;
    xAdjustment=1;yAdjustment=1;moveY_Default=12;moveY=moveY_Default;
    legLocation = 'best';clear varY leg;extraVar = 0;
    xTickMarks=[];yTickMarks=[];MAXY=[];MINY=[];MAXX=[];MINX=[];
    delLegend=0;noMax=0;plotAxis=[];plotError=0;legBoxOff=1;
    yprec='%1.1f';xprec='%1.1f';swapChildren=0;minorTicks=0;q=0;qq=0;
    
    switch varNumber
              case {1001,1002,1003,1004,1005,1006,1007,1008,1009,1010} % q = bin8 (7)
          var=ClockS;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$32^2$ grid, $10^6$ sweeps, test';
%             subTitle = '$(Z_2\!\times\! Z_2\!\times\! Z_2)^{*}_{124}$ Model, $32^2$ grid, $10^4$ sweeps, Bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            switch varNumber
                case 1001
                    fileName = '2d test, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                    
                case 1002
                    fileName = '2d test, E_a';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 1003
                    fileName = '2d test, X_a';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.3f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);

                case 1004
                    fileName = '2d test, C_a';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';lC{vN}=[0.2 0.2 0.2];mS{vN}=4;
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont N}$ ';
                    xprec='%1.2f';yprec='%1.0f';%moveY=36;
                    yN=11;MAXY=6;MINX=0.25;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                                        vN=2;varX{vN}=varX{1};varY{vN}=smooth(varY{1},15);
                    leg{vN}='$f(x)=ax^b$';lT{vN}='-';lW{vN}=1.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 1005
                    fileName = '2d test, X_b_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 1006
                    fileName = '2d test, C_b_ln';legLocation='southeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 1007
                    fileName = '2d test, M4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '($V_m)^4$ ';moveY=25;
                    yN=8;
                    varY{vN}=var(:,8);yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
%                     varY{vN}=log(abs(var(:,yN)));
                case 1008
                    fileName = '2d test, E4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$(V_E)^4$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                   yN=9;
                    varY{vN}=var(:,9);yprec='%1.2f';
%                     varY{vN}=log(abs(var(:,yN)));
                case 1009
                    fileName = '2d test, M_ln';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$\log |\left<M\right>|$ ';moveY=24;
                   yN=2;
                  
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.2f';
                case 1010
                    fileName = '2d test, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 2, 1 );
gof = struct( 'sse', cell( 2, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], ClockS );

% Set up fittype and options.
ft = fittype( 'power2' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf];
opts.StartPoint = [1.16379318544881 0.0337139872459327 0.000123933465686949];
opts.Upper = [Inf Inf Inf];

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult{1}, xData, yData, 'predobs', 0.9 );hold all;
legend( h, 'ClockS', 'untitled fit 1', 'Lower bounds (untitled fit 1)', 'Upper bounds (untitled fit 1)', 'Location', 'NorthEast' );
% Label axes
ylabel( 'ClockS' );
grid on

%% Fit: 'untitled fit 2'.
[xData, yData] = prepareCurveData( [], ClockSS );

% Set up fittype and options.
ft = fittype( 'power2' );
opts = fitoptions( ft );
opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf];
opts.StartPoint = [1.25203013073909 0.0546399632757897 3.05539254152114e-05];
opts.Upper = [Inf Inf Inf];

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );

% Plot fit with data.

h = plot( fitresult{2}, xData, yData, 'predobs', 0.9 );
legend( h, 'ClockSS', 'untitled fit 2', 'Lower bounds (untitled fit 2)', 'Upper bounds (untitled fit 2)', 'Location', 'NorthEast' );
% Label axes
ylabel( 'ClockSS' );hold off;
            end  
           

        otherwise
            continue;
    end

    %Slightly indent x tick-marks
    xTickTab = '\hspace{0.3em}';
    
    %Create Full Labels
    labelX1 = strjoin({fs(labS),' ',labelX1},'');
    labelY1 = strjoin({fs(labS),labelY1},'');
    if ~isempty(labelY2)
        labelY2 = strjoin({fs(uS),' ',labelY2},'');
    end
    if ~isempty(labelX2)
        labelX2 = strjoin({fs(uS),' ',labelX2},'');
    end
    labelY = strjoin({labelY1,labelY2},'');
    labelX = strjoin({labelX1,labelX2},'');
    
    %Open Figure
    figH=figure;
    set(figH, 'defaulttextinterpreter', 'latex')


    %Plotting Loop

            
    %Adjustable Plot Range
    varS = 1;
    pos1 = max(round(minR*varS),1);
    pos2 = round(maxR*varS);
    

  
    
    %Plot Standard Error

    
    % Plot Tc based on q-value
    if q>0
        x = 2/(log(1+sqrt(q)));
%         plot([x x],[minY 1.05*maxY],':','linewidth',0.25,'markersize',4,'color',[0.75 0.75 0.75]);swapChildren=1;leg{vN+1} = '$T_c$';
        plot(4*pi^2/0.89*[1/25 1/36 1/64 1/(27^2)],[minY minY minY minY],'.','linewidth',14.5,'markersize',10,'color',[0 0 0]);swapChildren=0;%leg{vN+1} = '$T_c$';
    end
    if plotError
        boundedline(varX{1},DataM,DataS,'-','cmap',lC{1});
    end
    % End of Plotting
    hold off;
    
    % Create Legend
    legH = legend(leg);
    
    %Adjust Bounds
    if ~noMax
        if minY < 0
            minY = 1.01*minY;
        else
            minY = 0.99*minY;
        end
        if maxY < 0
            maxY = 0.99*maxY;
        else
            maxY = 1.01*maxY;
        end
        
        %Manual Bounds
        if ~isempty(MAXY)
            maxY = MAXY;
        end
        if ~isempty(MINY)
            minY = MINY;
        end
        if ~isempty(MAXX)
            maxX = MAXX;
        end
        if ~isempty(MINX)
            minX = MINX;
        end
    end
    
    %Create Axes
    set(gca, 'units', 'inches', 'position', [0.75 0.75 axesWidth axesHeight])
    if minorTicks
     set(gca,'XMinorTick','on','YMinorTick','on')
    end
    %File Name
    printName =[filePath, fileName, fileType];
    
    %y-label Adjustment
    if moveY == moveY_Default
        if strcmp(yprec,'%1.1f')
            moveY = 16;
        elseif strcmp(yprec,'%1.2f')
            moveY = 24;
        end
    end
    
    %Set Axis Bounds
    if ~noMax
        plotAxis=[minX maxX minY maxY]
        axis(plotAxis);
    end
    
    %Swap plotting order (last most element on top)
    if swapChildren
        chH = get(gca,'Children');
        set(gca,'Children',[chH(2:end);chH(1)]);
    end
    cmapline;c=colorbar('location','eastoutside');
    axpos = get(gca,'Position');
cpos = get(c,'Position');
cpos(1)=0.80*cpos(1);
cpos(2)=0.75*cpos(2);
cpos(3) = 0.3*cpos(3);
cpos(4) = 0.72*cpos(4);
set(c,'Position',cpos)
set(gca,'Position',[axpos(1) axpos(2) 1.28*axpos(3) axpos(4)])
    %Disable Legend Outline
    if legBoxOff
        legend('boxoff')
    else
        legH=legend(legT,'EdgeColor',[1 1 .999]);
%          set(legH,'Xcolor',[1 1 1],'Ycolor',[1 1 1],'EdgeColor',[1 1 1],'color',[1 1 1]);
    end
    
    %Set Label Font-sizes
    xlabel(labelX, 'fontsize',labS);
    ylabel(labelY, 'fontsize',labS);
    
    %Turn on LaTeX Interpreter
    set(0, 'defaulttextinterpreter', 'latex')
    
    if ~isempty(yTickMarks)
        set(gca,'ytick',yTickMarks);
    end        
    if ~isempty(yprec)
        yt=get(gca,'YTick');
        tempLabel=num2str(yt(:), yprec);
        set(gca,'YTickLabel',tempLabel);
        [r,c]=size(tempLabel);
        clear yTemp;
        for j=1:r
            yTemp{j} = strjoin({'$',tempLabel(j,:),'$'},'');
        end
        
    end
    if ~isempty(xTickMarks)
        set(gca,'xtick',xTickMarks);
    end


    if ~isempty(xprec)
        xt=get(gca,'XTick');
        tempLabel=num2str(xt(:), xprec);
        set(gca,'XTickLabel',tempLabel);
        [r,c]=size(tempLabel);
        clear xTemp;
        for j = 1:r
            xTemp{j} = strjoin({'$',tempLabel(j,:),'$'},'');
            
        end
        
    end
    
    if ~isempty(plotAxis)
        if plotAxis(1) == 0
            xTemp{1} = ['$0$'];
        end
        if plotAxis(3) == 0
            yTemp{1} = ['$0$'];
        end
        
    end
    
    xTemp{1} = strjoin({xTickTab,xTemp{1}},'');
    
    [hx,hy] = format_ticks(gca,xTemp,yTemp,[],[],[],[],[],'FontSize',tickS,'FontSize',tickS);
    
    yH = get(gca,'YLabel');
    set(yH,'units','pixels');
    yP = get(yH,'position');
    
    xH = get(gca,'XLabel');
    set(xH,'units','pixels');
    xP = get(xH,'position');
    
    set(yH, 'position', [yP(1)-moveY, yP(2)])
    set(xH, 'position', [xP(1), xP(2)-4])
    
    %Invisible Axes for Title Positioning
    axes('units','inches','position',...
        [0.75 0.75 axesWidth axesHeight],'visible','off');
    
    %Create Subtitle
    if useSubTitle==1
        subH = text(0.5 +0.00*axesWidth ,1+0.07/axesHeight,...
            subTitle,'horizontal','center');
        set(subH,'fontsize',subS);
    end
    
    %Create Title
    if useTitle==1 && useSubTitle==1
        titH=text(0.485 +0.00*axesWidth,1+0.18/axesHeight,...
            plotTitle,'horizontal','center');
        set(titH,'fontsize',titS);
    elseif useTitle==1 && useSubTitle==0
        titH=text(0.49 +0.00*axesWidth,1+0.1/axesHeight,...
            plotTitle,'horizontal','center');
        set(titH,'fontsize',titS);
    end
    
    %Legend Parameters
    set(legH,'interpreter','latex','location',legLocation,...
        'fontsize',legS);
    
    %Shrink Legend Size
    legendshrink(0.3);
    
    %Delete Legend
    if delLegend==1;
        delete(legH);
    end
    
    %Special Adjustments

    if (yAdjustment>1 || yAdjustment<1) && ~isempty(yA)
        text(-0.08,1+0.1/axesHeight,[' $\times\;$  ',yA],...
            'fontsize',tickS,'horizontal','center');
    end
    
    %Save File (Tries 10 Times in Case of Error)
    for printAttempt = 1:10
        try
            print(figH,'-depsc2','-noui','-painters',printName);
            break;
        catch
            if printAttempt<10
                warning(['MMM_PlotOutput: File saving failed on attempt number ',...
                    num2str(printAttempt),'.',char(10),'     Trying again ...']);
            end
        end
    end
    
    %Fix Lines of style '-.'
   fixPSlinestyle(printName);
    
    %Open File
   winopen(printName);

    %Close Figure
   close(gcf);
    
end 

%Clear Used Variables
clear MAXX MAXY MINX MINY ans axesHeight axesWidth bs c delLegend dotSize extraVar figH fileName
clear filePath fileType hx hy i j lC lT lW labS labelFontSize labelX labelX1 labelX2 labelY
clear labelY1 labelY2 leg legH legLocation legS legS2 legT lineColor mS maxR maxX maxY minR minX
clear minY moveY moveY_Default plotAxis plotRes plotTitle pos1 pos2 printAttempt printName r stS
clear subH subS subTitle tempLabel tempPlot textPosX textPosY tickFontSize tickS titH titS uS
clear useSubTitle useTitle vN varFontSize varNumber varS varX varY xAdjustment xH xP xTemp yA
clear xTickMarks xTickTab xprec xt yAdjustment yH yP yTemp yTickMarks yprec yt noMax plotError
clear chH plotMode q var yN varShift legBoxOff swapChildren qq
