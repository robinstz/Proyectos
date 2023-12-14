pkg load database % Cargar el paquete
conexion = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

% Definir la función generarArchivo antes de ser utilizada
function generarArchivo(numero1, numero2, numero3)
    % Generar el archivo 'registros1.txt'
    archivo = fopen('registros1.txt', 'a'); % 'a' para abrir en modo de añadir
    fprintf(archivo, 'Número 1: %d\n', numero1);
    fprintf(archivo, 'Número 2: %d\n', numero2);
    fprintf(archivo, 'Número 3: %d\n\n', numero3);
    fclose(archivo);
end

% Pedir 3 números al usuario
numero1 = input("Ingrese el primer número: ");
numero2 = input("Ingrese el segundo número: ");
numero3 = input("Ingrese el tercer número: ");


if numero1 == numero2 && numero2 == numero3
    % Los tres números son iguales
    fprintf("Todos los números son iguales: %d %d %d\n", numero1, numero2, numero3);
    insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'todos los números son iguales')", numero1, numero2, numero3);
elseif numero1 == numero2
    % El primer y segundo número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", numero1, numero2);
    fprintf("El número diferente es: %d\n", numero3);
    insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", numero1, numero2, numero3, numero3);
elseif numero1 == numero3
    % El primer y tercer número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", numero1, numero3);
    fprintf("El número diferente es: %d\n", numero2);
    insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", numero1, numero2, numero3, numero2);
elseif numero2 == numero3
    % El segundo y tercer número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", numero2, numero3);
    fprintf("El número diferente es: %d\n", numero1);
    insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", numero1, numero2, numero3, numero1);
else
    % Ningún par de números es igual
    if numero1 > numero2 && numero1 > numero3
        % Primer número es el más grande
        resultado = numero1 + numero2 + numero3;
        fprintf("El primer número es el más grande. Suma de los tres números: %d\n", resultado);
        insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'El primer número es el más grande. la suma es: %d')", numero1, numero2, numero3, resultado);
    elseif numero2 > numero1 && numero2 > numero3
        % Segundo número es el más grande
        resultado = numero1 * numero2 * numero3;
        fprintf("El segundo número es el más grande. Multiplicación de los tres números: %d\n", resultado);
        insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'El segundo número es el más grande. La mult es: %d')", numero1, numero2, numero3, resultado);
    elseif numero3 > numero1 && numero3 > numero2
        % Tercer número es el más grande
        concatenacion = [numero1 numero2 numero3];
        fprintf("El tercer número es el más grande. Concatenación de los tres números: [%d %d %d]\n", concatenacion);
        insert_query = sprintf("INSERT INTO pedirnumeros1 VALUES (%d,(%d),(%d), 'El tercer número es el más grande. la concatenacion es: [%d %d %d]\n')", numero1, numero2, numero3, concatenacion);
    end
end

% Ejecutar todas las inserciones antes de obtener el resultado
pq_exec_params(conexion, insert_query);

% Realizar la consulta SELECT
select_query = "SELECT * FROM pedirnumeros1";
result = pq_exec_params(conexion, select_query);
%disp(result);

% Llamar a la función generarArchivo
generarArchivo(numero1, numero2, numero3);

