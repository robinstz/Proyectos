pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function calcularPromedioYGuardarRegistro(conn)
    % Pedir tres notas al usuario
    nota1 = input("Ingrese la primera nota: ");
    nota2 = input("Ingrese la segunda nota: ");
    nota3 = input("Ingrese la tercera nota: ");

    % Calcular el promedio de las notas
    promedio = (nota1 + nota2 + nota3) / 3;

    % Determinar si el promedio es mayor o igual a 60
    if promedio >= 60
        mensaje = "Aprobado";
    else
        mensaje = "Reprobado";
    end

    % Mostrar el mensaje y el promedio
    fprintf("El promedio es: %.2f\n", promedio);
    fprintf("Resultado: %s\n", mensaje);

    % Insertar en la base de datos
    insert_query = sprintf("INSERT INTO promedionotas12 VALUES (%d,%d,%d,%d,'%s')", nota1, nota2, nota3, promedio, mensaje);
    pq_exec_params(conn, insert_query);

    % Llamamos a la función para generar el archivo registros12.txt
    generarArchivoRegistro(conn, nota1, nota2, nota3, promedio, mensaje);
end


function verHistorial(conn)
    % Consultamos y mostramos los registros actuales en la base de datos
    select_query = "SELECT * FROM promedionotas12";
    resultados_bd = pq_exec_params(conn, select_query);

    fprintf('Historial en la base de datos:\n');
    %disp(resultados_bd.data);
end

function generarArchivoRegistro(conn, nota1, nota2, nota3, promedio, mensaje)
    select_query = "SELECT * FROM promedionotas12;";
    resultados_bd = pq_exec_params(conn, select_query);
    fileID = fopen('registros12.txt', 'a');
    fprintf(fileID, 'Nota1: %d, Nota2: %d, Nota3: %d, Promedio: %.2f, Mensaje: %s\n', nota1, nota2, nota3, promedio, mensaje);
    fclose(fileID);
end


% Menú principal
fprintf('Seleccione una opción:\n');
fprintf('1. Ingresar nuevas notas\n');
fprintf('2. Ver historial\n');
opcion = input('Ingrese el número de la opción seleccionada: ');

switch opcion
    case 1
        % Llamamos a la función para ingresar nuevas notas
        calcularPromedioYGuardarRegistro(conexion);
    case 2
        % Llamamos a la función para ver el historial
        verHistorial(conexion);
    otherwise
        fprintf('Opción no válida.\n');
end


