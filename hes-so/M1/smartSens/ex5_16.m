%% Exercice linearisation
clf; clear; clc;


%% Variables
V = 10; % V
C0 = 1e-11; % F
Cf = C0;
d0 = 1e-4; % m

xlim = 80e-6;

xi = linspace(-xlim, xlim, 9);

%% Linearisation par parties

% lignes de M: xi, E0i, clin,i, blin,i

E0i = 2*xi*d0*C0*V/Cf./(d0.^2 - xi.^2);

blin_i = xi;
clin_i = diff(xi)./diff(E0i);


Emax = max(E0i);
N = 100;
E0 = linspace(-Emax, Emax, N);

xlin = zeros(1,N);

for i=1:N

    index = find(E0i>E0(i),1)

    E = E0i(index);
    c = clin_i(index);
    b = blin_i(index);

    xlin(i) = (E0(index)-E).*c + b;
end


plot(E0i, xi, 'o'); hold on;
plot(E0, xlin);
hold off;
xlabel('E0i');
ylabel('xi [m]');
grid on;