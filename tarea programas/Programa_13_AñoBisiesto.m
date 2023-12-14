pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

numero = input("Ingrese el año de nacimiento: ");

if rem(numero, 4) == 0 && (rem(numero, 100) ~= 0 || rem(numero, 400) == 0)
    fprintf("%d Si es un año bisiesto.\n", numero);
    insert_query = sprintf("INSERT INTO añobisiesto13 VALUES (%d, 'El año es bisiesto')", numero);
else
    fprintf("%d El año no es bisiesto.\n", numero);
    insert_query = sprintf("INSERT INTO añobisiesto13 VALUES (%d, 'No es año bisiesto')", numero);
end

pq_exec_params(conn, insert_query);

% Obtener los registros
result = pq_exec_params(conn, 'SELECT * FROM añobisiesto13;');

% Guardar los registros en un archivo llamado "registros13.txt"
fileID = fopen('registros13.txt', 'w');
fprintf(fileID, 'año: %d, mensaje: %s\n', numero, result.data{1,2});
fclose(fileID);

