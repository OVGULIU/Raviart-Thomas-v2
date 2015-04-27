function [ eval ] = u_0( point )
%U_0 Summary of this function goes here
%   Detailed explanation goes here
    const = 2/3;
    r = sqrt(point(1)^2 +  point(2)^2);
    phi = atan(point(2)/point(1));
	eval =r^const * sin(const*phi);
end

