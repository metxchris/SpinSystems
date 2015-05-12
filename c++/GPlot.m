

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
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255]  ...
    }; 

%     [~,~]=dos('taskkill /f /im "i_view32.exe"');

bs      = 9;            %Base Font-Size
titS    = bs + 2;       %Title Size
subS    = bs ;     %Subtitle Size
legS    = bs + 1.5;     %Legend Size
tickS   = bs + 1;       %Tick Label Size
labS    = bs +2;        %Axis Label Size
uS      = bs;           %Units Size


axesWidth  = 2.8;   %Width of Axes
axesHeight = 1.9;   %Height of Axes
    
useTitle    = 1;    %Use Axes Title
useSubTitle = 1;    %Use Axes Subtitle
plotMode =1;

for varNumber = 10001
 
    % Default Arguments
    plotTitle='';subTitle='';
    plotRes=1;yA='';minR=0;maxR=1;
    xAdjustment=1;yAdjustment=1;moveY_Default=12;moveY=moveY_Default;
    legLocation = 'best';clear varY leg;extraVar = 0;
    xTickMarks=[];yTickMarks=[];MAXY=[];MINY=[];MAXX=[];MINX=[];
    delLegend=0;noMax=0;plotAxis=[];plotError=0;q=0;legBoxOff=1;
    yprec='%1.1f';xprec='%1.1f';swapChildren=0;minorTicks=0;
    
    switch varNumber
              case {1001,1002,1003,1004,1005,1006,1007,1008,1009,1010} % q = bin8 (7)
          var=test;
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
                    %                     axesWidth=axesWidth*1.5;axesHeight=axesHeight*1.5;
                    plotTitle = '\bf Site Occupancy';
                    %                         subTitle = '$D_8^*$ Model, $32^2$ grid, $10^6$ sweeps, Bins $1,2,5,8$';
%                     subTitle = '$D_8^*$ Model, $32^2$ grid, $10^6$ sweeps, Bins $3,4,6,7$';
% subTitle = '$(Z_2\!\times\! Z_2\!\times\! Z_2)^{*}_{124}$ Model, $32^2$ grid, $10^4$ sweeps, Bin $1$';
%  subTitle = '$(Z_2\!\times\! Z_2)^{*}_{11}$ Model, $32^2$ grid, $10^4$ sweeps, Bin $1$';
% subTitle = '$Z_8^{*}$ Model, $32^2$ grid, $10^4$ sweeps, Bin $1$';
subTitle = '$Q_8$ Model, $32^2$ grid, $10^4$ sweeps, Bin $1$';
                    fileName = '2d test bins';labelY1 = 'Site Occupancy';
                    MINY=0;MAXY=1;
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
%                     varX{vN}=var(:,1);varY{vN}=var(:,12);
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
%                     varX{vN}=var(:,1);varY{vN}=var(:,13);
                        varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                        lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                        vN=3;leg{vN}='$bin \;3$';
%                         varX{vN}=var(:,1);varY{vN}=var(:,14);
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                        lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                        vN=4;leg{vN}='$bin \;4$';
%                         varX{vN}=var(:,1);varY{vN}=var(:,15);
                        varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                        lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=5;leg{vN}='$bin \;5$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                        lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                        vN=6;leg{vN}='$bin \;6$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                        lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                        vN=7;leg{vN}='$bin \;7$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                        lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                        vN=8;leg{vN}='$bin \;8$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                        lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end  
                   case {1011,1012,1013,1014,1015,1016,1017,1018,1019} % C8_0vsZ8_0
            var=H3_4Corr1;
            labelX1 = '$x$ '; labelX2 = '$(T = T_c)$'; labelY2 = '';
            subTitle = '$H_3(Z_4)$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=1:numel(Y2);leg{vN}='$g(x)=g(\sigma_0,\sigma_x)$';
            lT{vN}='o';lW{vN}=2.2;mS{vN}=3;lC{vN}=[.2 .2 .2];
           
%             MINX=0.20;
            varShift = 1010;
            switch varNumber
                case 1+varShift
                    fileName = '2d test2, M';
                    plotTitle = '\bf Power Law Decay';
                    labelY1 = '$g(x)$ ';moveY=20;
                    xprec='%1.0f';yprec='%1.2f';
                    yN=2;varY{vN}=Y2;
                                MAXY=0.24;MINY=0;MAXX=40;MINX=0;
                    vN=2;var=C8_0;varX{vN}=X1;varY{vN}=Y1;
                    leg{vN}='$f(x)=ax^b$';lT{vN}='-.';lW{vN}=1.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 2+varShift
                    fileName = '2d test2, E';
                    plotTitle = '\bf Exponential Decay';
                    labelY1 = '$g(x)$ ';moveY=20;
                    xprec='%1.0f';yprec='%1.2f';
                    yN=4;varY{vN}=YY2;
                                MAXY=0.24;MINY=0;MAXX=40;MINX=0;
                    vN=2;var=C8_0;varX{vN}=XX1;varY{vN}=YY1;
                    leg{vN}='$f(x)=a\exp\,(bx)$';lT{vN}='-.';lW{vN}=1.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 3+varShift
                    fileName = '2d test2, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
%                     vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 4+varShift
                    fileName = '2d test2, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
%                     
%                     vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 5+varShift
                    fileName = '2d test2, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
%                     vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 6+varShift
                    fileName = '2d test2, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
%                     vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 7+varShift
%                     MINX=-1.25;
                    fileName = '2d test2, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
%                     vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 8+varShift
%                     MINX=-1.25;
                    fileName = '2d test2, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
%                     vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 9+varShift
%                    MINX=-1.25;
                    fileName = '2d test2, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
%                     vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
%                     leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
            end
        
        case {1,2,3,4,5,6,7,8,9} %2d,1d models
            
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$32^2$ grid, $2\cdot10^7$ sweeps';
            switch varNumber
                case 1
                    fileName = '2d H12, M_a';delLegend=0;
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';MINY=0;MINX=0.2;MAXX=1;
                    yN=2;
                    
                    if (plotMode ==1)
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=var(:,1); varY{vN}=var(:,yN);
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        MINX=0.6;fileName = '2d H12, M_b';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=var(:,1);varY{vN}=var(:,yN);%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=var(:,1);varY{vN}=var(:,yN); %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
                    
                case 2
                    fileName = '2d H12, E_a';delLegend=0;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=16;
                    xprec='%1.1f';yprec='%1.1f';MINX=1.5;MINY=0;
                    yN=4;
                    
                    if (plotMode ==1)
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=var(:,1); varY{vN}=var(:,yN)+4;
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=var(:,1);varY{vN}=var(:,yN)+8;
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        MINX=0.6;fileName = '2d H12, E_b';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4; %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
                    
                case 3
                    fileName = '2d H12, X_a';delLegend=0;
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';MINX=1.5;MINY=0;
                    yN=10;
                    
                    if (plotMode ==1)
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=var(:,1); varY{vN}=var(:,yN);
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        MINX=0.6;fileName = '2d H12, X_b';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=var(:,1);varY{vN}=var(:,yN);%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=var(:,1);varY{vN}=var(:,yN); %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
                    
                case 4
                    fileName = '2d H12, C_a';delLegend=0;
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont N}$ ';
                    xprec='%1.1f';yprec='%1.0f';MINX=0.2;MAXX=1;MINY=0;
                    yN=11;
                    
                    if (plotMode ==1)
                        vN=1;leg{vN}='$H_3\,(Z/3)$';
                        var=H3_3;varX{vN}=var(:,1); varY{vN}=var(:,yN);
                        lT{vN}='-';lW{vN}=1.5;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_3\,(Z/4)$';
                        var=H3_4;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                        lT{vN}='-';lW{vN}=1.5;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        MINX=0.6;fileName = '2d H12, C_b';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=var(:,1);varY{vN}=var(:,yN);%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=var(:,1);varY{vN}=var(:,yN); %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
                    
                case 5
                    fileName = '2d H12, X_a_ln';delLegend=0;
                    labelX1 = '$\log T$ ';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log\chi_{_M}$ '; moveY=12;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    
                    if (plotMode ==1)
                        MINX=0;
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        fileName = '2d H12, X_b_ln';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN))); %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
                case 6
                    fileName = '2d H12, C_a_ln';delLegend=0;
                    labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    
                    if (plotMode ==1)
                        MINX=0;
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    elseif (plotMode ==2)
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_2^*$ vs. $C_4$';
                        fileName = '2d H12, C_b_ln';
                        vN=1;leg{vN}='$H_2^*$';
                        var=H2n;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));%2*varX
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN+2};
                        vN=2;leg{vN}='$C_4$';
                        var=C4;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN))); %2*varX
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN+2};
                    end
            
            end
            
        case {21,22,23,24,25,26,27,28,29,30} % H3_0
            var=H3_3;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3(Z_3)$, $32^2$ grid, $10^7$ sweeps';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=1;mS{vN}=3.0;lC{vN}=lineColor{2};
%             MINX=0.20;
            switch varNumber
                case 21
                    fileName = '2d H3_3, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';MINY=0;
                    yN=2;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN);
                case 22
                    fileName = '2d H3_3, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';MINY=0;
                    yN=4;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN)+4;
                case 23
                    fileName = '2d H3_3, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;MINY=0;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN);
                case 24
                    fileName = '2d H3_3, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';MAXX=1;MINY=0;
                    yN=11;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                                                            vN=2;varX{vN}=var(:,1);varY{vN}=var(:,yN);swapChildren=1;
                    leg{vN}='$C_8^*$';lT{vN}='-';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2}/3;
                case 25
                    fileName = '2d H3_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 26
                    fileName = '2d H3_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 27
                    MINX=-1.25;
                    fileName = '2d H3_0, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 28
                    MINX=-1.25;
                    fileName = '2d H3_0, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 29
                   MINX=-1.25;
                    fileName = '2d H3_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 30
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
%                     vN=5;leg{vN}='$bin \;5$';
%                     varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
%                     lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
%                     vN=6;leg{vN}='$bin \;6$';
%                     varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
%                     lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
%                     vN=7;leg{vN}='$bin \;7$';
%                     varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
%                     lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
%                     vN=8;leg{vN}='$bin \;8$';
%                     varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
%                     lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end  

        case {31,32,33,34,35,36,37,38,39,40} % H3_1
            var=H3_4;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3(Z_4)$, $32^2$ grid, $10^7$ sweeps';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=1.0;mS{vN}=3.0;lC{vN}=lineColor{3};
%             MINX=0.20;
            switch varNumber
                case 31
                    fileName = '2d H3_4, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN);
                case 32
                    fileName = '2d H3_4, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN)+4;
                case 33
                    fileName = '2d H3_4, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN);
                case 34
                    fileName = '2d H3_4, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{6}{6}\selectfont N}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                                        vN=2;varX{vN}=var(:,1);varY{vN}=var(:,yN);swapChildren=1;
                    leg{vN}='$C_8^*$';lT{vN}='-';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{3}/3;
                case 35
                    fileName = '2d H3_1, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 36
                    fileName = '2d H3_1, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 37
                    MINX=-1.25;
                    fileName = '2d H3_1, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 38
                    MINX=-1.25;
                    fileName = '2d H3_1, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 39
                   MINX=-1.25;
                    fileName = '2d H3_1, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 40
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_1 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $2$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end  

         case {41,42,43,44,45,46,47,48,49,50} % H3_2
            var=C8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3(Z_2)$, $32^2$ grid, $10^7$ sweeps';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.8;mS{vN}=3;lC{vN}=lineColor{1};
%             MINX=0.20;
            switch varNumber
                case 41
                    fileName = '2d H3_2, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;MINX=0.24;MAXX=1.4;MINY=0;
                    varY{vN}=var(:,yN);
                case 42
                    fileName = '2d H3_2, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;MINX=0.24;MAXX=1.4;MINY=0;
                    varY{vN}=var(:,yN)+4;
                case 43
                    fileName = '2d H3_2, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;MINX=0.24;MAXX=1.4;MINY=0;
                    varY{vN}=var(:,yN);
                case 44
                    fileName = '2d H3_2, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont N}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;MINX=0.24;MAXX=1.4;MINY=0;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 45
                    fileName = '2d H3_2, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 46
                    fileName = '2d H3_2, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 47
                    MINX=-1.25;
                    fileName = '2d H3_2, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 48
                    MINX=-1.25;
                    fileName = '2d H3_2, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 49
                   MINX=-1.25;
                    fileName = '2d H3_2, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 50
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_2 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $3$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                case {51,52,53,54,55,56,57,58,59,60} %0 vs 2 % H3_0 vs H3_2
            var=H3_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin 1 vs. bin 3';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$bin \;1$';
            lT{vN}='o';lW{vN}=.4;mS{vN}=2;lC{vN}=lineColor{1};
            swapChildren=1;
%             MINX=0.20;
            switch varNumber
                case 51
                    fileName = '2d H3_02, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 52
                    fileName = '2d H3_02, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 53
                    fileName = '2d H3_02, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 54
                    fileName = '2d H3_02, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 55
                    fileName = '2d H3_02, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 56
                    fileName = '2d H3_02, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 57
                    MINX=-1.25;
                    fileName = '2d H3_02, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_2;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$bin \;3$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 58
                    MINX=-1.25;
                    fileName = '2d H3_02, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_2;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$bin \;3\qquad\qquad\qquad\qquad$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 59
                   MINX=-1.25;
                    fileName = '2d H3_02, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_2;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$bin \;3\qquad\qquad\qquad\qquad$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 60
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_02 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $3$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                case {61,62,63,64,65,66,67,68,69,70} % H3_7
            var=H3_7;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $8$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=lineColor{9};
%             MINX=0.20;
            varShift = 60;
            switch varNumber
                case 1+varShift;
                    fileName = '2d H3_7, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d H3_7, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d H3_7, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d H3_7, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d H3_7, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d H3_7, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;
                    fileName = '2d H3_7, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 8+varShift;
                    MINX=-1.25;
                    fileName = '2d H3_7, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d H3_7, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_7 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $8$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
     case {71,72,73,74,75,76,77,78,79} % q = 2
          var=test22;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$32^2$ grid, $10^6$ sweeps, $H_5^*$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{5};
            switch varNumber
                case 71
                    fileName = '2d test, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                    
                case 72
                    fileName = '2d test, E_a';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 73
                    fileName = '2d test, X_a';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);

                case 74
                    fileName = '2d test, C_a';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 75
                    fileName = '2d test, X_b_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 76
                    fileName = '2d test, C_b_ln';legLocation='southeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 77
                    fileName = '2d test, M4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '($V_m)^4$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 78
                    fileName = '2d test, E4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$(V_E)^4$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 79
                        plotTitle = '\bf Site Occupancy in $H_3$';                    
                    fileName = '2d test bins';labelY1 = 'Site Occupancy';
                        subTitle = '$32^2$ grid, $10^6$ sweeps, $H_3^*$ normalized';
                        
                        delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                       legLocation='northeast';labelX1 = '$\log T$ ';
                        vN=1;leg{vN}='$$bin \;1$$';
                        varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                        lT{vN}='-';lW{vN}=1.5;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$bin \;2$';
                        varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                        lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=3;leg{vN}='$bin \;3$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                        lT{vN}='--';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=4;leg{vN}='$bin \;4$';
                        varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                        lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=5;leg{vN}='$bin \;5$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                        lT{vN}='-.';lW{vN}=1;mS{vN}=1;lC{vN}=lineColor{vN};
                                                vN=6;leg{vN}='$bin \;6$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                        lT{vN}='--';lW{vN}=1.5;mS{vN}=1;lC{vN}=lineColor{vN};
                                                vN=7;leg{vN}='$bin \;7$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                        lT{vN}='-';lW{vN}=1;mS{vN}=1;lC{vN}=lineColor{8};
                                                vN=8;leg{vN}='$bin \;8$';
                        varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                        lT{vN}='-.';lW{vN}=1.5;mS{vN}=1;lC{vN}=lineColor{7};
            end  
            case {81,82,83,84,85} % q = 2
            var=heis02h;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$\mathbf{Z}_2$, $50^2$ grid, $10^6$ sweeps, $d = $ Heisenberg';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            
            switch varNumber
                case 81
                    fileName = '2d Heis, M02h';
                    plotTitle = '\bf Clock Model, Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 82
                    fileName = '2d Heis, E02h';yprec='%1.1f';
                    plotTitle = '\bf Clock Model, Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=24;
                    varY{vN}=var(:,4);
                case 83
                    fileName = '2d Heis, X02h';delLegend=0;
                    plotTitle = '\bf Clock Model, Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,6);yprec='%1.0f';MINY=0;MAXY=305;
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,2))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/5;
                case 84
                    fileName = '2d Heis, C02h';delLegend=0;
                    plotTitle = '\bf Clock Model, Specific Heat';
                    labelY1 = '$c$ ';MINY=0;MAXY=4.37;
                    varX{vN}=var(1:end,1);varY{vN}=var(1:end,7);yprec='%1.1f';MINY=0;
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.5;mS{vN}=3;lC{vN}=lC{1}/5;
                case 85
                    fileName = '2d Heis, V02h';delLegend=0;
                    plotTitle = '\bf Clock Model, Energy Variance';
                    labelY1 = '$\left<(\Delta H)^2\right>$ ';MINY=0;MAXY=3.1;
                    varX{vN}=var(1:end,1);varY{vN}=var(1:end,7).*(var(1:end,1).^2);yprec='%1.1f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1))).*((var(1:end-1,1)+diff(var(:,1))./2).^2);
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.5;mS{vN}=3;lC{vN}=lC{1}/5;
            end  
        case {91,92,93,94,95,96,97,98,99,100} % C8_0
            var=C8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$\mathcal{C}_{L8}^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=1-lineColor{5};MINX=0.20;
             varShift = 90;
            switch varNumber
                case 1+varShift;
                    fileName = '2d CL8_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d CL8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d CL8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d CL8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d CL8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d CL8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;
                    fileName = '2d CL8_0, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;
                    fileName = '2d CL8_0, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d CL8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d CL8_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$\mathcal{C}_{L8}^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
        case {101,102,103,104,105,106,107,108,109,110} % Clock8
            var=Clock8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$\mathcal{C}_{L 8}$, $32^2$ grid, $10^6$ sweeps';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=(1-lineColor{5})/2;MINX=0.20;
             varShift = 100;
            switch varNumber
                case 1+varShift;
                    fileName = '2d Clock8, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d Clock8, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Clock8, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d Clock8, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Clock8, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Clock8, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;
                    fileName = '2d Clock8, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.1f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));yprec='%1.0f';
                case 8+varShift;
                    MINX=-1.25;
                    fileName = '2d Clock8, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d Clock8, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Clock8 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$\mathcal{C}_{L8}$, $32^2$ grid, $10^6$ sweeps';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                        case {111,112,113,114,115,116,117,118,119,120} % Z8_0
              var=Z8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Z_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=lineColor{1}/1.5;MINX=0.20;
             varShift = 110;
            switch varNumber
                case 1+varShift;
                    fileName = '2d Z8_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d Z8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Z8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d Z8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Z8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Z8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.8;
                    fileName = '2d Z8_0, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;moveY=24;
                    fileName = '2d Z8_0, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d Z8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Z8_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$Z_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                    case {121,122,123,124,125,126,127,128,129} % C8_0vsZ8_0
            var=Z8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Z_8^*\;$ vs. $C_8^*$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$Z_8^*$';
            lT{vN}='o';lW{vN}=.4;mS{vN}=2;lC{vN}=lineColor{1}/1.5;
            swapChildren=1;
            MINX=0.20;
            varShift = 120;
            switch varNumber
                case 1+varShift
                    fileName = '2d Z8_0vC8_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 2+varShift
                    fileName = '2d Z8_0vC8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 3+varShift
                    fileName = '2d Z8_0vC8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 4+varShift
                    fileName = '2d Z8_0vC8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 5+varShift
                    fileName = '2d Z8_0vC8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 6+varShift
                    fileName = '2d Z8_0vC8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 7+varShift
                    MINX=-1.25;
                    fileName = '2d Z8_0vC8_0, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 8+varShift
                    MINX=-1.25;
                    fileName = '2d Z8_0vC8_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
                case 9+varShift
                   MINX=-1.25;
                    fileName = '2d Z8_0vC8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=1-lineColor{5};
            end
                            case {131,132,133,134,135,136,137,138,139} % Z8_0vZ4xZ2_0
            var=Z8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Z_8^*\;$ vs. $Z_4 \times Z_2$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$Z_8^*$';
            lT{vN}='o';lW{vN}=.4;mS{vN}=2;lC{vN}=lineColor{1}/1.5;
            swapChildren=1;
            MINX=0.20;
            varShift = 130;
            switch varNumber
                case 1+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 2+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 3+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 4+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 5+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 6+varShift
                    fileName = '2d Z8_0vZ4xZ2_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 7+varShift
                    MINX=-1.25;MINY=-4.9;
                    fileName = '2d Z8_0vZ4xZ2_0, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 8+varShift
                    MINX=-1.25;
                    fileName = '2d Z8_0vZ4xZ2_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
                case 9+varShift
                   MINX=-1.25;
                    fileName = '2d Z8_0vZ4xZ2_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Z4xZ2_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Z_4 \times Z_2$';lT{vN}='x';lW{vN}=.6;mS{vN}=4;lC{vN}=lineColor{5};
            end    
                                case {141,142,143,144,145,146,147,148,149} % H3_0vsZ8_0
            var=H3_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$H_3^*\;$ vs. $C_8^*$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$H_3^*$';
            lT{vN}='o';lW{vN}=.4;mS{vN}=2;lC{vN}=lineColor{1};
            swapChildren=1;
            MINX=0.20;
            varShift = 140;
            switch varNumber
                case 1+varShift
                    fileName = '2d H3_0vC8_0 , M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 2+varShift
                    fileName = '2d H3_0vC8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 3+varShift
                    fileName = '2d H3_0vC8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 4+varShift
                    fileName = '2d H3_0vC8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 5+varShift
                    fileName = '2d H3_0vC8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 6+varShift
                    fileName = '2d H3_0vC8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=C8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 7+varShift
                    MINX=-1.25;
                    fileName = '2d H3_0vC8_0, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 8+varShift
                    MINX=-1.25;
                    fileName = '2d H3_0vC8_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
                case 9+varShift
                   MINX=-1.25;
                    fileName = '2d H3_0vC8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.1f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=C8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$C_8^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{2};
            end
        case {201,202,203,204,205,206,207,208,209,210} % D8_0
              var=D8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$D_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.6;mS{vN}=3;lC{vN}=lineColor{1};MINX=0.20;
             varShift = 200;
            switch varNumber
                case 1+varShift;
                    fileName = '2d D8_0, M';MAXX=2;
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d D8_0, E';MAXX=2;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d D8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';MAXX=2;
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d D8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';MAXX=2;
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d D8_0, M4';MAXX=2;
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d D8_0, E4';MAXX=2;
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.8;
                    fileName = '2d D8_0, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;
                    fileName = '2d D8_0, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; yN=11;yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d D8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d D8_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$D_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1,2,5,8$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                        case {211,212,213,214,215,216,217,218,219,220} % D8_2
              var=D8_2;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$D_8^*$, $32^2$ grid, $10^6$ sweeps, bin $3$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=lineColor{2};MINX=0.20;
             varShift = 210;
            switch varNumber
                case 1+varShift;
                    fileName = '2d D8_2, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d D8_2, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d D8_2, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    fileName = '2d D8_2, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d D8_2, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d D8_2, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.8;
                    fileName = '2d D8_2, X_ln';legLocation='northeast';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;
                    fileName = '2d D8_2, C_ln';legLocation='southeast';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat';yN=11;yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;
                    fileName = '2d D8_2, M_ln';
                    plotTitle = '\bf Mean Magnetization';legLocation='southeast';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d D8_2 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$D_8^*$, $32^2$ grid, $10^6$ sweeps, bin $3,4,6,7$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end
                             case {291,292,293,294,295,296,297,298,299,300} % Q8
              var=Q8;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Q_8^*$, $32^2$ grid, $10^6$ sweeps';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=lineColor{3};MINX=0.20;
             varShift = 290;
            switch varNumber
                case 1+varShift;
                    fileName = '2d Q8, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d Q8, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Q8, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    %legLocation='southeast';
                    fileName = '2d Q8, C';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Q8, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Q8, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=20;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.9;legLocation='northeast';
                    fileName = '2d Q8, X_ln';abelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;%legLocation='best';
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Q8 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$Q_8^*$, $32^2$ grid, $10^6$ sweeps, random bins';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='o';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='o';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='o';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{4};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='x';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='o';lW{vN}=1;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='o';lW{vN}=1;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='o';lW{vN}=1;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='o';lW{vN}=1;mS{vN}=1;lC{vN}=lineColor{9};
            end     
        case {301,302,303,304,305,306,307,308,309,310} % Q8_0
              var=Q8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Q_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.4;mS{vN}=3;lC{vN}=lineColor{2};%MINX=0.20;
             varShift = 300;
            switch varNumber
                case 1+varShift;
                    fileName = '2d Q8_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d Q8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Q8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    %legLocation='southeast';
                    fileName = '2d Q8_0, C';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Q8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Q8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.9;legLocation='northeast';
                    fileName = '2d Q8_0, X_ln';abelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=24;yN=11;yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;%legLocation='best';
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Q8_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$Q_8^*$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
        case {311,312,313,314,315,316,317,318,319,320} %0 vs 2 % D8_0 vs Q8_0
            var=D8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$D_8^*\;$ vs. $Q_8^*$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$D_8^*$';
            lT{vN}='o';lW{vN}=.6;mS{vN}=2;lC{vN}=lineColor{1};
            swapChildren=1;
            varShift = 310;
            MINX=0.20;
            switch varNumber
                case 1+varShift
                    fileName = '2d Q8_0vD8_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 2+varShift
                    fileName = '2d Q8_0vD8_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 3+varShift 
                    fileName = '2d Q8_0vD8_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 4+varShift
                    fileName = '2d Q8_0vD8_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 5+varShift
                    fileName = '2d Q8_0vD8_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 6+varShift
                    fileName = '2d Q8_0vD8_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=Q8_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 7+varShift
                    MINX=-1.25;MINY=-4.9;%legLocation='northeast';
                    fileName = '2d Q8_0vD8_0, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Q8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 8+varShift
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8_0vD8_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Q8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 9+varShift
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Q8_0vD8_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=Q8_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$Q_8^*$';lT{vN}='x';lW{vN}=.4;mS{vN}=4;lC{vN}=lineColor{vN};
                case 10+varShift
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_02 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $3$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end 
                   case {321,322,323,324,325,326,327,328,329,330} %0 vs 2 % D8_0 vs H3_0
            var=D8_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$D_8^*\;$ vs. $H_3^*$, $32^2$ grid, $10^6$ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='$D_8^*$';
            lT{vN}='o';lW{vN}=.6;mS{vN}=2;lC{vN}=lineColor{1};
            swapChildren=1;
            varShift = 320;
            MINX=0.20;
            switch varNumber
                case 1+varShift
                    fileName = '2d D8_0vH3_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;varY{vN}=var(:,yN);

                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 2+varShift
                    fileName = '2d D8_0vH3_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;varY{vN}=var(:,yN)+4;
                    
                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN)+4;
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 3+varShift 
                    fileName = '2d D8_0vH3_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 4+varShift
                    fileName = '2d D8_0vH3_0, C';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;varY{vN}=var(:,yN); %#ok<*SAGROW>
                    
                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 5+varShift
                    fileName = '2d D8_0vH3_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    yN=8;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 6+varShift
                    fileName = '2d D8_0vH3_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;
                    yprec='%1.2f';yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    yN=9;varY{vN}=var(:,yN);
                    
                    vN=2;var=H3_0;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 7+varShift
                    MINX=-1.25;MINY=-4.9;%legLocation='northeast';
                    fileName = '2d D8_0vH3_0, X_ln';labelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yprec='%1.0f';
                    yN=10;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 8+varShift
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d D8_0vH3_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; yprec='%1.0f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    yN=11;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 9+varShift
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d D8_0vH3_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    yN=2;varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                    
                    vN=2;var=H3_0;varX{vN}=log(abs(var(:,1)));varY{vN}=log(abs(var(:,yN)));
                    leg{vN}='$H_3^*$';lT{vN}='x';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{vN};
                case 10+varShift
                    MINX=-1.25;
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d H3_02 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$H_3$, $32^2$ grid, $10^6$ sweeps, bin $3$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    legLocation='best';labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end
                   case {401,402,403,404,405,406,407,408,409,410} % Q8_0
              var=Z4xZ2_0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Z_4\times Z_2$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.6;mS{vN}=3;lC{vN}=lineColor{5};MINX=0.20;
             varShift = 400;
            switch varNumber
                case 1+varShift;
                    fileName = '2d Z4xZ2_0, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;
                    varY{vN}=var(:,yN);
                case 2+varShift;
                    fileName = '2d Z4xZ2_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Z4xZ2_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    %legLocation='southeast';
                    fileName = '2d Z4xZ2_0, C';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Z4xZ2_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Z4xZ2_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.9;legLocation='northeast';
                    fileName = '2d Z4xZ2_0, X_ln';abelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Z4xZ2_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=20;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Z4xZ2_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;%legLocation='best';
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Z4xZ2_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$Z_4\times Z_2$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
            end
            
                       case {10001,10002,10003,10004,10005,10006,10007,10008,10009,10010} % Q8_0
              var=potts02;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$Z_4\times Z_2$, $32^2$ grid, $10^6$ sweeps, bin $1$';
            delLegend=1;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated';
            lT{vN}='o';lW{vN}=.6;mS{vN}=3;lC{vN}=lineColor{1};MINX=0.20;
             varShift = 10000;
            switch varNumber
                case 1+varShift;
                    fileName = 'Ising Compare, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2; varY{vN}=var(:,yN);
                                j=0;
J=2;
Tc = J/log(1+sqrt(2));
for (x=1:0.025:4)
    j=j+1;
   
M(j)=(1-(sinh(log(1+sqrt(2))*(Tc/(x))))^(-4))^(1/8);
end
 M(imag(M)>0)=0;
 
                   vN=2; varY{vN}=M';varX{vN}=varX{1};
                   lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};MINX=1;MAXX=4;yTickMarks=[0 0.2 0.4 0.6 0.8 1];yprec='%1.1f';
                case 2+varShift;
                    fileName = '2d Z4xZ2_0, E';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    varY{vN}=var(:,yN)+4;
                case 3+varShift;
                    fileName = '2d Z4xZ2_0, X';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';
                    yN=10;
                    varY{vN}=var(:,yN);
                case 4+varShift;
                    %legLocation='southeast';
                    fileName = '2d Z4xZ2_0, C';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont h}$ ';
                    xprec='%1.1f';yprec='%1.0f';
                    yN=11;
                    varY{vN}=var(:,yN); %#ok<*SAGROW>
                case 5+varShift;
                    fileName = '2d Z4xZ2_0, M4';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_m^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 6+varShift;
                    fileName = '2d Z4xZ2_0, E4';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
                case 7+varShift;
                    MINX=-1.25;MINY=-4.9;legLocation='northeast';
                    fileName = '2d Z4xZ2_0, X_ln';abelX1 = '$\log T$ '; 
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;yN=10;yprec='%1.0f';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 8+varShift;
                    MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Z4xZ2_0, C_ln';labelX1 = '$\log T$ ';
                    plotTitle = '\bf Specific Heat'; moveY=20;yN=11;yprec='%1.1f';
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont h}$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 9+varShift;
                   MINX=-1.25;%legLocation='southeast';
                    fileName = '2d Z4xZ2_0, M_ln';
                    plotTitle = '\bf Mean Magnetization';labelX1 = '$\log T$ ';
                    moveY=24;yN=2;yprec='%1.0f';
                    labelY1 = '$\log |\left<M\right>|$  ';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=log(abs(var(:,yN)));
                case 10+varShift;
                    MINX=-1.25;%legLocation='best';
                    plotTitle = '\bf Site Occupancy';
                    fileName = '2d Z4xZ2_0 bins';labelY1 = 'Site Occupancy';
                    subTitle = '$Z_4\times Z_2$, $32^2$ grid, $10^6$ sweeps, bin $1$';
                    
                    delLegend=0;xprec='%1.1f';yprec='%1.1f';moveY=12;
                    labelX1 = '$\log T$ ';
                    vN=1;leg{vN}='$$bin \;1$$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,12);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=2;leg{vN}='$bin \;2$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,13);
                    lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{3};
                    vN=3;leg{vN}='$bin \;3$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,14);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{2};
                    vN=4;leg{vN}='$bin \;4$';
                    varX{vN}=log(abs(var(:,1)));varY{vN}=var(:,15);
                    lT{vN}='--';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
                    vN=5;leg{vN}='$bin \;5$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,16);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=6;leg{vN}='$bin \;6$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,17);
                    lT{vN}='-';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{vN};
                    vN=7;leg{vN}='$bin \;7$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,18);
                    lT{vN}='--';lW{vN}=2;mS{vN}=1;lC{vN}=1-lineColor{4};
                    vN=8;leg{vN}='$bin \;8$';
                    varX{vN}=log(abs(var(:,1))); varY{vN}=var(:,19);
                    lT{vN}='-.';lW{vN}=2;mS{vN}=1;lC{vN}=lineColor{9};
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
    for j = 1:numel(varY)
            
    %Adjustable Plot Range
    varS = numel(varY{j});
    pos1 = max(round(minR*varS),1);
    pos2 = round(maxR*varS);
    
        varY{j} = varY{j}/yAdjustment;
        if ~plotError
        plot(varX{j},varY{j},lT{j},'linewidth',...
            lW{j},'markersize',mS{j},'color',lC{j});
        end
        
        if j == 1
            hold on;
          %  legT = leg{1};
            [minX,maxX,minY,maxY] = deal(NaN);
        elseif j == numel(varY)
          %  legT=[leg,',',leg{j}];
        else
          %  legT=[leg,leg{j}];
        end
       legT= leg;
        if ~noMax
            minX=min(minX,min(varX{j}(pos1:pos2)));
            maxX=max(maxX,max(varX{j}(pos1:pos2)));
            minY=min(minY,min(varY{j}(pos1:pos2)));
            maxY=max(maxY,max(varY{j}(pos1:pos2)));
        end
    end
    
    %Plot Standard Error
    if plotError
        boundedline(varX{1},DataM,DataS,'-','cmap',lC{1})
    end
    
    % Plot Tc based on q-value
    if q>0
        x = 1/(log(1+sqrt(q)));
        plot([x,x],[minY,maxY],'--','linewidth',.5,'color',lineColor{2});
    end
    if plotError
        boundedline(varX{1},DataM,DataS,'-','cmap',lC{1});
    end
    % End of Plotting
    hold off;
    
    % Create Legend
    legH = legend(legT);
    
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
        set(gca,'Children',[chH(end);chH(1:end-1)]);
    end
    
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
    set(xH, 'position', [xP(1), xP(2)-6])
    
    %Invisible Axes for Title Positioning
    axes('units','inches','position',...
        [0.75 0.75 axesWidth axesHeight],'visible','off');
    
    %Create Subtitle
    if useSubTitle==1
        subH = text(0.5 +0.00*axesWidth ,1+0.095/axesHeight,...
            subTitle,'horizontal','center');
        set(subH,'fontsize',subS);
    end
    
    %Create Title
    if useTitle==1 && useSubTitle==1
        titH=text(0.485 +0.00*axesWidth,1+0.24/axesHeight,...
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
    legendshrink(0.5);
    
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
clear chH plotMode q var yN varShift legBoxOff swapChildren
