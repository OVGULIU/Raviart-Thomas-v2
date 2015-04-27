function pdemesh(p,e,t)
% pdemesh(p,e,t)
%    plot pde mesh defined by p,e,t
%

nt=size(t,2);
x=[p(1,t(1,:));p(1,t(2,:));p(1,t(3,:));p(1,t(1,:))];
y=[p(2,t(1,:));p(2,t(2,:));p(2,t(3,:));p(2,t(1,:))];
plot(x,y,'b-')

if size(e,2)>0 % boundary edges
   x=[p(1,e(1,:));p(1,e(2,:))];
   y=[p(2,e(1,:));p(2,e(2,:))];
   line(x,y, 'Color','r'); 
end

