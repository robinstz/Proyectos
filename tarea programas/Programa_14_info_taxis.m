pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

while true
    fprintf('\n1. Ingresar información de un taxi\n');
    fprintf('2. Mostrar historial de taxis\n');
    fprintf('3. Salir\n');

    opcion = input('Seleccione una opción: ');

    if opcion == 1
        modelo = input("Ingrese el modelo del taxi: ");
        kilometraje = input("Ingrese los kilómetros recorridos: ");

        if modelo < 2007 && kilometraje >= 20000
            fprintf("El taxi debe renovarse.\n");
            estado = 'El taxi debe renovarse';
        elseif modelo < 2007 && kilometraje < 20000
            fprintf("El taxi esta en buenas condiciones.\n");
            estado = 'El taxi esta en buenas condiciones';
        elseif modelo >= 2007 && modelo <= 2013 && kilometraje >= 20000
            fprintf("El taxi necesita mantenimiento.\n");
            estado = 'El taxi necesita mantenimiento';
        elseif modelo >= 2007 && modelo <= 2013 && kilometraje < 20000
            fprintf("El taxi esta en buenas condiciones.\n");
            estado = 'El taxi esta en buenas condiciones';
        elseif modelo > 2013 && kilometraje < 10000
            fprintf("El taxi está en óptimas condiciones.\n");
            estado = 'El taxi está en óptimas condiciones';
        else
            fprintf("El taxi necesita atención mecánica.\n");
            estado = 'El taxi necesita atención mecánica';
        end

        % Crear la consulta para la base de datos
        insert_query = sprintf("INSERT INTO infotaxis14 VALUES (%d, %d, '%s')", modelo, kilometraje, estado);
        pq_exec_params(conn, insert_query);

    elseif opcion == 2
        % Obtener los registros
        result = pq_exec_params(conn, 'SELECT * FROM infotaxis14;');

        % Imprimir los registros en la consola
        disp(result);

        % Guardar los registros en un archivo llamado "registros14.txt"
        fileID = fopen('registros14.txt', 'w');
        fprintf(fileID, 'Modelo\tKilometraje\tEstado\n');

        for i = 1:size(result.data, 1)
            fprintf(fileID, '%d\t%d\t%s\n', str2double(result.data{i, 1}), str2double(result.data{i, 2}), result.data{i, 3});
        end

        fclose(fileID);

    elseif opcion == 3
        break; % Salir del ciclo while
    else
        fprintf('Opción no válida. Inténtelo de nuevo.\n');
    end
end


