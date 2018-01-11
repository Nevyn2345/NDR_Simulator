function [ sensor ] = NDR( camera_params, mols, nframes, maxA )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
sensor = round((randn(camera_params.width, camera_params.height)*camera_params.NDR_rms)+camera_params.NDR_floor);
[R,C] = ndgrid(1:11, 1:11);
reset_tracker = 1;

for j = 1:nframes
    %update sensor noise
    if reset_tracker == camera_params.reset
        sensor(:,:,j+1) = round((randn(camera_params.width, camera_params.height)*camera_params.NDR_rms)+camera_params.NDR_floor);
        reset_tracker = 1;
    else
        sensor(:,:,j+1) = sensor(:,:,j) + round((randn(camera_params.width, camera_params.height)*camera_params.NDR_rms+camera_params.NDR_noiseInc));
        reset_tracker = reset_tracker+1;
    end
        
    for i = 1:size(mols.array,2)
        if mols.array(i).trajectory(j) ~= 0
            A = mols.array(i).trajectory(j) * maxA;
            coords(1) = mols.array(i).coords(1);
            coords(2) = mols.array(i).coords(2);
            valmat = GaussC(R,C,1, [ coords(1), coords(2) ], A);
            left = floor(coords(1))-size(R,1)/2; %blink position on surface
            right = floor(coords(1))+size(R,1)/2-1;
            top = floor(coords(2))-size(C,1)/2;
            bottom = floor(coords(2))+size(R,1)/2-1;    
            sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) = sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) + valmat; %update sensor
        end
    end
end

