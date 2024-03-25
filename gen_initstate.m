function [r1,x] = gen_initstate()

nh1 = [1;0] ; 
nh2 = [0;1] ; 

d = linspace(0.2,5,10) ; 
l1 = [0;0]+d.*nh1 ; 
l2 = l1(:,end) + d.*nh2 ; 
l3 = l1(:,end:-1:1) + [0;l2(2,end)] ;
l4 = l2(:,end:-1:1) + [l1(1,1);0] - + [l2(1,1);0] ; 
edges = [l1,l2,l3,l4] +2 ; 
r1 = edges;

l1x = [0;0.3]+0.9*d.*nh1 ;
l2x = l1x(:,end) + 0.9*d.*nh2 ;
l3x = l1x(:,end:-1:1) + [0;l2x(2,end)] ;
l4x = l2x(:,end:-1:1) + [l1x(1,1);0] - + [l2x(1,1);0] ; 


figure;plot(l1x(1,:),l1x(2,:),'.');hold on;
plot(l2x(1,:),l2x(2,:),'o');
plot(l3x(1,:),l3x(2,:),'d');
plot(l4x(1,:),l4x(2,:),'s');
x = [l1x,l2x,l3x,l4x]*0.5 + [3.5;3.5] ; 
%  x = l1x(:,1:6)
 figure;plot(r1(1,:),r1(2,:),'.');axis equal;hold on;plot(x(1,:),x(2,:),'.')