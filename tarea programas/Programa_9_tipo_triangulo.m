pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function main(conn)
    historialResultados = [];

    while true
        lado1 = input("Ingrese el primer lado del triángulo: ");
        lado2 = input("Ingrese el segundo lado del triángulo: ");
        lado3 = input("Ingrese el tercer lado del triángulo: ");

        tipoTriangulo = determinarTipoTriangulo(lado1, lado2, lado3);

        resultado = struct("lado1", lado1, "lado2", lado2, "lado3", lado3, "tipo", tipoTriangulo);
        historialResultados = [historialResultados, resultado];

        disp(["El triángulo con lados ", num2str(lado1), ", ", num2str(lado2), " y ", num2str(lado3), " es de tipo: ", tipoTriangulo]);

        opcion = input("Desea ver el historial de resultados (s/n): ", "s");
        if strcmp(opcion, "s")
            dispHistorial(historialResultados);
        end

        insert_query = sprintf("INSERT INTO triangulo9 VALUES (%d,%d,%d, '%s');", lado1, lado2, lado3, tipoTriangulo);
        pq_exec_params(conn, insert_query);

        opcionContinuar = input("Desea continuar (s/n): ", "s");
        if ~strcmp(opcionContinuar, "s")
            break;
        end
    end

    % Llamamos a la función para generar el archivo registros9.txt
    generarArchivoRegistro(historialResultados);
end

function tipoTriangulo = determinarTipoTriangulo(lado1, lado2, lado3)
    if lado1 == lado2 && lado2 == lado3
        tipoTriangulo = "Equilátero";
    elseif lado1 == lado2 || lado1 == lado3 || lado2 == lado3
        tipoTriangulo = "Isósceles";
    else
        tipoTriangulo = "Escaleno";
    end
end

function dispHistorial(historial)
    disp("Historial de resultados:");
    for i = 1:length(historial)
        disp(["Resultado ", num2str(i)]);
        disp(["Lados: ", num2str(historial(i).lado1), ", ", num2str(historial(i).lado2), ", ", num2str(historial(i).lado3)]);
        disp(["Tipo de triángulo: ", historial(i).tipo]);
    end
end

function generarArchivoRegistro(historial)
    fileID = fopen('registros9.txt', 'a');
    fprintf(fileID, 'Historial de resultados:\n');
    for i = 1:length(historial)
        fprintf(fileID, 'Resultado %d\n', i);
        fprintf(fileID, 'Lados: %d, %d, %d\n', historial(i).lado1, historial(i).lado2, historial(i).lado3);
        fprintf(fileID, 'Tipo de triángulo: %s\n\n', historial(i).tipo);
    end
    fclose(fileID);
end

% Llamamos a la función principal
main(conexion);

% Consultamos y mostramos los registros actuales en la base de datos
select_query = "SELECT * FROM triangulo9;";
resultados_bd = pq_exec_params(conexion, select_query);
%disp(resultados_bd);

% Consultamos y mostramos el contenido del archivo registros9.txt
%file_contents = fileread('registros9.txt');
%disp('Contenido de registros9.txt:');
%disp(file_contents);

