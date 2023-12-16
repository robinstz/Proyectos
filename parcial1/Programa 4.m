pkg load database

% Establecer la conexión a la base de datos
conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));

while true
    % Mostrar menú
    disp("1. Agregar Pedido");
    disp("2. Actualizar Pedido por Identificación");
    disp("3. Eliminar Pedido por Identificación");
    disp("4. Mostrar Lista de Pedidos");
    disp("5. Salir");

    % Solicitar opción al usuario
    opcion = input("Seleccione una opción: ");

    switch opcion
        case 1
            % Agregar pedidos4
            identificacion = input("Ingrese la identificación del pedidos4: ");
            cliente = input("Ingrese el nombre del cliente: ", 's');
            producto = input("Ingrese el nombre del producto: ", 's');
            entrega = input("¿Entregado? (Sí/No): ", 's');

            % Crear y ejecutar la consulta de inserción
            insert_query = sprintf("INSERT INTO pedidos4 (identificacion, cliente, producto, entrega) VALUES ('%d', '%s', '%s', '%s');", identificacion, cliente, producto, entrega);
            pq_exec_params(conn, insert_query);

            disp("Pedido agregado exitosamente.");

        case 2
            % Actualizar pedidos4 por identificación
            identificacion = input("Ingrese la identificación del pedidos4 a actualizar: ");

            % Verificar si el pedidos4 existe
            select_query = sprintf("SELECT * FROM pedidos4 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if ~isempty(result.data)
                disp("Información actual del pedidos4:");
                disp(result.data);

                % Solicitar nueva información
                entrega = input("¿Entregado? (Sí/No): ", 's');

                % Crear y ejecutar la consulta de actualización
                update_query = sprintf("UPDATE pedidos4 SET entrega = '%s' WHERE identificacion = '%d';", entrega, identificacion);
                pq_exec_params(conn, update_query);

                disp("Pedido actualizado exitosamente.");
            else
                disp("No se encontró un pedidos4 con la identificación proporcionada.");
            end

        case 3
            % Eliminar pedidos4 por identificación
            identificacion = input("Ingrese la identificación del pedidos4 a eliminar: ");

            % Verificar si el pedidos4 existe
            select_query = sprintf("SELECT * FROM pedidos4 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if ~isempty(result.data)
                % Crear y ejecutar la consulta de eliminación
                delete_query = sprintf("DELETE FROM pedidos4 WHERE identificacion = '%d';", identificacion);
                pq_exec_params(conn, delete_query);

                disp("Pedido eliminado exitosamente.");
            else
                disp("No se encontró un pedidos4 con la identificación proporcionada.");
            end

        case 4
            % Mostrar lista de pedidos
            select_all_query = "SELECT * FROM pedidos4;";
            result = pq_exec_params(conn, select_all_query);

            disp("Lista de Pedidos:");
            disp(result.data);

        case 5
            % Salir del programa
            pq_close(conn);
            disp("¡Hasta luego!");
            return;

        otherwise
            disp("Opción no válida. Por favor, seleccione una opción válida.");
    end
end

