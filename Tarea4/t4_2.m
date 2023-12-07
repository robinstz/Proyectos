n=-1000:1000;
x=exp(j*2*pi*0.01*n);
y=exp(j*2*pi*2.01*n);
hold
figure;
subplot (2,1,1);
plot(n, real(x)) ;
subplot (2,1,2);
plot(n,real(y),'r');
