% Modelo NK Básico

close all;

%----------------------------------------------------------------
% Declarando as variáveis
%----------------------------------------------------------------

var y y_bar pi i r_bar v a output_gap;  % Variáveis endógenas
varexo eps_v eps_a;                     % Choques exógenos

parameters beta phi_pi phi_y rho_v rho_a epsilon phi rho sigma kappa;

%----------------------------------------------------------------
% Declarando os parâmetros (mantidos os mesmos)
%----------------------------------------------------------------

beta    = 0.99;
phi_pi  = 1.5;
phi_y   = 0.5;
rho     = -log(beta);
rho_v   = 0.5;
rho_a   = 0.9;
phi     = 1;
sigma   = 1;
kappa   = 0.1;
epsilon = 6;

%----------------------------------------------------------------
% O Modelo
%----------------------------------------------------------------

model;
  output_gap = y - y_bar;  % Definindo explicitamente o output gap

  % Equações originais do modelo
  (y - y_bar) = (y(+1) - y_bar(+1)) - (1/sigma)*(i - pi(+1) - r_bar);
  pi = beta*pi(+1) + kappa*(y - y_bar);
  i = rho + phi_pi*pi + phi_y*(y - y_bar) + v;
  v = rho_v*v(-1) + eps_v;
  a = rho_a*a(-1) + eps_a;
  r_bar = -log(beta) + sigma*((1+phi)/(phi+sigma))*(a(+1)-a);
  y_bar = (1/(phi+sigma))*log((epsilon-1)/epsilon) + ((1+phi)/(phi+sigma))*a;
end;

%----------------------------------------------------------------
% Valores Iniciais
%----------------------------------------------------------------

initval;
  y = 0;
  y_bar = 0;
  pi = 0;
  i = rho;
  r_bar = rho;
  v = 0;
  a = 0;
  output_gap = 0;
end;

steady;
check;

shocks;
var eps_v = 0.01^2;
end;

%----------------------------------------------------------------
% Simulação com y_bar nos gráficos
%----------------------------------------------------------------

stoch_simul(irf=40, order=1) y y_bar pi i output_gap r_bar v;
