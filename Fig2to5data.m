% Generate a 100*100 matrix Pf2.dat that describes the stationary 
% female population number of different ages (100 rows, 0-99 years old) 
% and childbirth status (100 columns, for i=1-99, ith column is female 
% that her youngest child is i-1 to i years old, and 100th column is 
% female without a child).
% Used for drawing Fig. 2.

% Generate a 1*34 matrix rg.dat that describes the asymptotic growth rate
% as a function of interbirth delay (34 columns, from 2 years to 35 years).
% Used for drawing Fig. 3a.

% Generate a 34*100 matrix dist.dat that describes the density function of
% population distribution (100 columns, 0-99 years old) that depens on the
% interbirth delay (34 rows, from 2 years to 35 years).
% Used for drawing Fig. 3b.

% Generate a 100*100 matrix P0.dat that describes the 1981 China 
% female population number of different ages (100 rows, 0-99 years old) 
% and childbirth status (100 columns, for i=1-99, ith column is female 
% that her youngest child is i-1 to i years old, and 100th column is 
% female without a child).
% Used for drawing Fig. 4a.

% Generate a 34*300 matrix tott.dat that describes the predicted female 
% population number at different time points (300 columns, 1981-2280) and
% different interbirth delays (34 rows, from 2 years to 35 years).
% Used for drawing Fig. 4b and Fig. 5.


clear all
close all

load popf.dat
load popm.dat
load drf.dat
load drm.dat
load brtrue.dat

xi=0.48;
res=15;

P0=zeros(100,100); 
P0(1,100)=1;
for i=2:100
    P0(i,1)=sum(P0(i-1,3:100))*brtrue(i-1); % give birth
    for j=2:3
        P0(i,j)=P0(i-1,j-1)*(1-drf(i-1));
    end
    for j=4:99
        P0(i,j)=P0(i-1,j-1)*(1-drf(i-1)-brtrue(i-1));
    end
    P0(i,100)=P0(i-1,100)*(1-drf(i-1)-brtrue(i-1));
    P0(i,:)=P0(i,:)/sum(P0(i,:));
end
for i=1:100
	P0(i,:)=P0(i,:)*popf(i);
end
tott=zeros(34,300);
dist=zeros(34,100);
for del=2:35
    P=P0;
    Q=popm;% male pop
    S=zeros(300,1);
    S(1)=sum(Q);% total male pop
    R=zeros(300,1);
    R(1)=sum(popf);
    for t=2:300
        Pn=P;
        Qn=Q;
        Qn(1)=0;
        Pn(1,:)=0;
        for i=2:100
            if i>res
                Pn(i,1)=sum(P(i-1,del+1:100))*brtrue(i-1); % give birth
                Pn(1,100)=Pn(1,100)+Pn(i,1)*xi; % new born
                Qn(1)=Qn(1)+Pn(i,1)*(1-xi);
                for j=2:del+1
                    Pn(i,j)=P(i-1,j-1)*(1-drf(i-1));
                end
                for j=del+2:99
                    Pn(i,j)=P(i-1,j-1)*(1-drf(i-1)-brtrue(i-1));
                end
                Pn(i,100)=P(i-1,100)*(1-drf(i-1)-brtrue(i-1));
            else
                Pn(i,1)=0;
                for j=2:99
                    Pn(i,j)=P(i-1,j-1)*(1-drf(i-1));
                end
                Pn(i,100)=P(i-1,100)*(1-drf(i-1));
            end
            Qn(i)=Q(i-1)*(1-drm(i-1));
        end
        P=Pn;
        Q=Qn;
        R(t)=sum(sum(Pn));
        S(t)=sum(Qn);
        if t==300
            t1=sum(P,2);
            t2=(sum(t1(66:100)))/(sum(t1));
            sr(del-1,res-14)=t2;
            tp(del-1,res-14)=sum(t1);
            lam(del-1,res-14)=R(150)/R(149)-1;
        end
    end
    tp(del-1,res-14)=sum(t1);
    rg(del-1)=R(300)/R(299)-1;% female pop growth rate
    for i=1:100
        dist(del-1,i)=sum(P(i,:))/sum(sum(P));
    end
    tott(del-1,:)=R;
    if del==2
        Pf2=P;
    end
end
tott(:,1)=sum(sum(P0));


save Pf2.dat Pf2 -ascii


save rg.dat rg -ascii
save dist.dat dist -ascii

save P0.dat P0 -ascii
save tott.dat tott -ascii


