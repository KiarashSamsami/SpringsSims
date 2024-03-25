function E = spring_costfunc(x,k1,r0,l1,k2,l2)


% This assumes N masses that are all connected to each other forming a loop

xprev = [x(:,end),x(:,1:end-1)] ; 
xnext = [x(:,2:end),x(:,1)] ; 

xnext_diff = xnext-x ; 
xprev_diff = xprev-x ; 

xnext_diff_mag = sqrt(sum(xnext_diff.^2)) ; 
xprev_diff_mag = sqrt(sum(xprev_diff.^2)) ; 

E_forces_from_next = 1/2*k2*(xnext_diff_mag-l1).^2 ; 
E_forces_from_prev = 1/2*k2*(xprev_diff_mag-l1).^2 ; 



E = sum(E_forces_from_next) + sum(E_forces_from_prev) ; 


vnext = xnext_diff./xnext_diff_mag ; 
vprev = xprev_diff./xprev_diff_mag; 
tet = pi - acos(sum(vnext.*vprev)) ;
 

E_torques = 1/2*k2*tet.^2 ; 

E = E  + sum(E_torques); 