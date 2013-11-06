function B = unique(A) % --*-- Unitary tests --*--

% Overloads the unique function for dates objects.
%
% INPUTS 
%  o A    dates object.
%
% OUTPUTS 
%  o B    dates object (a copy of A without repetitions).

% Copyright (C) 2012-2013 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

if ~isa(A,'dates')
    error(['dates::unique: Input argument ' inputname(1) ' has to be a dates object.'])
end

if A.ndat==1
    return
end

B = A;

[tmp,id,jd] = unique(A.time,'rows');
B.time = A.time(sort(id),:);
B.ndat = size(B.time,1);

%@test:1
%$ % Define some dates
%$ B1 = '1953Q4';
%$ B2 = '1950Q2';
%$ B3 = '1950q1';
%$ B4 = '1945Q3';
%$ B5 = '1950Q2'; 
%$
%$ % Define expected results.
%$ e.time = [1953 4; 1950 2; 1950 1; 1945 3];
%$ e.freq = 4;
%$ e.ndat = 4;
%$
%$ % Call the tested routine.
%$ d = dates(B1,B2,B3,B4,B5);
%$ d = d.unique;
%$ 
%$ % Check the results.
%$ t(1) = dyn_assert(d.time,e.time);
%$ t(2) = dyn_assert(d.freq,e.freq);
%$ t(3) = dyn_assert(d.ndat,e.ndat);
%$ T = all(t);
%@eof:1