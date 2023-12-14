pkg load database % Cargar el paquete
global conn;  % Declarar 'conn' como una variable global
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function main()
    global conn;  % Indicar que 'conn' es global dentro de esta función
    numeroInicio = input("Ingrese el número de inicio: ");
    numeroFin = input("Ingrese el número de fin: ");

    if numeroInicio > numeroFin
        disp("El número de inicio debe ser menor o igual al número de fin.");
        return;
    end

    numerosPares = encontrarNumerosPares(numeroInicio, numeroFin);

    disp(["Los números de 2 en 2 desde ", num2str(numeroInicio), " hasta ", num2str(numeroFin), " son: "]);
    disp(numerosPares);

    insert_query = sprintf("INSERT INTO numerospares3 VALUES (%d,%d, '%s');", numeroInicio, numeroFin, mat2str(numerosPares));
    pq_exec_params(conn, insert_query);

    % Guardar los registros en un archivo de texto (sobrescribir)
    guardarRegistrosEnArchivo('registros3.txt', numeroInicio, numeroFin, numerosPares);

    insert_query = "SELECT * FROM numerospares3";
    result = pq_exec_params(conn, insert_query);
   % disp(result);
end

function numerosPares = encontrarNumerosPares(inicio, fin)
    numerosPares = [];
    for numero = inicio:2:fin
        numerosPares = [numerosPares, numero];
    end
end

function guardarRegistrosEnArchivo(nombreArchivo, inicio, fin, numerosPares)
    % Abrir el archivo en modo de escritura (sobrescribir), creándolo si no existe
    fid = fopen(nombreArchivo, 'a');

    % Verificar si se pudo abrir el archivo
    if fid == -1
        disp('Error al abrir el archivo para escribir.');
        return;
    end

    % Obtener la fecha y hora actual para incluir en el registro
    fechaHora = datestr(now, 'yyyy-mm-dd HH:MM:SS');

    % Escribir la información en el archivo
    fprintf(fid, 'Registros del %d al %d generados el %s:\n', inicio, fin, fechaHora);
    fprintf(fid, 'Números pares: %s\n', mat2str(numerosPares));
    fprintf(fid, '\n');

    % Cerrar el archivo
    fclose(fid);
end

% Llamamos a la función principal
main();

