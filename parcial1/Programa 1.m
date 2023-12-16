pkg load database

% Establecer la conexión a la base de datos
conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));

while true
    % Mostrar menú
    disp("1. Agregar estudiante");
    disp("2. Editar información de estudiante");
    disp("3. Eliminar estudiante");
    disp("4. Ver lista de estudiantes");
    disp("5. Salir");

    % Solicitar opción al usuario
    opcion = input("Seleccione una opción: ");

    switch opcion
        case 1
            % Agregar estudiante
            identificacion = input("Ingrese la identificación del estudiante: ");
            nombre = input("Ingrese el nombre del estudiante: ", 's');
            edad = input("Ingrese la edad del estudiante: ");
            genero = input("Ingrese el género del estudiante: ", 's');
            direccion = input("Ingrese la dirección del estudiante: ", 's');

            % Crear y ejecutar la consulta de inserción
            insert_query = sprintf("INSERT INTO estudiantes1 (identificacion, nombre, edad, genero, direccion) VALUES ('%d', '%s', %d, '%s', '%s');", identificacion, nombre, edad, genero, direccion);
            pq_exec_params(conn, insert_query);

            disp("Estudiante agregado exitosamente.");

        case 2
            % Editar información de estudiante
            identificacion = input("Ingrese la identificación del estudiante a editar: ");

            % Verificar si el estudiante existe
            select_query = sprintf("SELECT * FROM estudiantes1 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if !isempty(result.data)
                disp("Información actual del estudiante:");
                disp(result.data);

                % Solicitar nueva información
                nombre = input("Ingrese el nuevo nombre del estudiante: ", 's');
                edad = input("Ingrese la nueva edad del estudiante: ");
                genero = input("Ingrese el nuevo género del estudiante: ", 's');
                direccion = input("Ingrese la nueva dirección del estudiante: ", 's');

                % Crear y ejecutar la consulta de actualización
                update_query = sprintf("UPDATE estudiantes1 SET nombre = '%s', edad = %d, genero = '%s', direccion = '%s' WHERE identificacion = '%d';", nombre, edad, genero, direccion, identificacion);
                pq_exec_params(conn, update_query);

                disp("Información del estudiante actualizada exitosamente.");
            else
                disp("El estudiante no existe en la base de datos.");
            end

        case 3
            % Eliminar estudiante
            identificacion = input("Ingrese la identificación del estudiante a eliminar: ");

            % Verificar si el estudiante existe
            select_query = sprintf("SELECT * FROM estudiantes1 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if !isempty(result.data)
                % Crear y ejecutar la consulta de eliminación
                delete_query = sprintf("DELETE FROM estudiantes1 WHERE identificacion = '%d';", identificacion);
                pq_exec_params(conn, delete_query);

                disp("Estudiante eliminado exitosamente.");
            else
                disp("El estudiante no existe en la base de datos.");
            end

        case 4
            % Ver lista de estudiantes
            select_all_query = "SELECT * FROM estudiantes1;";
            result = pq_exec_params(conn, select_all_query);

            disp("Lista de estudiantes:");
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

