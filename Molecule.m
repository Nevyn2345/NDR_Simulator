classdef Molecule
    properties
        on
        trajectory
        coords
        UID
    end
    methods
        function m = Molecule(nsteps,UID)
            on = 1;
            m.trajectory = zeros(nsteps,1);
            t = 0;
            for i = 1:nsteps
                num = rand();
                if t == 0
                    if num < 0.0005
                        m.trajectory(i) = 1;
                        t = 1;
                    end
                else
                    if num < 0.01
                        m.trajectory(i) = 0;
                        t = 0;
                    else
                        m.trajectory(i) = 1;
                    end
                end
            end
        end
    end
end