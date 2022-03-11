% Generate a 100*1 matrix brtrue.dat that describes Birth rate 
% for women of a given age (100 rows, 0-99 years old) that do not 
% give birth in the previous two years for 1981 China.
% Used for drawing Figs. 1-7.


clear all
close all

load br.dat

brtrue=br; 
for i=16:50
    brtrue(i)=br(i)/(1-br(i-1)-br(i-2));
end

save brtrue.dat brtrue -ascii;