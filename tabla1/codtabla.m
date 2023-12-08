%creacion de tabla de IVA

pkg load database
conn = pq_connect(setdbopts('dbname', 'tabla1', 'host','localhost','port','5432','user','postgres','password','1234'));

precio= input("ingrese el precio de su producto: Q")
IVA = precio * 0.12;
precio_sin_iva = precio - IVA;
fprintf("El precio sin IVA es de Q%0.0f, el IVA es de Q%0.0f\n", precio_sin_iva,IVA)



try
  Ins1 = 'insert into tb1 (precio) values(';
  Ins2 = ");";
  Instruccion = strcat(Ins1,num2str(precio),Ins2);
  Registro = pq_exec_params(conn, Instruccion);

  catch e
  disp(['Error durante la conexión a la DB, Consulte el error : ' e.message]);
  end
