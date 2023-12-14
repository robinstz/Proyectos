pkg load database % Cargar el paquete

function main()
    % Establecer la conexión a la base de datos
    conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

    % Solicitar al usuario un número
    numero = input('Ingrese un número: ');

    % Calcular la suma desde 0 hasta el número ingresado
    suma = sum(0:numero);

    % Mostrar la suma
    fprintf('La suma desde 0 hasta %d es: %d\n', numero, suma);

    % Insertar los datos en la tabla
    sql_insert = sprintf('INSERT INTO sumador6 (numero, suma) VALUES (%d, %d)', numero, suma);
    pq_exec_params(conn, sql_insert);

    % Generar el archivo registro6.txt
    generarArchivoRegistro(conn, numero, suma);

    % Cerrar la conexión
    pq_close(conn);

    fprintf('Los datos se han almacenado en la base de datos.\n');
end

function generarArchivoRegistro(conn, numero, suma)
    fileID = fopen('registro6.txt', 'a');  % Abre el archivo para agregar datos
    fprintf(fileID, 'Numero: %d, Suma: %d\n', numero, suma);
    fclose(fileID);
end

% Llamada a la función principal
main();

