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

exportgraphics(gcf, 'grafico.pdf', 'ContentType', 'vector');
%%



  


  


