clear; clc; close all;

%% Paramètres
k = 1;                 % rigidité initiale
gamma_lock = 10;        % angle de verrouillage
p = 1;                 % exposant (>=1)

%% Domaine (évite la singularité)
gamma = linspace(0, 0.99*gamma_lock, 1000);

%% Energie de cisaillement
Psi = (k/2) .* gamma.^2 ./ (1 - gamma./gamma_lock).^p;

%% Contrainte de cisaillement (tau = dPsi/dgamma)
tau = k .* gamma ./ (1 - gamma./gamma_lock).^p + ...
      (k*p/2) .* gamma.^2 ./ gamma_lock ./ (1 - gamma./gamma_lock).^(p+1);

%% Rigidité tangentielle (dtau/dgamma)
Kt = k ./ (1 - gamma./gamma_lock).^p + ...
     (k*p .* gamma) ./ gamma_lock ./ (1 - gamma./gamma_lock).^(p+1) + ...
     (k*p*(p+1)/2) .* gamma.^2 ./ gamma_lock.^2 ./ (1 - gamma./gamma_lock).^(p+2);

%% Tracés
figure;

subplot(3,1,1)
plot(gamma, Psi, 'LineWidth', 2)
ylabel('\Psi(\gamma)')
title('Énergie de cisaillement')
grid on

subplot(3,1,2)
plot(gamma, tau, 'LineWidth', 2)
ylabel('\tau(\gamma)')
title('Contrainte de cisaillement')
grid on

subplot(3,1,3)
plot(gamma, Kt, 'LineWidth', 2)
xlabel('\gamma')
ylabel('d\tau/d\gamma')
title('Rigidité tangentielle')
grid on