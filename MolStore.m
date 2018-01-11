classdef MolStore
    properties
        array = [];
    end
    methods
        function obj = MolStore(nmols,nframes)
            obj = obj.CreateMolStore(nmols,nframes);
        end
        function obj = CreateMolStore(obj, N, nframes)
            for i = 1:N
                if ~isempty(obj.array)
                    obj.array(end+1) = Molecule(nframes,i);
                else
                    obj.array = Molecule(nframes,i);
                end
            end
        end
        function coordinates = locations(obj)
            for i = 1:size(obj.array,2)
                coordinates(i,1) = obj.array(i).coords(1);
                coordinates(i,2) = obj.array(i).coords(2)
            end
        end
        function obj = gencoords(obj)
            width = 1.5;
            period = 10;
            for i = 1:size(obj.array,2)
                found = 0;
                while found == 0
                    randx = 100*rand + 10;
                    randy = 100*rand + 10;
                    xperiod = floor(randx/period);
                    if (randx/period)-xperiod < width/10
                        obj.array(i).coords(1) = randx;
                        obj.array(i).coords(2) = randy;
                        found = 1;
                    end
                end
            end
        end
    end
end