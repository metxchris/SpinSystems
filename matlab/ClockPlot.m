

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
    [0.4 0.173 0.569],   [0.957 0.490 0.137], [251/255 184/255 39/255]  ...
    [0.3 0.3 0.3],       [0.7 0.7 0.7],  ...
    [0.0 0.253 0.563], [0.833 0.080 0.084], [0 0.449 0.182],          ...
    [0.3 0.073 0.469],   [0.857 0.390 0.037], [225/255 166/255 35/255]  ...
    }; 

%     [~,~]=dos('taskkill /f /im "i_view32.exe"');

bs      = 9;            %Base Font-Size
titS    = bs + 2;       %Title Size
subS    = bs ;     %Subtitle Size
legS    = bs + 0.5;     %Legend Size
tickS   = bs + 1;       %Tick Label Size
labS    = bs +2;        %Axis Label Size
uS      = bs;           %Units Size


axesWidth  = 2.8;   %Width of Axes
axesHeight = 1.9;   %Height of Axes
    
useTitle    = 1;    %Use Axes Title
useSubTitle = 1;    %Use Axes Subtitle


for varNumber =21:22
 
    % Default Arguments
    plotTitle='';subTitle='';
    plotRes=1;yA='';minR=0;maxR=1;
    xAdjustment=1;yAdjustment=1;moveY_Default=12;moveY=moveY_Default;
    legLocation = 'best';clear varY leg;extraVar = 0;
    xTickMarks=[];yTickMarks=[];MAXY=[];MINY=[];MAXX=[];MINX=[];
    delLegend=0;noMax=0;plotAxis=[];plotError=0;q=0;
    
    switch varNumber
        case {11,12,13,14,15,16,17,18,19} % q = 2
            var=clock4a;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$32^2$ grid, $10^6$ sweeps, $d = \cos^2(\theta_i - \theta_j)$';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='G1';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            
            switch varNumber
                case 11
                    fileName = '2d G12, M_a';delLegend=0;
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                    var=G2d001;
                    vN=2;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='x';lW{vN}=1;mS{vN}=5;lC{vN}=lineColor{2};
                    varY{vN}=var(:,2);MINY=0;
                    var=heis002;
                    vN=3;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='h';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{3};
                    varY{vN}=var(:,2);
                    var=G4d001;
                    vN=4;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G4';lT{vN}='*';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{4};
                    varY{vN}=var(:,2);
                case 12
                    fileName = '2d G12, E_a';delLegend=0;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,4);
                    var=G2d001;
                    vN=2;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='x';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    varY{vN}=.5*var(:,4)-2;
                    var=heis002;
                    vN=3;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='h';lW{vN}=.5;mS{vN}=3;lC{vN}=lineColor{3};
                    varY{vN}=var(:,4);
                                        var=G4d001;
                    vN=4;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G4';lT{vN}='*';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{4};
                    varY{vN}=var(:,4);
                case 13
                    fileName = '2d G12, X_a';delLegend=0;
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,10);
                    var=G2d001;
                    vN=2;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='x';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    varY{vN}=var(:,10);
                    var=heis002;
                    vN=3;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='h';lW{vN}=.5;mS{vN}=3;lC{vN}=lineColor{3};
                    varY{vN}=var(:,10);
                                                            var=G4d001;
                    vN=4;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G4';lT{vN}='*';lW{vN}=.5;mS{vN}=4;lC{vN}=lineColor{4};
                    varY{vN}=var(:,10);
                                    case 14
                    fileName = '2d G12, C_a';delLegend=0;
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,11);lT{vN}='o';
                    var=G2d001;
                    vN=2;varX{vN}=var(:,1)/4;xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    varY{vN}=var(:,11);
                    var=heis002;
                    vN=3;varX{vN}=var(:,1)/2;xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='O';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{3};
                    varY{vN}=var(:,11);
                                                                                var=G4d001;
                    vN=4;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G4';lT{vN}='O';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{4};
                    varY{vN}=var(:,11);MAXY=4;
                                                        case 16
                    fileName = '2d G12, M4_a';delLegend=0;
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,8);
                    var=G2d001;q=2;
                    vN=2;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    varY{vN}=var(:,8);
                    var=heis002;
                    vN=3;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{3};
                    varY{vN}=var(:,8);
                                                        case 17
                    fileName = '2d G12, E5_a';delLegend=0;
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,9);
                    var=G2d001;q=2;
                    vN=2;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G2';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
                    varY{vN}=var(:,9);
                    var=heis002;
                    vN=3;varX{vN}=var(:,1);xprec='%1.1f';yprec='%1.1f';
                    leg{vN}='G3';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{3};
                    varY{vN}=var(:,9);
            end
        
        case {21,22,23,24,25,26,27,28,29} % q = 2
            var=clock4a;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=4$, $32^2$ grid, $10^6$ sweeps, $d = \cos^2(\theta_i-\theta_j)$';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            MINX=0.6;
            
            switch varNumber
                case 21
                    fileName = '2d clock, M_4a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 22
                    fileName = '2d clock, E_4a';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    varY{vN}=var(:,4);
                case 23
                    fileName = '2d clock, X_4a';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                case 24
                    fileName = '2d clock, C_4a';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont H}$ ';
                    varY{vN}=var(:,11);yprec='%1.1f';
                case 25
                    fileName = '2d clock, V_4a';
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$\left<(\Delta H)^2\right>$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.1f';
                case 26
                    fileName = '2d clock, M4_4a';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_M^{(4)}$ ';moveY=30;
                    varY{vN}=var(:,8);yprec='%1.2f';
                case 27
                    fileName = '2d clock, E4_4a';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=12;MINY=0;
                    varY{vN}=var(:,9);yprec='%1.1f';yAdjustment=10^(-4);yA='$10^{-4}$';
            end
        case {221,222,223,224,225,226,227,228,229} % q = 2
            var=clock4a;q=0;
            labelX1 = '$\log T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=4$, $32^2$ grid, $10^6$ sweeps, $d = \cos^2(\theta_i-\theta_j)$';
            vN=1;varX{vN}=log(abs(var(:,1)));delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{2};
            switch varNumber
                case 221
                    fileName = '2d clock, X_4a_ln';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log\chi_{_M}$ '; moveY=12;
                    varY{vN}=log(abs(var(:,10)));yprec='%1.0f';
                case 222
                    fileName = '2d clock, C_4a_ln';legLocation='southeast';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varY{vN}=log(abs(var(:,11)));yprec='%1.1f';

            end

      case {31,32,33,34,35,36,37} % q = 2
            var=G2d001;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=8$, $32^2$ grid, $10^6$ sweeps, $d = $ Heisenberg';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            
            switch varNumber
                case 31
                    fileName = '2d G2, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 32
                    fileName = '2d G2, E_a';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    varY{vN}=var(:,4);
                case 33
                    fileName = '2d G2, X_a';delLegend=0;%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,2))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 34
                    fileName = '2d G2, C_a';delLegend=0;%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont H}$ ';
                    varY{vN}=var(:,11);yprec='%1.1f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 35
                    fileName = '2d G2, V_a';delLegend=0;
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$\left<(\Delta H)^2\right>$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.1f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1))).*((var(1:end-1,1)+diff(var(:,1))./2).^2);
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 36
                    fileName = '2d G2, M4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_M^{(4)}$ ';moveY=30;
                    varY{vN}=var(:,8);yprec='%1.2f';
                case 37
                    fileName = '2d G2, E4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=12;MINY=0;
                    varY{vN}=var(:,9);yprec='%1.1f';yAdjustment=10^(-4);yA='$10^{-4}$';
            end
        case {131,132,133,134,135,136,137} % q = 2
            var=G2d001;q=0;
            labelX1 = '$\log T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=8$, $32^2$ grid, $10^6$ sweeps, $d = $ Heisenberg';
            vN=1;varX{vN}=log(abs(var(:,1)));delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{1};
            switch varNumber
                case 131
                    fileName = '2d G2, M_a_ln';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$\log|\left<M\right>|$ ';labelX1 = '$\log T$ ';
                    varY{vN}=log(abs(var(:,2)));moveY=20;
                case 132
                    fileName = '2d Heis, E_b_ln';yprec='%1.2f';
                    plotTitle = '\bf Mean Energy';labelX1 = '$\log T$ ';
                    labelY1 = '$\log\left<H\right>$ ';moveY=20;
                    varY{vN}=log(abs(var(:,4)));
                case 133
                    fileName = '2d Heis, X_b_ln';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;
                    varY{vN}=log(abs(var(:,10)));yprec='%1.0f';
                case 134
                    fileName = '2d Heis, C_b_ln';legLocation='southeast';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varY{vN}=log(abs(var(:,11)));yprec='%1.1f'; 
            end
     case {41,42,43,44,45,46,47} % q = 2
            var=heis003;q=8;
            labelX1 = '$T$ ';  labelX2 = '$(T_c = 1.490)$';   labelY2 = '';
            subTitle = '$q = 8$, $32^2$ grid, $10^6$ sweeps, $d = \delta_{ij}$';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{3};
            
              switch varNumber
                case 41
                    fileName = '2d Heis, M_c';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 42
                    fileName = '2d Heis, E_c';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=24;
                    varY{vN}=var(:,4);
                case 43
                    fileName = '2d Heis, X_c';delLegend=0;%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,2))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 44
                    fileName = '2d Heis, C_c';delLegend=0;%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$c_N$ ';
                    varY{vN}=var(:,11);yprec='%1.0f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 45
                    fileName = '2d Heis, V_c';delLegend=0;
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$\left<(\Delta H)^2\right>$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.0f';moveY=20;
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1))).*((var(1:end-1,1)+diff(var(:,1))./2).^2);
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 46
                    fileName = '2d Heis, M4_c';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_M^{(4)}$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.1f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 47
                    fileName = '2d Heis, E4_c';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                   labelY1 = '$Q_E^{(4)}$ ';moveY=12;MINY=0;yAdjustment=10^(-2);yA='$10^{-\;2}$';
                    varY{vN}=var(:,9);yprec='%1.1f';
              end
                    case {141,142,143,144,145,146,147} % q = 2
            var=heis003;q=0;
            labelX1 = '$\log T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=8$, $32^2$ grid, $10^6$ sweeps, $d = \delta_{ij}$';
            vN=1;varX{vN}=log(abs(var(:,1)));delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{3};
            switch varNumber
                case 141
                    fileName = '2d Heis, M_c_ln';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$\log|\left<M\right>|$ ';labelX1 = '$\log T$ ';
                    varY{vN}=log(abs(var(:,2)));moveY=20;
                case 142
                    fileName = '2d Heis, E_c_ln';yprec='%1.2f';
                    plotTitle = '\bf Mean Energy';labelX1 = '$\log T$ ';
                    labelY1 = '$\log\left<H\right>$ ';moveY=20;
                    varY{vN}=log(abs(var(:,4)));
                case 143
                    fileName = '2d Heis, X_c_ln';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;
                    varY{vN}=log(abs(var(:,10)));yprec='%1.0f';
                case 144
                    fileName = '2d Heis, C_c_ln';legLocation='southeast';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varY{vN}=log(abs(var(:,11)));yprec='%1.1f'; 
            end
    case {51,52,53,54,55,56,57,58} % q = 2
            var=G4d001;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=16$, $32^2$ grid, $10^6$ sweeps, $d = $4d Heisenberg';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{4};
            
            switch varNumber
                case 51
                    fileName = '2d G4, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 52
                    fileName = '2d G4, E_a';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    varY{vN}=var(:,4);
                case 53
                    fileName = '2d G4, X_a';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                case 54
                    fileName = '2d G4, C_a';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont H}$ ';
                    varY{vN}=var(:,11);yprec='%1.1f';
                case 55
                    fileName = '2d G4, V_a';
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$(\Delta H)^2$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.1f';
                case 56
                    fileName = '2d G4, M4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_M^{(4)}$ ';moveY=30;
                    varY{vN}=var(:,8);yprec='%1.2f';
                case 57
                    fileName = '2d G4, E4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=12;MINY=0;
                    varY{vN}=var(:,9);yprec='%1.1f';yAdjustment=10^(-4);yA='$10^{-4}$';
            end
        case {151,152,153,154,155,156,157} % q = 2
            var=G4d001;q=2;
            labelX1 = '$\log T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=16$, $32^2$ grid, $10^6$ sweeps, $d = $4d Heisenberg';
            vN=1;varX{vN}=log(abs(var(:,1)));delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{4};
            switch varNumber
                case 151
                    fileName = '2d G4, X_a_ln';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;
                    varY{vN}=log(abs(var(:,10)));yprec='%1.0f';
                case 152
                    fileName = '2d G4, C_a_ln';legLocation='southeast';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varY{vN}=log(abs(var(:,11)));yprec='%1.1f'; 
            end
    case {61,62,63,64,65,66,67,68} % q = 2
            var=G5d001;q=0;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=32$, $32^2$ grid, $10^6$ sweeps, $d = $5d Heisenberg';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{5};
            
            switch varNumber
                case 61
                    fileName = '2d G5, M_a';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 62
                    fileName = '2d G5, E_a';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=20;
                    varY{vN}=var(:,4);
                case 63
                    fileName = '2d G5, X_a';%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                case 64
                    fileName = '2d G5, C_a';%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$C_{\fontsize{8}{8}\selectfont H}$ ';
                    varY{vN}=var(:,11);yprec='%1.1f';
                case 65
                    fileName = '2d G5, V_a';
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$(\Delta H)^2$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.1f';
                case 66
                    fileName = '2d G5, M4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '$Q_M^{(4)}$ ';moveY=30;
                    varY{vN}=var(:,8);yprec='%1.2f';
                case 67
                    fileName = '2d G5, E4_a';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$Q_E^{(4)}$ ';moveY=12;MINY=0;
                    varY{vN}=var(:,9);yprec='%1.1f';yAdjustment=10^(-4);yA='$10^{-4}$';
            end
        case {161,162,163,164,165,166,167} % q = 2
            var=G5d001;q=0;
            labelX1 = '$\log T$ '; labelX2 = ''; labelY2 = '';
            subTitle = '$q=32$, $32^2$ grid, $10^6$ sweeps, $d = $5d Heisenberg';
            vN=1;varX{vN}=log(abs(var(:,1)));delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{4};
            switch varNumber
                case 161
                    fileName = '2d G5, X_a_ln';legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\log \chi_{_M}$ '; moveY=12;
                    varY{vN}=log(abs(var(:,10)));yprec='%1.0f';
                case 162
                    fileName = '2d G5, C_a_ln';legLocation='southeast';
                    plotTitle = '\bf Specific Heat'; moveY=24;
                    labelY1 = '$\log C_{\fontsize{8}{8}\selectfont H}$  ';
                    varY{vN}=log(abs(var(:,11)));yprec='%1.1f'; 
            end
    case {71,72,73,74,75,76,77} % q = 2
            var=heis006;q=2;
            labelX1 = '$T$ '; labelX2 = '$(T_c = 2.269)$'; labelY2 = '';
            subTitle = '$q = 2$, $32^2$ grid, $10^6$ sweeps, $d = \delta_{ij}$';
            vN=1;varX{vN}=var(:,1);delLegend=1;xprec='%1.1f';yprec='%1.1f';
            leg{vN}='Simulated';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{7};MAXX=2.4;
            
              switch varNumber
                case 71
                    fileName = '2d Heis, M_f';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    varY{vN}=var(:,2);MINY=0;
                case 72
                    fileName = '2d Heis, E_f';yprec='%1.1f';
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=24;
                    varY{vN}=var(:,4);
                case 73
                    fileName = '2d Heis, X_f';delLegend=0;%legLocation='northeast';
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    varY{vN}=var(:,10);yprec='%1.0f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,2))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 74
                    fileName = '2d Heis, C_f';delLegend=0;%legLocation='southeast';
                    plotTitle = '\bf Specific Heat';
                    labelY1 = '$c_N$ ';
                    varY{vN}=var(:,11);yprec='%1.1f';
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 75
                    fileName = '2d Heis, V_f';delLegend=0;
                    plotTitle = '\bf Energy Variance';
                    labelY1 = '$\left<(\Delta H)^2\right>$ ';
                    varY{vN}=var(:,11).*(var(:,1).^2);yprec='%1.0f';moveY=20;
                    vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1))).*((var(1:end-1,1)+diff(var(:,1))./2).^2);
                    leg{vN}='Numerical';lT{vN}='-.';lW{vN}=1.0;mS{vN}=3;lC{vN}=lC{1}/3;
                case 76
                    fileName = '2d Heis, M4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Magnetic Cumulant';
                    labelY1 = '($V_m)^4$ ';moveY=25;
                    varY{vN}=var(:,8);yprec='%1.0f';yAdjustment=10^(-2);yA='$10^{-\;2}$';
                case 77
                    fileName = '2d Heis, E4_f';
                    plotTitle = '\bf $4^{\rm th}$ Order Energy Cumulant';
                    labelY1 = '$(V_E)^4$ ';moveY=24;yAdjustment=10^(-3);yA='$10^{-\;3}$';
                    varY{vN}=var(:,9);yprec='%1.2f';
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
        case 101
            fileName = '2d Potts, M_28a';
            plotTitle = '\bf 2D Potts Model, Magnetization';
            labelY1 = '$\left<E\right>$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.1f';
            vN=1;varX{vN}=potts02(:,1);varY{vN}=potts02(:,2);
            leg{vN}='q=2';lT{vN}='o';lW{vN}=1;mS{vN}=3.5;lC{vN}=lineColor{vN};
            vN=2;varX{vN}=potts03(:,1);varY{vN}=potts03(:,2);
            leg{vN}='q=3';lT{vN}='o';lW{vN}=1;mS{vN}=3.25;lC{vN}=lineColor{vN};
            vN=3;varX{vN}=potts04(:,1);varY{vN}=potts04(:,2);
            leg{vN}='q=4';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
            vN=4;varX{vN}=potts05(:,1);varY{vN}=potts05(:,2);
            leg{vN}='q=5';lT{vN}='o';lW{vN}=1;mS{vN}=2.75;lC{vN}=lineColor{vN};
            vN=5;varX{vN}=potts06(:,1);varY{vN}=potts06(:,2);
            leg{vN}='q=6';lT{vN}='o';lW{vN}=1;mS{vN}=2.5;lC{vN}=lineColor{vN};
            vN=6;varX{vN}=potts07(:,1);varY{vN}=potts07(:,2);
            leg{vN}='q=7';lT{vN}='o';lW{vN}=1;mS{vN}=2.25;lC{vN}=lineColor{vN};
            vN=7;varX{vN}=potts08(:,1);varY{vN}=potts08(:,2);
            leg{vN}='q=8';lT{vN}='o';lW{vN}=1;mS{vN}=2;lC{vN}=lineColor{vN};
            legLocation='northeast';  
        case 102
            fileName = '2d Potts, E_28a';
            plotTitle = '\bf 2D Potts Model, Mean Energy';
            labelY1 = '$\left<E\right>$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.1f';
            vN=1;varX{vN}=potts02(:,1);varY{vN}=potts02(:,3);
            leg{vN}='q=2';lT{vN}='o';lW{vN}=1;mS{vN}=3.5;lC{vN}=lineColor{vN};
            vN=2;varX{vN}=potts03(:,1);varY{vN}=potts03(:,3);
            leg{vN}='q=3';lT{vN}='o';lW{vN}=1;mS{vN}=3.25;lC{vN}=lineColor{vN};
            vN=3;varX{vN}=potts04(:,1);varY{vN}=potts04(:,3);
            leg{vN}='q=4';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
            vN=4;varX{vN}=potts05(:,1);varY{vN}=potts05(:,3);
            leg{vN}='q=5';lT{vN}='o';lW{vN}=1;mS{vN}=2.75;lC{vN}=lineColor{vN};
            vN=5;varX{vN}=potts06(:,1);varY{vN}=potts06(:,3);
            leg{vN}='q=6';lT{vN}='o';lW{vN}=1;mS{vN}=2.5;lC{vN}=lineColor{vN};
            vN=6;varX{vN}=potts07(:,1);varY{vN}=potts07(:,3);
            leg{vN}='q=7';lT{vN}='o';lW{vN}=1;mS{vN}=2.25;lC{vN}=lineColor{vN};
            vN=7;varX{vN}=potts08(:,1);varY{vN}=potts08(:,3);
            leg{vN}='q=8';lT{vN}='o';lW{vN}=1;mS{vN}=2;lC{vN}=lineColor{vN};
            legLocation='northwest';        
        case 103
            fileName = '2d Potts, C_28d';
            plotTitle = '\bf Specific Heat (Numerical)';
            labelY1 = '$c$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.0f';
            var=potts02;vN=1;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=2';lT{vN}='-';lW{vN}=2;mS{vN}=3.5;lC{vN}=lineColor{vN};
            var=potts03;vN=2;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=3';lT{vN}='-';lW{vN}=2;mS{vN}=3.25;lC{vN}=lineColor{vN};
            var=potts04;vN=3;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=4';lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
            var=potts05;vN=4;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=5';lT{vN}='-';lW{vN}=2;mS{vN}=2.75;lC{vN}=lineColor{vN};
            var=potts06;vN=5;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=6';lT{vN}='-';lW{vN}=2;mS{vN}=2.5;lC{vN}=lineColor{vN};
            var=potts07;vN=6;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=7';lT{vN}='-';lW{vN}=2;mS{vN}=2.25;lC{vN}=lineColor{vN};
            var=potts08;vN=7;varX{vN}=var(1:end-1,1)+diff(var(:,1))./2;varY{vN}=abs(diff(var(:,4))./diff(var(:,1)));
            leg{vN}='q=8';lT{vN}='-';lW{vN}=2;mS{vN}=2;lC{vN}=lineColor{vN};
            MINY=0;legLocation='northeast';MAXX=2.4;MINX=1.4;
                    case 104
            fileName = '2d Potts, C_28dd';
            plotTitle = '\bf Specific Heat (Simulated)';
            labelY1 = '$c$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.0f';
            var=potts02;vN=1;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=2';lT{vN}='-';lW{vN}=2;mS{vN}=3.5;lC{vN}=lineColor{vN};
            var=potts03;vN=2;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=3';lT{vN}='-';lW{vN}=2;mS{vN}=3.25;lC{vN}=lineColor{vN};
            var=potts04;vN=3;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=4';lT{vN}='-';lW{vN}=2;mS{vN}=3;lC{vN}=lineColor{vN};
            var=potts05;vN=4;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=5';lT{vN}='-';lW{vN}=2;mS{vN}=2.75;lC{vN}=lineColor{vN};
            var=potts06;vN=5;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=6';lT{vN}='-';lW{vN}=2;mS{vN}=2.5;lC{vN}=lineColor{vN};
            var=potts07;vN=6;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=7';lT{vN}='-';lW{vN}=2;mS{vN}=2.25;lC{vN}=lineColor{vN};
            var=potts08;vN=7;varX{vN}=var(:,1);varY{vN}=var(:,7);
            leg{vN}='q=8';lT{vN}='-';lW{vN}=2;mS{vN}=2;lC{vN}=lineColor{vN};
            MINY=0;legLocation='northeast';MAXX=2.4;MINX=1.4;
        case 105
            fileName = '2d Potts, E_28b';
            plotTitle = '\bf 2D Clock Model, Mean Energy';
            labelY1 = '$\left<E\right>$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.1f';
            vN=1;varX{vN}=potts02b(:,1);varY{vN}=potts02b(:,3);
            leg{vN}='q=2';lT{vN}='o';lW{vN}=1;mS{vN}=3.5;lC{vN}=lineColor{vN};
            vN=2;varX{vN}=potts03b(:,1);varY{vN}=potts03b(:,3);
            leg{vN}='q=3';lT{vN}='o';lW{vN}=1;mS{vN}=3.25;lC{vN}=lineColor{vN};
            vN=3;varX{vN}=potts04b(:,1);varY{vN}=potts04b(:,3);
            leg{vN}='q=4';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
            vN=4;varX{vN}=potts05b(:,1);varY{vN}=potts05b(:,3);
            leg{vN}='q=5';lT{vN}='o';lW{vN}=1;mS{vN}=2.75;lC{vN}=lineColor{vN};
            vN=5;varX{vN}=potts06b(:,1);varY{vN}=potts06b(:,3);
            leg{vN}='q=6';lT{vN}='o';lW{vN}=1;mS{vN}=2.5;lC{vN}=lineColor{vN};
            vN=6;varX{vN}=potts07b(:,1);varY{vN}=potts07b(:,3);
            leg{vN}='q=7';lT{vN}='o';lW{vN}=1;mS{vN}=2.25;lC{vN}=lineColor{vN};
            vN=7;varX{vN}=potts08b(:,1);varY{vN}=potts08b(:,3);
            leg{vN}='q=8';lT{vN}='o';lW{vN}=1;mS{vN}=2;lC{vN}=lineColor{vN};
            legLocation='northwest';
        case 106
            fileName = '2d Potts, C_28b';
            plotTitle = '\bf 2D Clock Model, Heat Capacity';
            labelY1 = '$|\left<C\right>|$ '; moveY=20;
            labelX1 = '$T$ '; labelX2 = ''; labelY2 = '';
            subTitle = 'q = 2:8, $200^2$ grid, $5\times 10^4$ iterations';
            xprec='%1.1f';yprec='%1.2f';
            vN=1;varX{vN}=potts02b(:,1);varY{vN}=potts02b(:,5);
            leg{vN}='q=2';lT{vN}='o';lW{vN}=1;mS{vN}=3.5;lC{vN}=lineColor{vN};
            vN=2;varX{vN}=potts03b(:,1);varY{vN}=potts03b(:,5);
            leg{vN}='q=3';lT{vN}='o';lW{vN}=1;mS{vN}=3.25;lC{vN}=lineColor{vN};
            vN=3;varX{vN}=potts04b(:,1);varY{vN}=potts04b(:,5);
            leg{vN}='q=4';lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
            vN=4;varX{vN}=potts05b(:,1);varY{vN}=potts05b(:,5);
            leg{vN}='q=5';lT{vN}='o';lW{vN}=1;mS{vN}=2.75;lC{vN}=lineColor{vN};
            vN=5;varX{vN}=potts06b(:,1);varY{vN}=potts06b(:,5);
            leg{vN}='q=6';lT{vN}='o';lW{vN}=1;mS{vN}=2.5;lC{vN}=lineColor{vN};
            vN=6;varX{vN}=potts07b(:,1);varY{vN}=potts07b(:,5);
            leg{vN}='q=7';lT{vN}='o';lW{vN}=1;mS{vN}=2.25;lC{vN}=lineColor{vN};
            vN=7;varX{vN}=potts08b(:,1);varY{vN}=potts08b(:,5);
            leg{vN}='q=8';lT{vN}='o';lW{vN}=1;mS{vN}=2;lC{vN}=lineColor{vN};
            MINY=0;legLocation='northeast';
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
    chH = get(gca,'Children');
    set(gca,'Children',[chH(end);chH(1:end-1)]);
    
    %Disable Legend Outline
    legend('boxoff')
    
    %Set Label Font-sizes
    xlabel(labelX, 'fontsize',labS);
    ylabel(labelY, 'fontsize',labS);
    
    %Turn on LaTeX Interpreter
    set(0, 'defaulttextinterpreter', 'latex')
    
    
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

    if ~isempty(yTickMarks)
        set(gca,'ytick',yTickMarks);
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
        text(-0.08,1+0.09/axesHeight,[' $\times\;$  ',yA],...
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
