classdef MolStore
    properties
        array
    end
    methods
        function obj = MolStore(mols)
            if nargin ~= 0
                m = size(mols,2);
                obj(m) = MolStore;
                for i = 1:m
                    obj(i).array = mols(i);
                end
            end
        end
        function coordinates = locations(obj)
            for i = 1:size(obj,2)
                coordinates(i,1) = obj(i).array.coords(1);
                coordinates(i,2) = obj(i).array.coords(2);
            end
        end
    end
end