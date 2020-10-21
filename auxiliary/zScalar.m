classdef zScalar < zFilter
    % Scalar Matrix in zFilter and its derivative (= zeros)
    %
    % Sebastian J. Schlecht, Sunday, 29 December 2019
    
    properties
        matrix
        matrixDer
        
    end
    
    methods
        function obj = zScalar(m, varargin)
            obj.parseArguments(varargin);
            
            assert(ismatrix(m),'Needs a matrix');
            
            obj.matrix = m;
            obj.matrixDer = zeros(size(m));
            obj.numberOfDelayUnits = 0;
            
        end
        
        function val = at_(obj,z)
            val = obj.matrix;
        end
        
        function val = der_(obj,z)
            val = obj.matrixDer;
        end
    end
end