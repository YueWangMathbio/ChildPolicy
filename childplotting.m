%
%

clear all
close all

%load realpf.dat % real female population from 1981 to 2020



%%%%%%%%%%%%%%%%%% Fig. 1 %%%%%%%%%%%%%%%
load br.dat
load brtrue.dat
load drf.dat

ff=figure(1);
ff.Position=[50 50 1050 650];
f11=plot(0:89,br(1:90),'r',0:89,brtrue(1:90),'b',...
    0:89,drf(1:90),'k','linew',3);
ylim([-0.02 0.4])
xlabel('$\textrm{age } a \textrm{ [years]}$','Interpreter','latex') 
ylabel('$\textrm{rate [1/year]}$','Interpreter','latex') 
xticks(0:15:90)
legend('$\textrm{observed birth rate }\beta_{\textrm{eff}}(a)$',...
    '$\textrm{adjusted birth rate }\beta_0(a)$',...
    '$\textrm{female death rate }\mu_{\textrm{f}}(a)$',...
    'Interpreter','latex')
set(gca,'FontSize',30);
grid on
ax = f11.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Fig. 2 %%%%%%%%%%%%%%%
load Pf2.dat

ff=figure(2);
ff.Position=[50 50 1850 650];
subplot(1,2,1)
f21=plot(0:99,Pf2(:,100)/sum(sum(Pf2)),'r',...
    0:99,sum(Pf2,2)/sum(sum(Pf2)),'k','linew',2);
xticks([0 25 50 75 100])
%yticks([0 0.25 0.5 0.75 1.00])
%yticklabels({'0.00','0.25','0.50','0.75','1.00'})
set(gca,'FontSize',30);
legend('$h_0(a)$','$h_{\textrm{tot}}(a)$','Interpreter','latex')
xlabel('$\textrm{age } a \textrm{ [years]}$','Interpreter','latex') 
ylabel('$h_{\textrm{tot}}(a)\textrm{ probability density}$',...
    'Interpreter','latex') 
txt='(a)';
text(9,0.018,txt,'FontSize',35)
grid on
ax = f21.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';

subplot(1,2,2)
wb=Pf2(2:100,1:99)/sum(sum(Pf2(2:100,1:99)));
wb=wb';
%wb=flip(wb,1);
for i=1:99
    for j=1:i
        wb(i,j)=NaN;
    end
end
h=pcolor(wb);
set(h, 'EdgeColor', 'none');
cb=colorbar;
%caxis([2 35])
ylabel(cb,'$h(a,\tau)\ \textrm{density}$','Interpreter',...
    'latex','FontSize',26)
xlabel('$\textrm{age } a \textrm{ [years]}$','Interpreter','latex') 
ylabel('$\textrm{time since last birth }\tau$','Interpreter','latex') 
set(gca,'FontSize',30);
txt='(b)';
text(9,90,txt,'FontSize',35)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%% Fig. 3 %%%%%%%%%%%%%%%
load rg.dat
load dist.dat

ff=figure(3);
colormap turbo
ff.Position=[50 50 1850 650];
subplot(1,2,1)
x=2:35;
y=rg;
z=zeros(size(x));
col=x;  % This is the color, vary with x in this case.
hint=surface([x;x],[y;y],[z;z],[col;col],'facecol','no','edgecol',...
    'interp','linew',3);
xlim([0 35])
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
txt='(a)';
text(3,0.005,txt,'FontSize',30)
xlabel('$\textrm{interbirth delay }\delta\textrm{ [years]}$',...
    'Interpreter','latex') 
ylabel({'$\textrm{stationary net growth}$';...
    '$\textrm{rate }\lambda \textrm{ [1/year]}$'},'Interpreter','latex') 
yl=yline(-0.0335,'--','strict one-child policy limit','LineWidth',3);
yl.Color=[0.6 0 0];
yl.FontSize=24;
yl.LabelVerticalAlignment = 'bottom';
yl.LabelHorizontalAlignment = 'center';
xl=xline(2,'--','2 years','LineWidth',3);
xl.FontSize=24;
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'right';
set(gca,'FontSize',31);
grid on
%set(haxes(1),'XTick',0:2:34)

subplot(1,2,2)
colormap turbo
cm=turbo;
colororder([cm(14:7:77,:);cm(91:14:147,:);cm(245,:)])
fh=plot(0:99,dist(1:10,:),0:99,dist(12:2:20,:),...
    0:99,dist(34,:),'LineWidth',2);
ax = fh.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xticks([0 25 50 75 100])
xlabel('$\textrm{age }a\textrm{ [years]}$','Interpreter','latex') 
ylabel({'';'$h_{\textrm{tot}}(a)\textrm{ probability}$';...
    '$\textrm{ density}$'},'Interpreter','latex') 
txt='(b)';
text(8,0.0225,txt,'FontSize',30)
cb=colorbar;
caxis([2 35])
ylabel(cb,'$\textrm{interbirth delay }\delta\textrm{ [years]}$',...
    'Interpreter','latex')
set(gca,'FontSize',30);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%% Fig. 4 %%%%%%%%%%%%%%%
load P0.dat
load tott.dat

colormap turbo
ff=figure(4);
ff.Position=[50 50 1850 650];
s41=subplot(1,2,1);
s41.Position=[0.1636    0.1828    0.2973    0.7555];
hint=plot(0:99,P0(:,100)/1e6,'b',0:99,sum(P0(:,1:99),2)/1e6,'r',...
    0:99,sum(P0,2)/1e6,'k--','LineWidth',2);
legend('$I_0(a)$','$\int_0^\infty I(a,\tau)\mathrm{d}\tau$',...
    '$I_{\textrm{tot}}(a)$','Interpreter','latex')
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlim([-3 100])
xticks([0 25 50 75 100])
ylim([-0.5 15])
yticks([0 5 10 15])
txt='(a)';
text(1.5,14,txt,'FontSize',30)
xlabel('$\textrm{age }a\textrm{ [years]}$','Interpreter','latex') 
ylabel({'$\textrm{initial female }$';...
    '$\textrm{population distribution}$';...
    '$\textrm{[millions/year]}$'},'Interpreter','latex') 
set(gca,'FontSize',31);
grid on

s42=subplot(1,2,2);
s42.Position=[0.6040    0.1828    0.3523    0.7555];
colormap turbo
cm=turbo;
colororder(cm(14:7:245,:))
hold on
hint=plot(1981:2080,tott(1,1:100)'/1e6,'LineWidth',5,'LineStyle','--');
plot(1981:2080,tott(2:33,1:100)'/1e6,'LineWidth',2);
plot(1981:2080,tott(34,1:100)'/1e6,'LineWidth',5,'LineStyle','--');
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlim([1980 2080])
ylim([0 1200])
xticks([1980 2010 2050 2080])
xlabel('$\textrm{year}$','Interpreter','latex') 
ylabel({'';'$\textrm{total female population}$';...
    '$n(t) \textrm{ [millions]}$'},'Interpreter','latex') 
line([1983 1996],[300 300],'LineStyle','--','LineWidth',3,...
    'Color',cm(245,:));
text(1996,340,'strict one-child','FontSize',24,'Color',cm(245,:))
text(1996,260,'policy: \delta=\infty','FontSize',24,'Color',cm(245,:))
line([1983 1996],[950 950],'LineStyle','--','LineWidth',3,...
    'Color',cm(14,:));
text(1996,990,'no refractory period','FontSize',24,'Color',cm(14,:))
text(1996,910,'policy: \delta=2','FontSize',24,'Color',cm(14,:))
txt='(b)';
text(1990,1100,txt,'FontSize',30)
cb=colorbar;
caxis([2 35])
ylabel(cb,'$\textrm{interbirth delay }\delta\textrm{ [years]}$',...
    'Interpreter','latex')
set(gca,'FontSize',30);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%% Fig. 5 %%%%%%%%%%%%%%%
load tott.dat
load realpf.dat

ff=figure(5);
ff.Position=[50 50 1850 650];
s51=subplot(1,2,1);
s51.Position=[0.1536    0.1728    0.3056    0.7762];
hint=plot(1982:2020,tott(1,2:40)./tott(1,1:39)-1,'b-',...
    1982:2020,tott(2,2:40)./tott(2,1:39)-1,'b-o',...
    1982:2020,tott(3,2:40)./tott(3,1:39)-1,'b-+',...
    1982:2020,tott(4,2:40)./tott(4,1:39)-1,'b-*',...
    1982:2020,tott(5,2:40)./tott(5,1:39)-1,'b-x',...
    1982:2020,tott(34,2:40)./tott(34,1:39)-1,'k--',...
    1982:2020,realpf(2:40)./realpf(1:39)-1,'r','linew',2,'MarkerSize',13,'MarkerIndices',3:3:39);
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
grid on
xlim([1980 2038])
set(gca,'FontSize',30);
legend('$\delta=2$','$\delta=3$','$\delta=4$','$\delta=5$',...
    '$\delta=6$','$\delta=\infty$','$\textrm{obs.}$','Interpreter','latex')
xlabel('$\textrm{year}$','Interpreter','latex') 
ylabel('$\textrm{net growth rate [1/year]}$','Interpreter','latex') 
txt='(a)';
text(1985,-0.006,txt,'FontSize',30)

s52=subplot(1,2,2);
s52.Position=[0.6540    0.1728    0.3056    0.7762];
hint=plot(1981:2020,realpf/1e6,'k-',...
    2020:2100,tott(1,40:120)/tott(1,40)*realpf(40)/1e6,'r-',...
    2020:2100,tott(2,40:120)/tott(2,40)*realpf(40)/1e6,'b--',...
    2020:2100,tott(3,40:120)/tott(3,40)*realpf(40)/1e6,'g-.','linew',2);
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
grid on
set(gca,'FontSize',30);
ylim([400 1200])
legend('$\textrm{obs.}$','$\delta=2\textrm{ prediction}$',...
'$\delta=3\textrm{ prediction}$','$\delta=4\textrm{ prediction}$','Interpreter','latex')
xlabel('$\textrm{year}$','Interpreter','latex') 
ylabel({'';'$\textrm{female population}$';'$\textrm{[millions]}$'},'Interpreter','latex') 
txt='(b)';
text(1990,500,txt,'FontSize',30)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%% Fig. 6 %%%%%%%%%%%%
load spr.dat
load lambda.dat

ff=figure(6);
ff.Position=[50 50 1850 750];
s61=subplot(1,2,1);
s61.Position=[0.0836    0.2228    0.3523    0.6778];
hold on
lev=0.1:0.02:0.4;
[C,h] =contourf(spr,lev,'LineWidth',0.5,'ShowText','on');
clabel(C,h,'FontSize',24)
[C,h] =contour(spr,0:0.2:0.4,'r--','LineWidth',4);

xlabel({'$\textrm{minimum childbearing}$';...
    '$\textrm{age }a_{\min}\textrm{ [years]}$'},...
    'Interpreter','latex') 
ylabel({'$\textrm{interbirth delay }\delta\textrm{ [years]}$'},...
    'Interpreter','latex') 
xticks(2:2:10)
xticklabels({'22','24','26','28','30'})
yticks(1:2:9)
yticklabels({'2','4','6','8','10'})
ax = h.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
set(gca,'TickDir','out');
cb=colorbar;
caxis([0.1 0.4])
ylabel(cb,{'$\textrm{senior population percentage}$'},...
    'Interpreter','latex')
set(gca,'FontSize',30);
txt='(a)';
text(1.2,8,txt,'FontSize',35)
hold off

s62=subplot(1,2,2);
hint=plot(1:20,lambda,'LineWidth',2);
s62.Position=[0.6540    0.2228    0.3077    0.6778];
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlim([0 21])
xticks(1:5:16)
xticklabels({'15','20','25','30'})
ylim([-0.06 -0.025])
grid on
xlabel({'$\textrm{minimum childbearing}$';...
    '$\textrm{age }a_{\min}\textrm{ [years]}$'},...
    'Interpreter','latex') 
ylabel({'';'';'';'$\textrm{stationary net growth}$';...
    '$\textrm{rate }\lambda\textrm{ [1/year]}$'},'Interpreter','latex') 
txt='(b)';
text(2,-0.03,txt,'FontSize',35)
set(gca,'FontSize',30);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%% Fig. 7 %%%%%%%%%%%%%%%%%%%%%%%
load ra.dat

ff=figure(7);
ff.Position=[50 50 1150 910];
hold on
lev=0.3:0.02:0.54;

[C,h] =contourf(ra,lev,'LineWidth',0.5,'ShowText','on');
clabel(C,h,'FontSize',24)
contour(ra,0:0.5:1,'r--','LineWidth',4)
xlabel({'$\textrm{female percentage at birth }\xi$'},...
    'Interpreter','latex') 
ylabel({'$\textrm{interbirth delay }\delta\textrm{ [years]}$'},...
    'Interpreter','latex') 
xticks(1:5:21)
xticklabels({'0.30','0.35','0.40','0.45','0.50'})
yticks(4:5:29)
yticklabels({'5','10','15','20','25','30'})
cb=colorbar;
caxis([0.3 0.54])
ylabel(cb,{'$\textrm{female population percentage}$'},...
    'Interpreter','latex')
set(gca,'FontSize',30);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%% Fig. 8 %%%%%%%%%%%%%%%
load rg.dat
load rgn.dat
load tott.dat
load t2.dat

ff=figure(8);
colormap turbo
ff.Position=[50 50 1850 650];
subplot(1,2,1)
hold on
yl=yline(-0.0335,'--','one-child policy limit','LineWidth',3);
yl.Color=[0.6 0 0];
yl.FontSize=24;
yl.LabelVerticalAlignment = 'top';
yl.LabelHorizontalAlignment = 'left';
xl=xline(2,'--','2 years','LineWidth',3);
xl.FontSize=24;
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'right';
hint=plot(2:35,rg,'r',2:35,rgn,'b','LineWidth',2);
txt='(a)';
text(3,0.005,txt,'FontSize',35)
xlim([0 35])
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlabel('$\textrm{interbirth delay }\delta\textrm{ [years]}$',...
    'Interpreter','latex') 
ylabel({'$\textrm{stationary net growth}$';...
    '$\textrm{rate }\lambda \textrm{ [1/year]}$'},'Interpreter','latex')
legend('','','original model','response model')
%legend([hint(1) hint(2)],'plot 1','plot 3') 
set(gca,'FontSize',31);
hold off
grid on

subplot(1,2,2)
z1=2;
z2=3;
z3=6;
z4=14;
hold on

hint=plot(1981:2080,tott(z1,1:100)'/1e6,'r-','LineWidth',3);
plot(1981:2080,t2(z1,1:100)'/1e6,'b-','LineWidth',3);
plot(1981:2080,t2(z2,1:100)'/1e6,'b--','LineWidth',3)
plot(1981:2080,tott(z2,1:100)'/1e6,'r--','LineWidth',3)
plot(1981:2080,t2(z3,1:100)'/1e6,'b:','LineWidth',3)
plot(1981:2080,tott(z3,1:100)'/1e6,'r:','LineWidth',3)
plot(1981:2080,t2(z4,1:100)'/1e6,'b-.','LineWidth',3)
plot(1981:2080,tott(z4,1:100)'/1e6,'r-.','LineWidth',3)

legend('original model','response model')
txt='(b)';
text(1990,900,txt,'FontSize',35)
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlim([1980 2080])
%ylim([0 1000])
xticks([1980 2010 2050 2080])
xlabel('$\textrm{year}$','Interpreter','latex') 
ylabel({'';'$\textrm{total female population}$';...
    '$n(t) \textrm{ [millions]}$'},'Interpreter','latex') 
set(gca,'FontSize',30);
grid on
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%% Fig. 9 %%%%%%%%%%%%%%%
load rg.dat
load jprg.dat

ff=figure(9);
colormap turbo
ff.Position=[50 50 850 650];
hint=plot(2:35,rg,'r',2:35,jprg,'b','LineWidth',2);
xlim([0 35])
ax = hint.Parent;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xlabel('$\textrm{interbirth delay }\delta\textrm{ [years]}$',...
    'Interpreter','latex') 
ylabel({'$\textrm{stationary net growth}$';...
    '$\textrm{rate }\lambda \textrm{ [1/year]}$'},'Interpreter','latex') 
xl=xline(2,'--','2 years','LineWidth',3);
xl.FontSize=24;
xl.LabelVerticalAlignment = 'bottom';
xl.LabelHorizontalAlignment = 'right';
legend('China','Japan')
set(gca,'FontSize',31);
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


