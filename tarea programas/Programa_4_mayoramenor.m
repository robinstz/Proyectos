pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

function guardarRegistrosEnArchivo(nombreArchivo, mayor, menor, cadena_numeros)
    % Abrir el archivo en modo de adición, creándolo si no existe
    fid = fopen(nombreArchivo, 'a');

    % Verificar si se pudo abrir el archivo
    if fid == -1
        disp('Error al abrir el archivo para escribir.');
        return;
    end

    % Obtener la fecha y hora actual para incluir en el registro
    fechaHora = datestr(now, 'yyyy-mm-dd HH:MM:SS');

    % Escribir la información en el archivo
    fprintf(fid, 'Registros del %d al %d generados el %s:\n', mayor, menor, fechaHora);
    fprintf(fid, 'Lista de números: %s\n', cadena_numeros);
    fprintf(fid, '\n');

    % Cerrar el archivo
    fclose(fid);
end

% Pedir dos números al usuario
numero1 = input("Ingrese el primer número: ");
numero2 = input("Ingrese el segundo número: ");

% Verificar cuál es el número mayor
if numero1 > numero2
    mayor = numero1;
    menor = numero2;
elseif numero2 > numero1
    mayor = numero2;
    menor = numero1;
else
    disp("Los números son iguales.");
    return;
end

% Crear un array para almacenar la lista de números desde el mayor hasta el menor
numeros_array = mayor:-1:menor;

% Convertir el array en una lista de texto
cadena_numeros = "";
for i = 1:length(numeros_array)
    cadena_numeros = [cadena_numeros, num2str(numeros_array(i))];
    if i < length(numeros_array)
        cadena_numeros = [cadena_numeros, ", "];
    end
end

% Mostrar la lista de números concatenados como texto
fprintf("Lista de números desde %d hasta %d: %s\n", mayor, menor, cadena_numeros);

% Insertar registros en la base de datos
insert_query = sprintf("INSERT INTO mayoramenor4 VALUES (%d,%d, '[%s]\n')", mayor, menor, cadena_numeros);
pq_exec_params(conn, insert_query);

% Guardar los registros en un archivo de texto (añadir al final)
guardarRegistrosEnArchivo('registros4.txt', mayor, menor, cadena_numeros);

% Consultar y mostrar registros desde la base de datos
%insert_query = "SELECT * FROM mayoramenor4";
%result = pq_exec_params(conn, insert_query);
%disp(result);

