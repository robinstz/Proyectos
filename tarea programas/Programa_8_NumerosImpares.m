pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function mostrarNumerosImpares(conn)
    % Encontrar los números impares del 1 al 100
    impares = 1:2:100;

    % Convertir los números impares a texto y concatenarlos
    impares_texto = "";
    for i = 1:length(impares)
        impares_texto = [impares_texto, num2str(impares(i))];
        if i < length(impares)
            impares_texto = [impares_texto, ", "];
        end
    end

    % Mostrar los números impares concatenados como texto
    fprintf("Números impares del 1 al 100: %s\n", impares_texto);

    % Insertar en la base de datos
    insert_query = sprintf("INSERT INTO numerosimpares8 VALUES ('%s');", impares_texto);
    pq_exec_params(conn, insert_query);

    % Generar archivo registros8.txt
    fileID = fopen('registros8.txt', 'a');
    fprintf(fileID, '%s\n', impares_texto);
    fclose(fileID);

    % Consultar y mostrar los registros actuales en la base de datos
    select_query = sprintf("SELECT * FROM numerosimpares8;");
    resultados_bd = pq_exec_params(conn, select_query);
   % disp('Contenido de la base de datos:');
 %   disp(resultados_bd);

    % Consultar y mostrar el contenido del archivo registros8.txt
    file_contents = fileread('registros8.txt');
  %  disp('Contenido de registros8.txt:');
  %  disp(file_contents);

    % Contar el total de números impares
    total_impares = length(impares);
    fprintf("Total de números impares: %d\n", total_impares);
end

function mostrarHistorial(conn)
    % Consultar y mostrar los registros actuales en la base de datos
    select_query = sprintf("SELECT * FROM numerosimpares8;");
    resultados_bd = pq_exec_params(conn, select_query);
    disp('Historial en la base de datos:');
    disp(resultados_bd);
end

% Menú principal
fprintf('Seleccione una opción:\n');
fprintf('1. Mostrar números impares\n');
fprintf('2. Mostrar historial\n');
opcion = input('Ingrese el número de la opción seleccionada: ');

switch opcion
    case 1
        % Llamamos a la función para mostrar números impares
        mostrarNumerosImpares(conexion);
    case 2
        % Llamamos a la función para mostrar el historial
        mostrarHistorial(conexion);
    otherwise
        fprintf('Opción no válida.\n');
end

