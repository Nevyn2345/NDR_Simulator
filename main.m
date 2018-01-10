%%%%%
%%% Value taken from the Dempsey paper for Alexa Fluor 647
equilibrium = 0.0005;
%%%
%%%%%

nframes = 4000;
nmols = 5000;
coords = CreatePattern(nmols);
coords(:,3) = 0;
coords(:,4) = 0;
coords(:,5) = 0;
camera_params.height = 140;
camera_params.width = 140;
zyla_rms = 1.38; %variation in zyla noise
zyla_floor = 100;
camera_params.NDR_floor = 3500;
camera_params.NDR_noiseInc = 10/100; % average noise increase per frame based on dark area, increased 20 counts over 100 frames
%4, for laser, 0.2 for edge region, 1.3 for non-laser
camera_params.NDR_rms = 2; % STDev of a single frame at the start of a reset
camera_params.reset = 100;

maxA = 100; %photons per blink, spread over many frames

zyla_camera = 0;
NDR_camera = 1;

if zyla_camera == 1
    [ sensor_zyla ] = Zyla( coords, sensorwidth, sensorheight, zyla_rms, zyla_floor, maxA, nframes, equilibrium );
end
if NDR_camera == 1
    [ sensor_NDR ] = NDR( camara_params, coords, nframes, maxA, equilibrium );
end
%%
% save data
sensor = uint16(sensor_NDR);
L = 1;
imwrite(sensor(:, :, 1), 'sensor.tiff');

for K=2:length(sensor(1, 1, :))
   imwrite(sensor(:, :, K), 'sensor.tiff','WriteMode', 'append');
end

