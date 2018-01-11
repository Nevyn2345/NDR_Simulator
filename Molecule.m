classdef Molecule
    properties
        trajectory
        coords
        UID
    end
    methods
        function m = Molecule(nsteps,UID)
            m.trajectory = zeros(nsteps,1);
            t = 0;
            for i = 1:nsteps
                num = rand();
                if t == 0
                    if num < 0.0005 %on prob
                        m.trajectory(i) = rand(1,1); %proportion of frame on
                        t = 1;
                    end
                else
                    if num < 0.01 %off prob
                        m.trajectory(i) = rand(1,1); %proportion of frame on
                        t = 0;
                    else
                        m.trajectory(i) = 1;
                    end
                end
            end
        end
    end
end