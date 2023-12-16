pkg load database

function conn = conectar_bd()
    conn = pq_connect(setdbopts('dbname', 'parcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', '1234'));
end

function ingresar_pelicula(conn)
    nombre = input('Ingrese el nombre de la película: ', 's');
    genero = input('Ingrese el género de la película: ', 's');
    clasificacion = input('Ingrese la clasificación de la película: ', 's');

    % Insertar datos en la base de datos
    query = sprintf("INSERT INTO peliculas7 (nombre, genero, clasificacion) VALUES ('%s', '%s', '%s');", nombre, genero, clasificacion);
    pq_exec_params(conn, query);
end

function recomendar_pelicula(conn)
    genero = input('Ingrese el género para recibir recomendaciones: ', 's');

    % Consultar películas del mismo género en la base de datos
    query = sprintf("SELECT nombre FROM peliculas7 WHERE genero = '%s';", genero);
    result = pq_exec_params(conn, query);

    if isempty(result.data)
        disp('No hay películas en ese género en la base de datos.');
    else
        disp('Peliculas recomendadas:');
        disp(result.data);
    end
end

% Programa principal
conn = conectar_bd();

while true
    fprintf('Menú:\n');
    fprintf('1. Ingresar información de la película\n');
    fprintf('2. Recomendar películas por género\n');
    fprintf('3. Salir\n');

    opcion = input('Seleccione una opción: ');

    switch opcion
        case 1
            ingresar_pelicula(conn);
        case 2
            recomendar_pelicula(conn);
        case 3
            pq_close(conn);
            disp('¡Hasta luego!');
            return;
        otherwise
            disp('Opción no válida. Por favor, seleccione una opción válida.');
    end
end

