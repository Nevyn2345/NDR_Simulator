function [ sensor ] = NDR( sensorwidth, sensorheight, coords, nframes, maxA, NDR_noiseInc, NDR_floor, NDR_rms, equilibrium, reset )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
sensor = round((randn(sensorwidth, sensorheight)*NDR_rms)+NDR_floor);
[R,C] = ndgrid(1:11, 1:11);
reset_tracker = 1;

for j = 1:nframes
    %update sensor noise
    if reset_tracker == reset
        sensor(:,:,j+1) = round((randn(sensorwidth, sensorheight)*NDR_rms)+NDR_floor);
        reset_tracker = 1;
    else
        sensor(:,:,j+1) = sensor(:,:,j) + round((randn(sensorwidth, sensorheight)*NDR_rms+NDR_noiseInc));
        reset_tracker = reset_tracker+1;
    end
    
    %add blinks
    %coords(:,1) = x
    %coords(:,2) = y
    %coords(:,3) = empty
    %coords(:,4) = length of time left on (in frames)
    %coords(:,5) = total length of event (in frames)
    
    for i = 1:size(coords,1)
        num_frames_on = coords(i,4); % if on = life left of blink
        tot_num_frames_on = coords(i,5); % total blink life
        if num_frames_on > 0; % if fluorophore is on
            if num_frames_on > 1 % if on for longer than one frame
                frame_dur = 1; % set scale for frame
            else % if on for less than one frame
                frame_dur = num_frames_on; % set equal to life left
                num_frames_on = 0; % set fluorophore to off
            end
            A = frame_dur * (maxA / tot_num_frames_on); % scale blink to maxA and life
            num_frames_on = num_frames_on-frame_dur; % update life
            coords(i,4) = num_frames_on;
            valmat = GaussC(R,C,1, [coords(i,1), coords(i,2)], A); % caluclate blink
            left = floor(coords(i,1))-size(R,1)/2; %blink position on surface
            right = floor(coords(i,1))+size(R,1)/2-1;
            top = floor(coords(i,2))-size(C,1)/2;
            bottom = floor(coords(i,2))+size(R,1)/2-1;
            sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) = sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) + valmat; %update sensor
        elseif rand < equilibrium % if blink off but turning on
            onpoint = rand(); % turning on point in frame
            tot_num_frames_on = randn()+12; % life of fluorophore in frames (currently midpoint = 12)
            A = (1 - onpoint)*maxA/tot_num_frames_on; %scale A for time in frame left
            num_frames_on = tot_num_frames_on-onpoint; % amount of life left
            coords(i,4) = num_frames_on; %update storage
            coords(i,5) = tot_num_frames_on;%update storage
            valmat = GaussC(R,C,1, [coords(i,1), coords(i,2)], A); %calculate blink
            left = floor(coords(i,1))-size(R,1)/2; % blink position on sensor
            right = floor(coords(i,1))+size(R,1)/2-1;
            top = floor(coords(i,2))-size(C,1)/2;
            bottom = floor(coords(i,2))+size(R,1)/2-1;
            sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) = sensor(uint16(left):uint16(right), uint16(top):uint16(bottom),j+1) + valmat; %position on sensor
        end
    end
end
end

