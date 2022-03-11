% Generate a 34*21 matrix ra.dat that describes stationary female fraction 
% as a function of interbirth delay (34 rows, from 2 years to 35 years) 
% and female birth fraction (21 columns, from 0.30 to 0.50). 
% Used for drawing Fig. 7.


clear all
close all

load popf.dat
load popm.dat
load drf.dat
load drm.dat
load brtrue.dat

xi=0.48;
res=14;
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

for del=2:35
    for cc=1:21
        xi=0.29+cc/100;
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
        end
        ra(del-1,cc)=sum(sum(Pn))/(sum(Qn)+sum(sum(Pn)));
    end
end

save ra.dat ra -ascii
