pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

% Pedir una palabra al usuario
palabra = input("Ingrese una palabra: ", "s");

% Convertir la palabra a mayúsculas para facilitar la comparación
palabra = upper(palabra);

% Definir un conjunto de vocales
vocales = ['A', 'E', 'I', 'O', 'U'];

% Inicializar un vector para contar las ocurrencias de cada vocal
ocurrencias = zeros(1, length(vocales));

% Contar las ocurrencias de cada vocal en la palabra
for i = 1:length(palabra)
    if ismember(palabra(i), vocales)
        vocal_index = find(vocales == palabra(i));
        ocurrencias(vocal_index) = ocurrencias(vocal_index) + 1;
    end
end

% Mostrar el resultado concatenado como texto
resultado_texto = "";
for i = 1:length(vocales)
    resultado_texto = [resultado_texto, vocales(i), "=", num2str(ocurrencias(i))];
    if i < length(vocales)
        resultado_texto = [resultado_texto, ", "];
    end
end

fprintf("Resultado: %s\n", resultado_texto);



insert_query = sprintf("INSERT INTO contadorvocales5 VALUES ('%s', '%s')",palabra , resultado_texto);
pq_exec_params(conn, insert_query);
%N=pq_exec_params(conn, 'select * from contadorvocales5;')


% Abrir o crear el archivo para escritura
archivo = fopen('registros5.txt', 'a');

% Verificar si se pudo abrir el archivo
if archivo == -1
    error('No se pudo abrir el archivo para escritura.');
end

% Escribir la información en el archivo
fprintf(archivo, '%s\t%s\n', palabra, resultado_texto);

% Cerrar el archivo
fclose(archivo);

disp('La información se ha guardado en registros5.txt.');

