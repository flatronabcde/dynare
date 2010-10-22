function [r, g1] = block_bytecode_mfs_steadystate(y, b)
% Wrapper around the *_static.m file, for use with dynare_solve,
% when block_mfs option is given to steady.

% Copyright (C) 2009 Dynare Team
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

global M_ oo_
ss = oo_.steady_state;
indx = M_.blocksMFS{b};
ss(indx) = y;
x = [oo_.exo_steady_state; oo_.exo_det_steady_state];
eval(['[chk, r, g1] = bytecode( ss, x, M_.params, 1, ss, ''evaluate'', ''static'', ''block = ' int2str(b) ''');']);