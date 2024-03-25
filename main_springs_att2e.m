clear
close all
clc

k1 = 1 ; 
k2 = 1 ; 
l1 = 2 ; 
l2 = 2 ; 





% Generate initial state:
[r,x] = gen_initstate()

r = (0.5+linspace(1,5,10)).*[cos(linspace(0,2*pi,10));sin(linspace(0,2*pi,10))]
x = [linspace(0,4,40);-6+zeros(1,40)]; 
x  =2*r
figure;plot(r(1,:),r(2,:),'s-');axis equal; hold on;plot(x(1,:),x(2,:),'o-')


% make a convergence loop
E = spring_costfunc_att2e(x,k1,r,l1,k2,l2)
counter = 1 ; 
alpha = 1e-4 ; 
grad_coef = 1e-4 ; 

counter_tot = [] ; 
figure;
% tic
while counter<1e6
%     tic
    %Compute gradient of E:        
    [dedx] = spring_costfunc_grad_att2e(r,x,l1,l2,k1,k2,grad_coef) ;
    % update x
    x = x - alpha* dedx ; 
    % compute E using the updated x
    E(counter+1) = spring_costfunc_att2e(x,k1,r,l1,k2,l2) ;
    counter = counter + 1 ;
    dE(counter) = (E(counter)-E(counter-1))/E(counter-1) ;
%     if  -dE(counter)<1e-6
%         break
%         error('cost func')
%     end
    
    if rem(counter,1e3)==1
%         toc
%         error('hi')
        xplot((counter-1)/1e3).data = x ;
        counter_tot = [counter_tot,counter]
        xplot((counter-1)/1e3).counter = counter_tot ; 
        
    end
    % plot E
%     drawnow
%     subplot(1,2,1)
%     plot(1:counter,E(1:counter),'o-')
%     subplot(1,2,2)
%     plot(x(1,:),x(2,:),'ks-');axis equal
%     toc
end

% save('free_springs_att2e.mat')
subplot(1,2,1)
plot(1:100:counter,E(1:100:counter),'o-')
subplot(1,2,2)
plot(x(1,:),x(2,:),'ks-');axis equal
hold on
plot(r(1,:),r(2,:),'r.')

figure;plot(dE,'o-')

%%
close all
clc
figure

for i=1:1:size(xplot,2)
    drawnow
    xx = xplot(i).data ; 
    plot(r(1,:),r(2,:),'r.')
    hold on
    plot(xx(1,:),xx(2,:),'ks-');axis equal
    for j=1:size(r,2)
        plot([r(1,j),xx(1,j)],[r(2,j),xx(2,j)],'b')
    end
    xlim([min(r(1,:))-5,max(r(1,:))+5])
    ylim([-5,15])
    hold off
end
%%
E_diff = diff(E)./E(1:end-1) ; 
figure;plot(-(E_diff),'.')
%%


k1 = 1 ;
l1 = 0.5 ; 
l2 = 0.2 ; 
k2 = 1 ; 

% hl_coords ; 
% hl1_coords ; 
% r = hl_coords_1' ; 
% x = hl_coords_2' ; 
 figure;plot(r1(1,:),r1(2,:),'.');axis equal;hold on;plot(x(1,:),x(2,:),'.')
 


% for i=1:50
%     i
%     x0 = minimize_E_test_forces(x,k1,k2,r1,l1,l2);
%     x = x0 ; 
%     drawnow
%     plot(r1(1,:),r1(2,:),'.');axis equal;hold on;plot(x(1,:),x(2,:),'.')
%     plot(x0(1,:),x0(2,:),'o-')
%     hold off
% end
% 
% figure;plot(r1(1,:),r1(2,:),'.');axis equal;hold on;plot(x(1,:),x(2,:),'.')
% 
% plot(x0(1,:),x0(2,:),'o-')

fun_tail = @(x)minimize_E_test(x,k1,r1,l1,k2,l2)    
% fun_tail = @(x)minimize_E_test_singlelopp(x,k1,r1,l1,k2,l2);

% ,'PlotFcns',@optimplotfval
options_tail = optimset('MaxFunEvals',1e6,'MaxIter',1e6,'TolFun',1e-6,'TolX',1e-6);
[bestx,fval] = fminsearch(fun_tail,x,options_tail) ;
figure;plot(r1(1,:),r1(2,:),'o-');axis equal;hold on;
figure;plot(x(1,:),x(2,:),'s-');hold on;plot(bestx(1,:),bestx(2,:),'o-');axis equal
%%

fun_tail = @(x)minimize_E_test_singlelopp(x,k1,r1,l1,k2,l2);
options_tail = optimset('MaxFunEvals',1e12,'MaxIter',1e12,'TolFun',1e-12,'TolX',1e-12 );
[bestx,fval] = fminsearch(fun_tail,x,options_tail) ;
figure;plot(r1(1,:),r1(2,:),'o-');axis equal;hold on;
plot(bestx(1,:),bestx(2,:),'o-')