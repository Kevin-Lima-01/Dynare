% Macro Avan I - Lista 2 (ex 1b) - Bruna, Caio, Kevin e Marcos

close all;

%----------------------------------------------------------------
% Declarando as variáveis
%----------------------------------------------------------------

var y c k i l r z;                                                                       % variáveis endógenas
varexo e;                                                                                  % variáveis exógenas

parameters beta delta alpha rho theta sigma psi;                                                     % parâmetros

%----------------------------------------------------------------
% Declarando os parâmetros
%----------------------------------------------------------------

alpha   = 0.33;                                                                          % capital-share
beta    = 0.99;                                                                          % taxa de desconto temporal
delta   = 0.025;                                                                         % depreciação
psi    = 1;                                                                          % parâmetro de utilidade do lazer
rho     = 0.95;                                                                          % AR(1) da produtividade
theta   = (0.000010299)^(1/2);                                                           % desvio-padrão do choque de produtividade
sigma   = 1.5;										 % coeficiente de aversão relativa ao risco (da utilidade)

%----------------------------------------------------------------
% O Modelo
%----------------------------------------------------------------

model;
  1 = beta * ((c(+1)^(-sigma)) * ((1-l(+1))^(1-sigma))/(c^(-sigma) * (1-l)^(1-sigma))) * (1+alpha * exp(z(+1)) * k^(alpha-1) * l(+1)^(1-alpha)-delta);       % escolha intertemporal do consumo ok
  psi*c/(1-l) = (1-alpha)*((exp(z))*(k(-1)^alpha)*l^(-alpha));               											% escolha renda-lazer ok
  c+i = y;                                                                              			% restrição orçamentária ok
  y = (exp(z))*(k(-1)^alpha)*l^(1-alpha);                                                   			% função de produção ok
  i = k-(1-delta)*k(-1);                                                                			% equação de movimento do capital ok
  r = (alpha)*(y/k);                                                                        			% taxa de juros (CPO firma) ok
  %w = (1-alpha)*(y/l);												% salário (CPO firma) ok
  z = rho*z(-1)+e;                                                                      			% processo estocástico da produtividade ok z=lnA
end;

%----------------------------------------------------------------
% Valores Iniciais (Usualmente os de Steady-State)
%----------------------------------------------------------------

initval;
  y = 1.2353;      % produção inicial
  k = 12.6695;     % capital inicial
  c = 0.9186;      % consumo inicial
  l = 0.33;        % horas trabalhadas iniciais
  i = 0.316738;    % investimento inicial
  z = 0;           % produtividade inicial
  e = 0;           % choque inicial
  r = 0.0351;      % juros iniciais'
  %w = 2.01;	   % salário inicial

end;


shocks;
var e = theta^2;
end;

steady;

stoch_simul(hp_filter = 1600, order = 1);

