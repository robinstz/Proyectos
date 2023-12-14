pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

% Pedir una palabra al usuario
palabra = input("Ingrese una palabra: ", "s");

% Convertir la palabra a minúsculas para facilitar la comparación
palabra = lower(palabra);

% Inicializar el contador de vocales
contador_vocales = 0;

% Definir un conjunto de vocales
vocales = ['a', 'e', 'i', 'o', 'u'];

% Contar las vocales en la palabra
for i = 1:length(palabra)
    if ismember(palabra(i), vocales)
        contador_vocales = contador_vocales + 1;
    end
end

% Mostrar el resultado
fprintf("La palabra tiene %d vocales.\n", contador_vocales);

% Insertar en la base de datos
insert_query = sprintf("INSERT INTO vocalespalabra7 VALUES ('%s', 'La palabra tiene %d vocales.')",palabra , contador_vocales);
pq_exec_params(conn, insert_query);

% Generar archivo registros7.txt
fileID = fopen('registros7.txt', 'a');
fprintf(fileID, '%s, %d\n', palabra, contador_vocales);
fclose(fileID);

% Consultar y mostrar los registros actuales
%N = pq_exec_params(conn, 'SELECT * FROM vocalespalabra7;');
%disp(N);

% Consultar y mostrar el contenido del archivo registros7.txt
file_contents = fileread('registros7.txt');
%disp('Contenido de registros7.txt:');
disp(file_contents);

