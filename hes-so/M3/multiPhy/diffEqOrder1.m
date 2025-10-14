%% Approximate a differential equation order 1
clc; clear; close all;

% disable copilot:
% settings.matlab.desktop.copilot.CopilotEnabled.PersonalValue = false in
% command prompt


%% Function

% u'(x) + u(x) = f(x)

f = 0;

% domain
a = 0;
b = 5;

% nb of points
% taking N=3 shows that the explicit scheme starts to oscillate
N = 10;

% step (constant)
h = (b - a) / N;

% inital condition
u0 = 3;


%% approximate solution of the differential equation

% explicit scheme
u_explicit(1) = u0;

for n=1:N
    u_explicit(n+1) = f*h + u_explicit(n)*(1-h);
end


% implicit scheme
u_implicit(1) = u0;
for n = 1:N
    u_implicit(n+1) = (u_implicit(n) + f*h) / (1 + h);
end

%% plot solution
x = a:h:b;

% true solution

u_exact = 3*exp(-x);

figure()
plot(x,u_exact)
hold on;
plot(x, u_explicit)
plot(x, u_implicit)
hold off;
xlabel('x');
ylabel('u(x)');
legend('Exact Solution', 'Explicit scheme', 'Implicit scheme');
grid on;



