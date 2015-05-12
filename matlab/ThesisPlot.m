

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
    [24/255 90/255 169/255], [238/255   46/255   47/255], [0 0.549 0.282],          ...
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
plotMode = 5

for varNumber =1
 
    % Default Arguments
    plotTitle='';subTitle='';
    plotRes=1;yA='';minR=0;maxR=1;
    xAdjustment=1;yAdjustment=1;moveY_Default=12;moveY=moveY_Default;
    legLocation = 'best';clear varY leg;extraVar = 0;
    xTickMarks=[];yTickMarks=[];MAXY=[];MINY=[];MAXX=[];MINX=[];
    delLegend=0;noMax=0;plotAxis=[];plotError=0;legBoxOff=1;
    yprec='%1.1f';xprec='%1.1f';swapChildren=0;minorTicks=0;q=0;qq=0;vN=0;
    
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
%             subTitle = '{\bf Potts Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
            switch varNumber
                case 1
                    subTitle = '{\bf Clock Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
                    fileName = 'Clock_H58';delLegend=0;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\langle H\rangle$ ';
                    xprec='%1.1f';yprec='%1.1f';
                    moveY=8;legLocation='northwest';
                    
                    if (plotMode ==1)
                        yN=4;
                        vN=1;MINY=0;MINX=0.2;MAXX=1.4;MAXY=1.2;
                            var=Clock5;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN))+2;
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$q=6$';var=Clock6;
                            varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN))+2;
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=3; var=Clock8;leg{vN}='$q=8$';
                            varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN))+2;
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=4;var=Clock27;leg{vN}='$q=27$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN))+2;
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                        
                            yTickMarks=[0 0.4 0.8 1.2]; xTickMarks=[0.2 0.6 1 1.4];
                    elseif (plotMode ==2)
                        subTitle = '{\bf Clock Model Squared: }$J=2$, $32^2$ grid, $10^6 $ sweeps';
                        yN=4;legLocation='south';
                        vN=1;MINY=0;MINX=0.2;
                        MAXX=1.4;MAXY=1.65;
                            var=Csquared5;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$q=6$';var=Csquared6;
                            varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN));
                            lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=3; var=Csquared7;leg{vN}='$q=7$';
                            varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=4;var=Csquared8;leg{vN}='$q=8$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;var=Csquared8f;leg{vN}='$q=8f$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                                                    vN=vN+1;var=Csquared27;leg{vN}='$q=27$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                          yTickMarks=[0 0.4 0.8 1.2 1.6]; xTickMarks=[0.2 0.6 1 1.4];
                    elseif (plotMode == 3)
                                                yN=4;
                        MINX=0.2;MAXX=1.4;
                                                vN=1;var=Csquared8;leg{vN}='$q=8s$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;var=Clock8;leg{vN}='$q=8$'; yN=11;
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                  elseif (plotMode == 4)
                                       
                             
       
            subTitle = '{\bf Heisenberg:} $J=2$, $32^2$ grid, $10^6$ sweeps';fileName = 'H_p_E';plotTitle = '';
            delLegend=0;legLocation='southeast';
                        yN=2;labelY1 = '$\langle H\rangle$ ';
                        vN=vN+1;MINY=0;MINX=0.2;
                            var=H3_2;leg{vN}='$H_3(Z_2)$';
                            varX{vN}=var(:,1);varY{vN}=(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;leg{vN}='$H_3(Z_3)$';var=H3_3;
                            varX{vN}=var(:,1); varY{vN}=(var(:,yN));
                            lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1; var=H3_4;leg{vN}='$H_3(Z_4)$';
                            varX{vN}=var(:,1); varY{vN}=(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
              
                        
%                             yTickMarks=[0 0.4 0.8 1.2]; xTickMarks=[0.2 0.6 1 1.4];

               elseif (plotMode == 5)
                                       
                             
       yprec='%1.0f';
            subTitle = '{\bf Heisenberg:} $J=2$, $32^2$ grid, $10^6$ sweeps';fileName = 'H_p_C';plotTitle = '';
            delLegend=0;legLocation='northeast'; 
                        yN=4; labelY1 = '$\log C_{\fontsize{8}{8}\selectfont B}$ ';
                        vN=vN+1;MINX=0.25;
                            var=H3_2;leg{vN}='$H_3(Z_2)$';
                            varX{vN}=var(:,1);varY{vN}=log(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;leg{vN}='$H_3(Z_3)$';var=H3_3;
                            varX{vN}=var(:,1); varY{vN}=log(var(:,yN));
                            lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1; var=H3_4;leg{vN}='$H_3(Z_4)$';
                            varX{vN}=var(:,1); varY{vN}=log(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
              
                        
                    end
            end
            switch varNumber
                case 21
                    fileName = '2d H3_3, M';
                    plotTitle = '\bf Mean Magnetization';
                    labelY1 = '$|\left<M\right>|$ ';moveY=12;
                    xprec='%1.1f';yprec='%1.1f';MINY=0;
                    yN=2;MINY=0;MINX=0.24;MAXX=1;
                    varY{vN}=var(:,yN);
                    
                case 2
                    subTitle = '{\bf Clock Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
                    fileName = '2d_Clock58_H';delLegend=0;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=16;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=4;
                    MINY=0;MINX=0.2;MAXX=1.4;MAXY=1.2;
                    if (plotMode ==1)
                         vN=1;
                                                   var=Clock5;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN))+2;
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$q=6$';
                        var=Clock6;varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN))+2;
                        lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=3;leg{vN}='$q=7$';moveY=8;
                        var=Clock7;varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN))+2;
                        lT{vN}='-.';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                                                vN=4;leg{vN}='$q=8$';
                        var=Clock8;varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN))+2;
                        lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=5;leg{vN}='$q=27$';
                        var=Clock27;varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN))+2;
                        lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                        

                    end
                    
                case 3
                    fileName = '2d H12, X_a';delLegend=0;
                    plotTitle = '\bf Magnetic Susceptibility';
                    labelY1 = '$\chi_{_M}$ '; moveY=20;
                    xprec='%1.1f';yprec='%1.0f';MINX=1.5;MINY=0;
                    yN=10;
                    MINY=0;MINX=0.2;MAXX=1.4;MAXY=1.2;
                    if (plotMode ==1)
                        vN=1;leg{vN}='$H_1$';
                        var=H1;varX{vN}=var(:,1); varY{vN}=var(:,yN);
                        lT{vN}='o';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$H_2$';
                        var=H2;varX{vN}=var(:,1);varY{vN}=var(:,yN);
                        lT{vN}='x';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                    end
                    
                case 4
                    subTitle = '{\bf Clock Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
                    fileName = '2d_Clock58_C';delLegend=0;
                    plotTitle = '\bf Specific Heat';legLocation='southeast';
                    labelY1 = '$C_{\fontsize{7}{7}\selectfont B}$ ';
                    xprec='%1.1f';yprec='%1.1f';MINX=0.2;MAXX=1.4;MINY=0;
                    yN=11;moveY=10;
                    MINY=0;MINX=0.2;MAXX=1.4;MAXY=1.65;
                    if (plotMode ==1)
                                                vN=1;leg{vN}='$q=5\qquad$';
                        var=Clock5;varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN));
                        lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=2;leg{vN}='$q=6$';
                        var=Clock6;varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN));
                        lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
%                         vN=3;leg{vN}='$q=7$';moveY=8;
%                         var=Clock7;varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
%                         lT{vN}='-.';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                                                vN=3;leg{vN}='$q=8$';
                        var=Clock8;varX{vN}=var(:,1); varY{vN}=smooth(var(:,yN));
                        lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=4;leg{vN}='$q=27$';
                        var=Clock27;varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                        lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                        yTickMarks=[0 0.4 0.8 1.2 1.6]; xTickMarks=[0.2 0.6 1 1.4];
                    end
                    
                case 5
                    subTitle = '{\bf Potts Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
                    fileName = '2d_Potts_H';delLegend=0;
                    plotTitle = '\bf Mean Energy';
                    labelY1 = '$\left<H\right>$ ';moveY=10;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2;MINY=0;MINX=0.5;MAXX=1.4;legLocation='northeast';
                    MINY=0;MINX=0.5;
                        vN=1;
                            var=Potts2;leg{vN}='$q=2\qquad$';
                            varX{vN}=var(:,1);varY{vN}=(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;leg{vN}='$q=4$';var=Potts4;
                            varX{vN}=var(:,1); varY{vN}=(var(:,yN));
                            lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1; var=Potts6;leg{vN}='$q=6$';
                            varX{vN}=var(:,1); varY{vN}=(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;var=Potts8;leg{vN}='$q=8$';
                            varX{vN}=var(:,1);varY{vN}=(var(:,yN));
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
                case 6
                    subTitle = '{\bf Potts Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
                    fileName = '2d_Potts_C';delLegend=0;
                    labelX1 = '$T$ ';
                    plotTitle = '\bf Specific Heat'; 
                    labelY1 = '$\log C_{\fontsize{7}{7}\selectfont B}$  ';
                    xprec='%1.1f';yprec='%1.0f';moveY=4;
                    yN=4;legLocation='northeast';
                 MINX=0.6;MAXX=1.4;MINY=-2.5;
                        vN=1;
                            var=Potts2;leg{vN}='$q=2$';
                            varX{vN}=var(:,1);varY{vN}=log(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;leg{vN}='$q=4$';var=(Potts4);
                            varX{vN}=var(:,1); varY{vN}=log(var(:,yN));
                            lT{vN}='-.';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1; var=(Potts6);leg{vN}='$q=6$';
                            varX{vN}=var(:,1); varY{vN}=log(var(:,yN));
                            lT{vN}=':';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                        vN=vN+1;var=(Potts8);leg{vN}='$q=8$';
                            varX{vN}=var(:,1);varY{vN}=log(var(:,yN));
                            lT{vN}='--';lW{vN}=1;mS{vN}=4;lC{vN}=lineColor{vN};
%                             yTickMarks=[0 40 80 120];
            
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
  case {2001,2002,2003,2004,2005,2006,2007,2008,2009,2010} % Q8_0
              var=potts02;
            labelX1 = '$T$ '; labelX2 = '$(T_c \simeq 2.269)$'; labelY2 = '';
            subTitle = '$J=1$, $32^2$ grid, $10^6 $ sweeps';
            delLegend=1;
            MINX=0.20;
             varShift = 2000;delLegend=1;yN=4;
            switch varNumber
                case 1+varShift;
                    fileName = 'Clock_Scaling';
                    plotTitle = '\bf Spontaneous Magnetization';
                    labelY1 = '$M$ ';moveY=10;
                        vN=1;
                            var=ClockS8;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                    vN=vN+1;   var=ClockS9;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS10;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS11;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS12;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS13;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS14;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS15;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS16;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS17;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS18;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS19;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS20;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS21;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS22;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS23;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS24;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS25;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS26;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS27;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS28;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                vN=vN+1;   var=ClockS29;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
                                                                                                            vN=vN+1;   var=ClockS30;leg{vN}='$q=5$';
                            varX{vN}=var(:,1);varY{vN}=smooth(var(:,yN));
                            lT{vN}='-';lW{vN}=1;mS{vN}=3;lC{vN}=lineColor{vN};
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
            labelX1 = '$T$ '; labelX2 = '$(T_c \simeq 2.269)$'; labelY2 = '';
%             subTitle = '$J=1$, $32^2$ grid, $10^6 $ sweeps';
            subTitle = '{\bf Ising Model: }$J=1$, $32^2$ grid, $10^6 $ sweeps';
            delLegend=0;
            vN=1;varX{vN}=var(:,1);leg{vN}='Simulated$\qquad\qquad\qquad$ $\qquad$';
            lT{vN}='o';lW{vN}=.8;mS{vN}=2.7;lC{vN}=lineColor{1};MINX=0.20;
             varShift = 10000;
            switch varNumber
                case 1+varShift;
                    fileName = 'Ising_Compare_M';
                    plotTitle = '\bf Spontaneous Magnetization';
                    labelY1 = '$M$ ';moveY=10;
                    xprec='%1.1f';yprec='%1.1f';
                    yN=2; varY{vN}=var(:,yN);
                                j=0;
J=2;
Tc = J/log(1+sqrt(2));
X=1:0.0025:4;M=[];
for (x=X)
    j=j+1;
   
M(j)=(1-(sinh(log(1+sqrt(2))*(Tc/(x))))^(-4))^(1/8);
end
 M(imag(M)>0)=0+0.001;
 
                   vN=2; varY{vN}=M';varX{vN}=X;leg{vN}='Exact';xTickMarks=[1 1.5 2 2.5 3];
                   lT{vN}='-.';lW{vN}=0.8;mS{vN}=3;lC{vN}=lineColor{2};MINX=1;MAXX=3;yTickMarks=[0 0.2 0.4 0.6 0.8 1];yprec='%1.1f';
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
            lW{j},'markersize',mS{j},'color',lC{j},'clipping','on');
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
%        legT= leg;
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
%     cmapline;c=colorbar('location','eastoutside');
%     axpos = get(gca,'Position');
% cpos = get(c,'Position');
% cpos(1)=0.80*cpos(1);
% cpos(2)=0.75*cpos(2);
% cpos(3) = 0.3*cpos(3);
% cpos(4) = 0.72*cpos(4);
% set(c,'Position',cpos)
% set(gca,'Position',[axpos(1) axpos(2) 1.28*axpos(3) axpos(4)])
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
