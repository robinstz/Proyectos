pkg load database % Cargar el paquete
conn = pq_connect(setdbopts('dbname','corto1','host','localhost','port','5432','user','postgres','password','1234'));

% Pedir 3 números al usuario
num1 = input("Ingrese el primer número: ");
num2 = input("Ingrese el segundo número: ");
num3 = input("Ingrese el tercer número: ");

if num1 == num2 && num2 == num3
    % Los tres números son iguales
    fprintf("Todos los números son iguales: %d %d %d\n", num1, num2, num3);
    insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'todos los números son iguales')", num1, num2, num3);
    pq_exec_params(conn, insert_query);



    elseif num1 == num2
    % El primer y segundo número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", num1, num2);
    fprintf("El número diferente es: %d\n", num3);
    insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", num1, num2, num3, num3);
    pq_exec_params(conn, insert_query);

    elseif num1 == num3
    % El primer y tercer número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", num1, num3);
    fprintf("El número diferente es: %d\n", num2);
    insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", num1, num2, num3, num2);
    pq_exec_params(conn, insert_query);


    elseif num2 == num3
    % El segundo y tercer número son iguales
    fprintf("Los dos números iguales son: %d y %d\n", num2, num3);
    fprintf("El número diferente es: %d\n", num1);
    insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'numero que no es igual: %d')", num1, num2, num3, num1);
    pq_exec_params(conn, insert_query);


    else
    % Ningún par de números es igual
    if num1 > num2 && num1 > num3
    % Primer número es el más grande
    resultado = num1 + num2 + num3;
    fprintf("El primer número es el más grande. Suma de los tres números: %d\n", resultado);
    insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'El primer número es el más grande. Suma de los tres números: %d')", num1, num2, num3, resultado);
    pq_exec_params(conn, insert_query);

  elseif num2 > num1 && num2 > num3
     % Segundo número es el más grande
     resultado = num1 * num2 * num3;
     fprintf("El segundo número es el más grande. Multiplicación de los tres números: %d\n", resultado);
     insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'El segundo número es el más grande. Multiplicación de los tres números: %d')", num1, num2, num3, resultado);
     pq_exec_params(conn, insert_query);


 elseif num3 > num1 && num3 > num2
     % Tercer número es el más grande
     concatenacion = [num1 num2 num3];
     fprintf("El tercer número es el más grande. Concatenación de los tres números: [%d %d %d]\n", concatenacion);
     insert_query = sprintf("INSERT INTO TresNumeros VALUES (%d,(%d),(%d), 'El tercer número es el más grande. Concatenación de los tres números: [%d %d %d]\n)')", num1, num2, num3, concatenacion);
     pq_exec_params(conn, insert_query);
  end
end
    insert_query = "SELECT * FROM TresNumeros";
    pq_exec_params(conn, insert_query);


