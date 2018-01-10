function [ coords ] = CreatePattern( nmol )
%UNTITLED3 Summary of this function goes here
%   Creates a series of lines of a certain width and period


coords = [];
width = 1.5;
period = 10;

while size(coords,1) < nmol
    randx = 100*rand + 10;
    randy = 100*rand + 10;
    xperiod = floor(randx/period);
    if (randx/period)-xperiod < width/10
        ind = size(coords,1);
        coords(ind+1,1) = randx;
        coords(ind+1,2) = randy;
    end
end


end

