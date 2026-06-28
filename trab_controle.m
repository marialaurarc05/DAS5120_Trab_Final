%% Parâmetros
Km = 1/3;
L = 0.5;
R = 10;
B = 0.1;
J= 1;
%%

%-----------------QUESTÃO 1------------------------------
% Valores de Operação
i = -3:3;
Tc = -2:2;
Tm = zeros(size(i));

% Calculando Tm
for k = 1:length(i)
    if i(k) >= 0
        Tm(k) = 5.26*(1 - exp(-i(k)));
    else 
        Tm(k) = -5.26*(1 - exp(i(k)));
    end
end

% Calculando V e w
subplot(1,2,2)
hold on

for j = 1:length(Tc)
    w = (Tm - Tc(j))/B;
    V = R*i + Km*w;
    plot(w,V,'LineWidth',2)
end

grid on
title('Tensão x Velocidade')
xlabel('Velocidade Angular: \omega (rad/s)')
ylabel('Tensão: V (V)')
legend('T_c=-2','T_c=-1','T_c=0','T_c=1','T_c=2','Location','best')

% Plot Torque mecânico x Corrente
subplot(1,2,1)

plot(i, Tm, 'b', 'LineWidth', 2);
grid on;
title('Torque Mecânico x Corrente');
xlabel('Corrente i (A)');
ylabel('Torque T_m (Nm)');

%%

Ts = 1;
tau_f = 2;       % tau_f >= 2*Ts obrigatoriamente
Hd_s = tf([1 0],[tau_f 1]);
Hd_z = c2d(Hd_s, Ts, 'tustin')
  

Km = 1/3; R = 10; B = 0.1;

Tm = @(i) 5.26*(1-exp(-i));  % para i>0

% Equilíbrio: R*i0 = V0 - Km*w0  e  B*w0 = Tm(i0) - Tc0
V0 = 10; Tc0 = 1;
f = @(x) [R*x(1) - (V0 - Km*x(2)); ...
           B*x(2) - (Tm(x(1)) - Tc0)];
sol = fsolve(f, [0.5, 5]);
fprintf('i0 = %.4f A,  w0 = %.4f rad/s\n', sol(1), sol(2));

%%
%-----------------QUESTÃO 2------------------------------
% Plot questão 2

figure(1)
plot(out.corrente.Time, out.corrente.Data, 'LineWidth', 1.5)
grid on
xlim([0 125])
xlabel('Tempo (s)')
ylabel('Corrente (A)')
title('Corrente no Ponto de Operação')

% Gráfico da Velocidade
figure(2)
plot(out.velocidade.Time, out.velocidade.Data, 'r', 'LineWidth', 1.5)
grid on
xlim([0 125])
xlabel('Tempo (s)')
ylabel('Velocidade angular (rad/s)')
title('Velocidade Angular no Ponto de Operação')
