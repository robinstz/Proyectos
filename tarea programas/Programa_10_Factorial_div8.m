pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function main(conn)
    numero = input("Ingrese un número: ");

    if mod(numero, 7) == 0
        factorial = calcularFactorial(numero);
        fprintf("El factorial de %d es %d.\n", numero, factorial);
        insert_query = sprintf("INSERT INTO facato7div10 VALUES (%d, 'El factorial es %d')", numero, factorial);

    else
        fprintf("El número %d no es divisible entre 7.\n", numero);
        insert_query = sprintf("INSERT INTO facato7div10 VALUES (%d, 'El número %d no es divisible entre 7')", numero, numero);
    end

    pq_exec_params(conn, insert_query);

    % Llamamos a la función para generar el archivo registros10.txt
    generarArchivoRegistro(conn);
end

function factorial = calcularFactorial(numero)
    factorial = 1;
    for i = 1:numero
        factorial = factorial * i;
    end
end

function generarArchivoRegistro(conn)
    select_query = "SELECT * FROM facato7div10;";
    resultados_bd = pq_exec_params(conn, select_query);

    fileID = fopen('registros10.txt', 'a');
    fprintf(fileID, 'Número\tResultado\n');

    for i = 1:length(resultados_bd.data)
        fprintf(fileID, '%d\t%s\n', resultados_bd.data{i, 1}, resultados_bd.data{i, 2});
    end

    fclose(fileID);
end

% Llamamos a la función principal
main(conexion);

% Consultamos y mostramos los registros actuales en la base de datos
%select_query = "SELECT * FROM facato7div10;";
%resultados_bd = pq_exec_params(conexion, select_query);
%disp(resultados_bd);

% Consultamos y mostramos el contenido del archivo registros10.txt
%file_contents = fileread('registros10.txt');
%disp('Contenido de registros10.txt:');
%disp(file_contents);

