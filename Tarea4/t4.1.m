t=-0.04:0.001:0.04;
x=20*exp(j*(80*pi*t-0.4*pi));
plot3(t,real(x), img(x));grid
title('20*e^{j*(80\pit-0.4\pi)}')
xlabel('Tiempo,s');ylabel('Real');zlabel('Imag')
plot(t, real(x), 'b');hold on
plot(t, imag(x), 'r');grid
title('rojo-Componente Imaginario,Azul-Componente Real de la Exponencial')
xlabel('Tiempo');ylabel('Amplitud')

