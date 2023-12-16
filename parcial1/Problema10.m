pkg load database

% Establecer la conexión a la base de datos
conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));

while true
    disp("-------- Menú de Planificación de Producción --------");
    % Mostrar menú
    disp("1. Agregar producto");
    disp("2. Editar información de producto");
    disp("3. Eliminar producto");
    disp("4. Ver lista de productos10");
    disp("5. Planificar producción");
    disp("6. Salir");

    % Solicitar opción al usuario
    opcion = input("Seleccione una opción: ");

    try
        switch opcion
            case 1
                % Agregar producto
                nombre_producto = input("Ingrese el nombre del producto: ", 's');
                cantidad = input("Ingrese la cantidad a producir: ");

                % Crear y ejecutar la consulta de inserción con parámetros
                insert_query = "INSERT INTO productos10 (nombre, cantidad) VALUES ($1, $2);";
                pq_exec_params(conn, insert_query, {nombre_producto, cantidad});

                disp("Producto agregado exitosamente.");

            case 2
                % Editar información de producto
                id_producto = input("Ingrese el ID del producto a editar: ");

                % Verificar si el producto existe
                select_query = sprintf("SELECT * FROM productos10 WHERE id = %d;", id_producto);
                result = pq_exec_params(conn, select_query);

                if ~isempty(result.data)
                    disp("Información actual del producto:");
                    disp(result.data);

                    % Solicitar nueva información
                    cantidad = input("Ingrese la nueva cantidad a producir: ");

                    % Crear y ejecutar la consulta de actualización con parámetros
                    update_query = "UPDATE productos10 SET cantidad = $1 WHERE id = $2;";
                    pq_exec_params(conn, update_query, {cantidad, id_producto});

                    disp("Información del producto actualizada exitosamente.");
                else
                    disp("El producto no existe en la base de datos.");
                end

            case 3
                % Eliminar producto
                id_producto = input("Ingrese el ID del producto a eliminar: ");

                % Verificar si el producto existe
                select_query = sprintf("SELECT * FROM productos10 WHERE id = %d;", id_producto);
                result = pq_exec_params(conn, select_query);

                if ~isempty(result.data)
                    % Crear y ejecutar la consulta de eliminación con parámetros
                    delete_query = "DELETE FROM productos10 WHERE id = $1;";
                    pq_exec_params(conn, delete_query, {id_producto});

                    disp("Producto eliminado exitosamente.");
                else
                    disp("El producto no existe en la base de datos.");
                end

            case 4
                % Ver lista de productos10
                select_all_query = "SELECT * FROM productos10;";
                result = pq_exec_params(conn, select_all_query);

                productos10 = result.data;

                if isempty(productos10)
                    disp("No hay productos10 en la base de datos.");
                else
                    disp("Lista de productos10:");

                    for i = 1:size(productos10, 1)
                        fprintf('Producto %d:\n', i);
                        fprintf('ID: %d\n', productos10{i, 1});
                        fprintf('Nombre: %s\n', productos10{i, 2});
                        fprintf('Cantidad a producir: %d\n', productos10{i, 3});
                        fprintf('----------------------------------\n');
                    end
                end

            case 5
    % Planificar producción
    id_producto = input("Ingrese el ID del producto a planificar: ");

    % Verificar si el producto existe
    select_query = sprintf("SELECT * FROM productos10 WHERE id = %d;", id_producto);
    result = pq_exec_params(conn, select_query);

    if ~isempty(result.data)
        disp("Información actual del producto:");
        disp(result.data);

        % Obtener la cantidad a producir
        cantidad_a_producir = result.data{1, 3};

        % Verificar si es necesario contratar empleados
        if cantidad_a_producir > 5
            disp("Se recomienda contratar empleados para la producción.");
        else
            disp("No es necesario contratar empleados para la producción.");
        end

        % Aquí puedes agregar lógica adicional relacionada con la planificación
        % ...

        disp("Producción planificada exitosamente.");
    else
        disp("El producto no existe en la base de datos.");
    end
            case 6
                % Salir del programa
                pq_close(conn);
                disp("Exit");
                return;

            otherwise
                disp("Opción no válida. Por favor, seleccione una opción válida.");
        end
    catch exception
        disp("Error al procesar la operación:");
        disp(exception.message);
    end
end

