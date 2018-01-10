function [ molstore ] = CreatePattern2( nmol )
%UNTITLED3 Summary of this function goes here
%   Creates a series of lines of a certain width and period


coords = [];
width = 1.5;
period = 10;

for i = 1:nmol
    found = 0;
    while found == 0
        randx = 100*rand + 10;
        randy = 100*rand + 10;
        xperiod = floor(randx/period);
        if (randx/period)-xperiod < width/10
            m = Molecule(10000,i);
            m.coords(1) = randx;
            m.coords(2) = randy;
            found = 1;
            molstore(i) = m;
        end
    end
    
end

