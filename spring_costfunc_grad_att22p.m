function [dedx] = spring_costfunc_grad_att22p(r,x,l1,l2,k1,k2,grad_coef)



xprev = [x(:,end),x(:,1:end-1)] ; 
% xnext = [x(:,2:end),x(:,1)] ; 
delta_l = abs(vecnorm(x - xprev)-l2) ; 
max_delta_l = max(delta_l) ; 
x0 = x ; 

for i=1:size(x,2)
    x = x0 ; 
    x(1,i) = x(1,i)- grad_coef*max_delta_l ; 
    dedx_1_neg = spring_costfunc_att2e(x,k1,r,l1,k2,l2);
    
    x = x0 ; 
    x(1,i) = x(1,i)+ grad_coef*max_delta_l ; 
    dedx_1_pos = spring_costfunc_att2e(x,k1,r,l1,k2,l2);
    dedx_1(i) = (dedx_1_pos - dedx_1_neg)/ (2*grad_coef*max_delta_l) ; 
    
    x = x0 ; 
    x(2,i) = x(2,i)- grad_coef*max_delta_l ; 
    dedx_2_neg = spring_costfunc_att2e(x,k1,r,l1,k2,l2);
    
    x = x0 ; 
    x(2,i) = x(2,i)+ grad_coef*max_delta_l ; 
    dedx_2_pos = spring_costfunc_att2e(x,k1,r,l1,k2,l2);
    dedx_2(i) = (dedx_2_pos - dedx_2_neg)/ (2*grad_coef*max_delta_l) ; 
end

dedx = [dedx_1;dedx_2] ; 