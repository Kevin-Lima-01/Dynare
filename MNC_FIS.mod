% Macro Avan I - Lista 2 (ex 2d) - mod - Bruna, Caio, Kevin e Marcos

close all;

%----------------------------------------------------------------
% Declarando as variáveis
%----------------------------------------------------------------

var y c k i r z tau g g_tilde;                                                                   % Variáveis endógenas
varexo e eg;                                                                               % Choques: produtividade e gastos do governo

parameters beta delta alpha rho theta rho_g sigma_g g_bar l;                               % parâmetros

%----------------------------------------------------------------
% Declarando os parâmetros
%----------------------------------------------------------------

alpha = 0.33;         % Participação do capital
beta = 0.99;          % Taxa de desconto
delta = 0.025;        % Depreciação
rho = 0.95;           % Persistência do choque de produtividade
theta = 0.007;        % Volatilidade choque produtividade
rho_g = 0.90;         % Persistência choque gastos governo
sigma_g = 0.01;       % Volatilidade choque gastos
g_bar   = log(0.2);
l       = 1;

%----------------------------------------------------------------
% O Modelo
%----------------------------------------------------------------

model;
    (1/c) = beta*(1/c(+1))*(1 + alpha*(k^(alpha-1))*exp(z(+1))*l^(1-alpha) - delta);				% escolha intertemporal do consumo
%  c/(1-l) = (1-alpha)*(k^alpha)*exp(z)*l^(-alpha);                     											  % escolha renda-lazer
    c + i + g = y;                                                                              % restrição orçamentária ok
    y = exp(z)*(k(-1)^alpha)*l^(1-alpha);                                                			      % função de produção
    i = k - (1-delta)*k(-1);                                                               			% equação de movimento do capital
    r = alpha*(y/k);                                                                      			% taxa de juros (CPO firma) ok
%w = (1-alpha)*(y/l)												% salário (CPO firma) ok
    z = rho*z(-1) + e;                                                                    			% processo estocástico da produtividade ok z=lnA
    g_tilde = rho_g*g_tilde(-1) + eg;
    g = exp(g_bar + g_tilde);
    tau = g;                                                                                    % Imposto lump-sum equilibra orçamento

end;

%----------------------------------------------------------------
% Valores Iniciais (Usualmente os de Steady-State)
%----------------------------------------------------------------
check;

initval;
  y = 1.2;            // Produção total
  c = 0.65;         // Consumo
  i = 0.15;         // Investimento
  k = 9.4;          // Capital
%1 = 0.33;         // Trabalho
  r = 0.0351;       // Taxa de juros real
  z = 0;            // Produtividade (log A)
  e = 0;            // Choque de produtividade
  eg = 0;           // Choque de gasto do governo
  g = 0.2;          // Gasto do governo
  tau = 0.2;        // Imposto lump sum (igual a g)
end;


shocks;
%var e = theta^2;
var eg = sigma_g^2;
end;

steady;
check;


stoch_simul(hp_filter = 1600, order = 1);

