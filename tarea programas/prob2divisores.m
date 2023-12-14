pkg load database % Cargar el paquete

% Establecer la conexión a la base de datos con credenciales y detalles de la base de datos
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function main(conn) % Función principal, se pasa 'conn' como argumento
    % Solicitar al usuario ingresar un número
    numero = input("Ingrese un número: ");

    % Encontrar los divisores del número ingresado
    divisores = encontrarDivisores(numero);

    % Mostrar los divisores encontrados
    disp(["Los divisores de ", num2str(numero), " son: "]);
    disp(divisores);

    % Crear y ejecutar la consulta de inserción en la base de datos
    insert_query = sprintf("INSERT INTO divisores2 VALUES (%d, '[%s]\n');", numero, mat2str(divisores));
    pq_exec_params(conn, insert_query);

    % Realizar una consulta para obtener y mostrar todos los registros en la tabla
    select_query = "SELECT * FROM divisores2";
    result = pq_exec_params(conn, select_query);
   % disp(result);

    % Generar el archivo 'registros2.txt'
    generarArchivo(numero, divisores);
end

function divisores = encontrarDivisores(numero)
    % Encontrar los divisores de un número dado
    divisores = [];
    for divisor = 1:numero
        if mod(numero, divisor) == 0
            divisores = [divisores, divisor];
        end
    end
end

function generarArchivo(numero, divisores)
    % Generar el archivo 'registros2.txt'
    archivo = fopen('registros2.txt', 'a'); % 'a' para abrir en modo de añadir
    fprintf(archivo, 'Número: %d\n', numero);
    fprintf(archivo, 'Divisores: [%s]\n\n', mat2str(divisores));
    fclose(archivo);
end

% Llamamos a la función principal y pasamos 'conn'
main(conexion);

