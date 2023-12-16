pkg load database
pkg load io
pkg load statistics

function conn = conectar_bd()
    conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));
end

function ingresar_empresa(conn)
    try
        nombre = input('Ingrese el nombre de la empresa: ', 's');
        actividad = input('Ingrese la actividad de la empresa: ', 's');
        pais = input('Ingrese el país de la empresa: ', 's');
        cantidad_empleados = input('Ingrese la cantidad de empleados: ');

        % Insertar datos en la base de datos
        query = sprintf("INSERT INTO empresas8 (nombre, actividad, pais, cantidad_empleados) VALUES ('%s', '%s', '%s', %d);", nombre, actividad, pais, cantidad_empleados);
        pq_exec_params(conn, query);
        disp('Información de la empresa ingresada exitosamente.');
    catch
        disp('Ha ocurrido un error al ingresar la información de la empresa. Por favor, inténtelo nuevamente.');
    end
end

function visualizar_empresa(conn)
    try
        nombre_empresa = input('Ingrese el nombre de la empresa a visualizar: ', 's');

        % Consultar información de la empresa en la base de datos
        query = sprintf("SELECT * FROM empresas8 WHERE nombre = '%s';", nombre_empresa);
        result = pq_exec_params(conn, query);

        if isempty(result.data)
            disp('No se encontró información para la empresa especificada.');
        else
            disp(result.data);
        end
    catch
        disp('Ha ocurrido un error al visualizar la información de la empresa. Por favor, inténtelo nuevamente.');
    end
end

function mostrar_graficas(conn)
    % Consultar todos los datos de la tabla empresas8
    query = "SELECT * FROM empresas8;";
    result = pq_exec_params(conn, query);

    if isempty(result.data)
        disp('No hay datos para mostrar.');
    else
        % Extraer datos para graficar
        nombres_empresas = result.data(:, 1);
        cantidades_empleados_str = result.data(:, 4);

        % Convertir cantidades de empleados a números
        cantidades_empleados = str2double(cantidades_empleados_str);

        % Verificar si la conversión fue exitosa
        if any(isnan(cantidades_empleados))
            disp('Error al convertir cantidades de empleados a números.');
        else
            % Graficar
            figure;
            bar(cantidades_empleados);
            set(gca, 'XTickLabel', nombres_empresas, 'XTick', 1:numel(nombres_empresas));
            xlabel('Empresas');
            ylabel('Cantidad de Empleados');
            title('Cantidad de Empleados por Empresa');
            grid on;
        end
    end
end


% Programa principal
conn = conectar_bd();

while true
    fprintf('Menú:\n');
    fprintf('1. Ingresar información de la empresa\n');
    fprintf('2. Seleccionar una empresa para visualizar su información\n');
    fprintf('3. Mostrar gráficas de los datos ingresados\n');
    fprintf('4. Salir\n');

    opcion = input('Seleccione una opción: ');

    try
        switch opcion
            case 1
                ingresar_empresa(conn);
            case 2
                visualizar_empresa(conn);
            case 3
                mostrar_graficas(conn);
            case 4
                pq_close(conn);
                disp('¡Hasta luego!');
                return;
            otherwise
                disp('Opción no válida. Por favor, seleccione una opción válida.');
        end
    catch
        disp('Ha ocurrido un error inesperado. Por favor, inténtelo nuevamente.');
    end
end

