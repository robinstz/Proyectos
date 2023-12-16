pkg load database

function conn = conectar_bd(identificacion, descripcion, monto, fecha)
    conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));
    query = sprintf("INSERT INTO presupuesto2 (identificacion, descripcion, monto, fecha) VALUES (%d, '%s', %d, '%s');", identificacion, descripcion, monto, fecha);
    pq_exec_params(conn, query);
end

function Presupuesto()
    historial = struct('identificacion', {}, 'descripcion', {}, 'monto', {}, 'fecha', {});

    while true
        fprintf('Bienvenido al Programa de Seguimiento de Presupuesto Personal\n');
        fprintf('1. Ingresar nuevo gasto\n');
        fprintf('2. Ver resumen de gastos acumulados\n');
        fprintf('3. Ajustar presupuestos\n');
        fprintf('4. Modificar gasto\n');
        fprintf('5. Salir\n');

        opcion = input('Seleccione una opción: ');

        try
            switch opcion
                case 1
                    identificacion = input('Ingrese el ID del gasto: ');
                    descripcion = input('Ingrese la descripción del gasto: ', 's');
                    monto = input('Ingrese el monto del gasto: ');
                    fecha = input('Ingrese la fecha del gasto (DD-MM-YYYY): ', 's');

                    % Llamar a la función para agregar el gasto a la base de datos
                    conectar_bd(identificacion, descripcion, monto, fecha);

                    nuevoGasto.identificacion = identificacion;
                    nuevoGasto.descripcion = descripcion;
                    nuevoGasto.monto = monto;
                    nuevoGasto.fecha = fecha;

                    historial(end + 1) = nuevoGasto;

                    fprintf('Gasto ingresado con éxito.\n');

                case 2
                    if isempty(historial)
                        fprintf('No hay gastos en el historial.\n');
                    else
                        fprintf('Resumen de gastos acumulados:\n');
                        for i = 1:length(historial)
                            fprintf('%d: %s - Q%d - %s\n', historial(i).identificacion, historial(i).descripcion, historial(i).monto, historial(i).fecha);
                        end
                    end

                case 4
                    if isempty(historial)
                        fprintf('No hay gastos en el historial.\n');
                    else
                        fprintf('Lista de gastos:\n');
                        for i = 1:length(historial)
                            fprintf('%d: %s - Q%d - %s\n', historial(i).identificacion, historial(i).descripcion, historial(i).monto, historial(i).fecha);
                        end

                        identificacion_modificar = input('Ingrese el ID del gasto que desea modificar: ');

                        indice = find([historial.identificacion] == identificacion_modificar);

                        if isempty(indice)
                            fprintf('El ID ingresado no corresponde a un gasto existente.\n');
                        else
                            fprintf('Gasto seleccionado:\n');
                            fprintf('%d: %s - Q%d - %s\n', historial(indice).identificacion, historial(indice).descripcion, historial(indice).monto, historial(indice).fecha);

                            % Puedes solicitar la nueva información y realizar la actualización en la base de datos
                            nuevo_monto = input('Ingrese el nuevo monto del gasto: ');
                            nuevo_fecha = input('Ingrese la nueva fecha del gasto (DD-MM-YYYY): ', 's');

                            % Actualizar en la base de datos
                            conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));
                            update_query = sprintf("UPDATE presupuesto2 SET monto = %d, fecha = '%s' WHERE identificacion = '%s';", nuevo_monto, nuevo_fecha, num2str(identificacion_modificar));
                            pq_exec_params(conn, update_query);

                            % Actualizar en el historial
                            historial(indice).monto = nuevo_monto;
                            historial(indice).fecha = nuevo_fecha;

                            fprintf('Gasto modificado con éxito.\n');
                        end
                    end

                case 5
                    fprintf('¡Hasta luego!\n');
                    return;

                otherwise
                    fprintf('Opción no válida. Por favor, seleccione una opción válida.\n');
            end
        catch ex
            fprintf('Ha ocurrido un error: %s\n', ex.message);
        end
    end
end

Presupuesto();

