var k A c l i y y_obs l_obs i_obs;
varexo e_a,e_y,e_i,e_l ;

parameters alp bet tet tau delt rho ;
alp = 0.4;
bet = 0.99;
tet = 0.357 ;
tau = 50 ;
delt = 0.02;
rho = 0.95;

model;
c = ((1 - alp)*tet/(1-tet))*A*(1-l)*((k(-1)/l)^alp) ;
y = A*(k(-1)^alp)*(l^(1-alp)) ;
i = y-c ;
k = (1-delt)*k(-1) + i ;
log(A) = rho*log(A(-1)) + e_a ;
(((c^(tet))*((1-l)^(1-tet)))^(1-tau))/c - bet*((((c(+1)^(tet))*((1-l(+1))^(1-tet)))^(1-tau))/c(+1))*(1 -delt+alp*(A(1)*(k^alp)*(l(1)^(1-alp)))/k)=0 ;
y_obs = y + e_y ;
l_obs = l + e_l ;
i_obs = i + e_i ;
end;

steady;

shocks;
var e_a; stderr 0.035;
var e_y; stderr 0.000158;
var e_l; stderr 0.00011;
var e_i; stderr 0.0000866;
end;

steady;


estimated_params;
alp, uniform_pdf,,, 0.0001, 1;
bet, uniform_pdf,,, 0.75, 0.999;
tet, uniform_pdf,,, 0.0001, 1;
tau, uniform_pdf,,, 0.0001, 100;
delt, uniform_pdf,,, 0.0001, 0.05;
rho, uniform_pdf,,, 0.0001, 0.999;
stderr e_a, uniform_pdf,,, 0.00001, 0.1;
stderr e_y, uniform_pdf,,, 0.00001, 0.1;
stderr e_l, uniform_pdf,,, 0.00001, 0.1;
stderr e_i, uniform_pdf,,, 0.00001, 0.1;
end;


estimated_params_init;
alp, 0.4;
bet, 0.99;
tet, 0.357 ;
tau, 3;
delt, 0.02;
rho, 0.95;
stderr e_a, .035;
stderr e_y, .000158;
stderr e_l, .0011;
stderr e_i, .000866;
end;


varobs y_obs l_obs i_obs;

options_.particle.status = 1;
options_.particle.algorithm = 'sequential_importance_particle_filter';
options_.particle.initialization = 1;
particle.number_of_particles = 500;

set_dynare_threads('local_state_space_iteration_2',2);

//estimation(datafile=data_benchmark,order=2,nobs=100,mh_replic=0,mode_compute=6);
//estimation(datafile=data_benchmark,order=2,nobs=100,mh_replic=0,mode_compute=8,mode_file=dsge_base_mode);
//estimation(datafile=data_benchmark,order=2,nobs=100,mh_replic=0,mode_compute=8,mode_file=dsge_base_mode);
estimation(datafile=data_benchmark,order=2,nobs=100,mh_replic=0,mode_compute=4,mode_file=dsge_base_mode,mode_check);