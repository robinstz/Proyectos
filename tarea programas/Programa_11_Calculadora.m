pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function [figura, areaTexto, resultado] = calcularAreas(opcion)
    disp("Calculadora de Áreas");
    disp("1. Círculo");
    disp("2. Triángulo");
    disp("3. Cuadrado");
    disp("4. Rectángulo");

    figura = "";
    areaTexto = "";

    switch opcion
        case 1
            figura = "Círculo";
            radio = input("Ingrese el radio del círculo: ");
            area = pi * radio^2;
            areaTexto = ["Radio: " num2str(radio)];
        case 2
            figura = "Triángulo";
            base = input("Ingrese la base del triángulo: ");
            altura = input("Ingrese la altura del triángulo: ");
            area = 0.5 * base * altura;
            areaTexto = ["Base: " num2str(base) ", Altura: " num2str(altura)];
        case 3
            figura = "Cuadrado";
            lado = input("Ingrese el lado del cuadrado: ");
            area = lado^2;
            areaTexto = ["Lado: " num2str(lado)];
        case 4
            figura = "Rectángulo";
            base = input("Ingrese la base del rectángulo: ");
            altura = input("Ingrese la altura del rectángulo: ");
            area = base * altura;
            areaTexto = ["Base: " num2str(base) ", Altura: " num2str(altura)];
        otherwise
            disp("Opción no válida.");
            return;
    end

    resultado = ["Área: " num2str(area)];

    disp(["Figura: " figura]);
    disp(areaTexto);
    disp(resultado);
end

function generarArchivoRegistro(conn)
    select_query = "SELECT * FROM calculadora11;";
    resultados_bd = pq_exec_params(conn, select_query);

    fileID = fopen('registros11.txt', 'a');
    fprintf(fileID, 'Figura\tÁrea\tResultado\n');

    for i = 1:length(resultados_bd.data)
        fprintf(fileID, '%s\t%s\t%s\n', resultados_bd.data{i, 1}, resultados_bd.data{i, 2}, resultados_bd.data{i, 3});
    end

    fclose(fileID);
end

% Mostrar opciones y solicitar la opción al usuario
disp("Opciones de figuras geométricas:");
disp("1. Círculo");
disp("2. Triángulo");
disp("3. Cuadrado");
disp("4. Rectángulo");

opcion = input("Elija una figura (1-4): ");
[figura, areaTexto, resultado] = calcularAreas(opcion);

insert_query = sprintf("INSERT INTO calculadora11 VALUES ('%s','%s', '%s');", figura, areaTexto, resultado);
pq_exec_params(conn, insert_query);

% Llamamos a la función para generar el archivo registros11.txt
generarArchivoRegistro(conn);

% Consultamos y mostramos los registros actuales en la base de datos
%insert_query = "SELECT * FROM calculadora11";
%pq_exec_params(conn, insert_query);

% Consultamos y mostramos el contenido del archivo registros11.txt
%file_contents = fileread('registros11.txt');
%disp('Contenido de registros11.txt:');
%disp(file_contents);

