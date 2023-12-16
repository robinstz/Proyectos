pkg load database

function gestion_inventarios(conn)
    while true
        % Mostrar menú
        fprintf('\nMenú:\n');
        fprintf('1) Ingresar nuevo producto\n');
        fprintf('2) Actualizar cantidad del producto\n');
        fprintf('3) Mostrar informe de ventas\n');
        fprintf('4) Salir\n');

        % Leer opción del usuario
        opcion = input('Ingrese el número de la opción deseada: ');

        switch opcion
            case 1
                % Ingresar nuevo producto
                nombre = input('Ingrese el nombre del producto: ', 's');
                precio = input('Ingrese el precio del producto: ');
                cantidad = input('Ingrese la cantidad del producto: ');

                % Insertar en la base de datos
                insert_query = sprintf("INSERT INTO inventario9 (nombre, precio, cantidad) VALUES ('%s', %f, %d);", nombre, precio, cantidad);
                pq_exec_params(conn, insert_query);
                fprintf('Nuevo producto ingresado y registrado en la base de datos.\n');

            case 2
                % Actualizar la cantidad del producto existente
                nombre_producto = input('Ingrese el nombre del producto a actualizar: ', 's');
                nueva_cantidad = input('Ingrese la nueva cantidad del producto: ');

                % Actualizar en la base de datos
                update_query = sprintf("UPDATE inventario9 SET cantidad = %d WHERE nombre = '%s';", nueva_cantidad, nombre_producto);
                pq_exec_params(conn, update_query);
                fprintf('Cantidad del producto actualizada en la base de datos.\n');

            case 3
                % Mostrar informe de ventas
                fprintf('Mostrando informe de ventas:\n');

                % Obtener información de todos los productos
              %  query = "SELECT * FROM inventario9;";
               % result = pq_exec_params(conn, query);
               % disp(result);

            case 4
                % Salir del programa
                fprintf('Saliendo del programa.\n');
                break;

            otherwise
                fprintf('Opción no válida. Inténtelo de nuevo.\n');
        end

        if opcion == 4
            % Salir del programa
            pq_close(conn);
            disp("Exit");
            break;
        end
    end
end

% Establecer la conexión a la base de datos
conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));

% Ejecutar la función principal
gestion_inventarios(conn);

% Cerrar la conexión después de salir
pq_close(conn);

