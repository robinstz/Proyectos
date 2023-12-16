%Monitoreo de ventas

pkg load database
function Problema5()
    % Establecer la conexión a la base de datos
    conn = pq_connect(setdbopts('dbname','parcial1','host','localhost','port','5432','user','postgres','password','1234'));

    while true
        fprintf('\n--- Monitoreo de ventas5 ---\n');
        fprintf('1. Agregar nueva venta\n');
        fprintf('2. Actualizar Monto\n');
        fprintf('3. Eliminar Producto\n');
        fprintf('4. Mostrar ventas\n');
        fprintf('5. Salir\n');

        opcion = input('Selecciona una opción: ');

        switch opcion
            case 1
                fecha = input('Ingrese la fecha (DD-MM-AAAA): ', 's');
                producto = input('Ingrese el nombre del producto: ', 's');
                cantidad = input('Cantidad: ', 's');
                ingresos = input('Monto: ');

                % Insertar la venta en la base de datos
                insert_query = sprintf("INSERT INTO ventas5 (fecha, producto, cantidad, ingresos) VALUES ('%s', '%s', %s, %d);", fecha, producto, cantidad, ingresos);
                pq_exec_params(conn, insert_query);
                fprintf('Venta agregada con éxito.\n');

            case 2
                ingresos = input('Ingrese el ingresos a actualizar: ');

                % Actualizar el ingresos
                update_query = sprintf("UPDATE ventas5 SET ingresos = %d;", ingresos);
                pq_exec_params(conn, update_query);
                fprintf('Monto actualizado.\n');

            case 3
                producto = input('Ingrese el producto a eliminar: ', 's');

                % Eliminar la venta de la base de datos
                delete_query = sprintf("DELETE FROM ventas5 WHERE producto = '%s';", producto);
                pq_exec_params(conn, delete_query);
                fprintf('Venta eliminada.\n');


case 4
    fprintf('\nLista de ventas:\n');
    select_query = "SELECT * FROM ventas5";
    result = pq_exec_params(conn, select_query);

    % Obtener el número de filas
    num_rows = size(result.data, 1);

    if num_rows > 0
        % Mostrar los encabezados
        fprintf('%-10s %-10s %-10s\n', 'Venta', 'Producto', 'Monto');
        fprintf('--------------------------------------\n');

        % Mostrar los datos
        for i = 1:num_rows
            fprintf('%-10d %-10s %-10d\n', i, result.data{i, 2}, result.data{i, 4});
        end
    else
        disp("No hay ventas registradas.");
    end

            case 5
                % Cerrar la conexión a la base de datos
                pq_close(conn);
                fprintf('¡Hasta luego!\n');
                return;

            otherwise
                fprintf('Opción no válida. Por favor, elija una opción válida.\n');
        end
    end
end

Problema5();

