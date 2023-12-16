pkg load database

function conn = conectar_bd()
    conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));
end

function agregar_producto(conn, identificacion, nombre, cantidad, precio)
    try
        query = sprintf("INSERT INTO inventario3 (identificacion, nombre, cantidad, precio) VALUES ('%s', '%s', %d, %f);", identificacion, nombre, cantidad, precio);
        pq_exec_params(conn, query);
        fprintf('Producto agregado exitosamente.\n');
    catch e
        fprintf('Error al agregar el producto a la base de datos: %s\n', e.message);
    end
end

function actualizar_producto(conn, identificacion, nombre, cantidad, precio)
    try
        query = sprintf("UPDATE inventario3 SET nombre = '%s', cantidad = %d, precio = %f WHERE identificacion = '%s';", nombre, cantidad, precio, identificacion);
        pq_exec_params(conn, query);
        fprintf('Información del producto actualizada exitosamente.\n');
    catch e
        fprintf('Error al actualizar la información del producto en la base de datos: %s\n', e.message);
    end
end

function eliminar_producto(conn, identificacion)
    try
        query = sprintf("DELETE FROM inventario3 WHERE identificacion = '%s';", identificacion);
        pq_exec_params(conn, query);
        fprintf('Producto eliminado exitosamente.\n');
    catch e
        fprintf('Error al eliminar el producto de la base de datos: %s\n', e.message);
    end
end

function gestion_inventario()
    conn = conectar_bd();

    while true
        fprintf('Bienvenido al Programa de Gestión de Inventario\n');
        fprintf('1. Agregar nuevo producto\n');
        fprintf('2. Actualizar información de producto\n');
        fprintf('3. Eliminar producto\n');
        fprintf('4. Salir\n');

        opcion = input('Seleccione una opción: ');

        try
            switch opcion
                case 1
                    identificacion = input('Ingrese la identificación del producto: ', 's');
                    nombre = input('Ingrese el nombre del producto: ', 's');
                    cantidad = input('Ingrese la cantidad del producto: ');
                    precio = input('Ingrese el precio del producto: ');

                    agregar_producto(conn, identificacion, nombre, cantidad, precio);

                case 2
                    identificacion = input('Ingrese la identificación del producto a actualizar: ', 's');
                    nombre = input('Ingrese el nuevo nombre del producto: ', 's');
                    cantidad = input('Ingrese la nueva cantidad del producto: ');
                    precio = input('Ingrese el nuevo precio del producto: ');

                    actualizar_producto(conn, identificacion, nombre, cantidad, precio);

                case 3
                    identificacion = input('Ingrese la identificación del producto a eliminar: ', 's');
                    eliminar_producto(conn, identificacion);

                case 4
                    pq_close(conn);
                    fprintf('¡Hasta luego!\n');
                    return;

                otherwise
                    fprintf('Opción no válida. Por favor, seleccione una opción válida.\n');
            end
        catch e
            fprintf('Ha ocurrido un error inesperado: %s\n', e.message);
        end
    end
end

gestion_inventario();

