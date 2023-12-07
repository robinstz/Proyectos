t=-0.04:0.001:0.04;
x=20*exp(j*(80*pi*t-0.4*pi));

% grafico en 3d
subplot(2,2,1);
plot3(t,real(x), imag(x));grid
title('20*e^{j*(80\pit-0.4\pi)}')
xlabel('Tiempo,s');ylabel('Real');zlabel('Imag')
% grafico de 2d
subplot(2,2,2);
plot(t, real(x), 'b');hold on
plot(t, imag(x), 'r');grid
title('rojo-Componente Imaginario,Azul-Componente Real de la Exponencial')
xlabel('Tiempo');ylabel('Amplitud')

