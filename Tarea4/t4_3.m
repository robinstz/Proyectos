n = -50:50;
%parametros de x,y Y z
x = cos(pi*0.1*n);
y = cos(pi*0.9*n);
z = cos(pi*2.1*n);
%Grafica x(n)
subplot(311);
plot(n, x);
title('x[n]=cos(0.1\pin)');
grid;
%Grafica y(n)
subplot(312);
plot(n,y);
title('y[n]=cos(0.9\pin)');
grid;
%Grafica z(n)
subplot(313);
plot(n,z);
title('z[n]=cos(2.1\pin)');
xlabel('n');

