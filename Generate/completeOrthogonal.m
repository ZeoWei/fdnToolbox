function [b,c,d,X] = completeOrthogonal(A, numIO, varargin)
% Solve orthogonal completion problem for A such that X = [A,b;c,d] is
% orthogonal, where d is of size numIO x numIO. The singular values of A
% are 1 except for numIO which are less than 1.
%
% see "Allpass Feedback Delay Networks" by Sebastian J. Schlecht
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    A - Feedback matrix of size NxN
%    numIO - Number of input/output channels
%
% Outputs:
%    b - Input gains of size NxnumIO
%    c - Output gains of size numIOxN
%    d - Direct gains of size numIOxnumIO
%    X - System matrix with X = [A,b;c,d]
%
% Example: 
%    [b,c,d,X] = completeOrthogonal([0.9 0.2; -0.4336 0.5], 1)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2
% Author: Dr.-Ing. Sebastian Jiro Schlecht, 
% Aalto University, Finland
% email address: sebastian.schlecht@aalto.fi
% Website: sebastianjiroschlecht.com
% 16. June 2020; Last revision: 16. June 2020

% TODO check names

%% Input parser
p = inputParser;
p.addParameter('verbose', false, @(x) islogical(x));
parse(p,varargin{:});

verbose = p.Results.verbose;

N = size(A,1);

%% construct b and c from low-rank approximation
[U,S,~] = svds(eye(N) - A*A',numIO);
b = U*sqrt(S);

[~,S,V] = svds(eye(N) - A'*A,numIO);
c = (V * sqrt(S))';

d = - b\A*c';

X = [A, b; c d];

%% verify
if verbose
eye(N) - A'*A - c'*c
eye(N) - A*A' - b*b'
c*c' + d*d' - eye(numIO)
X*X' - eye(size(X))
end