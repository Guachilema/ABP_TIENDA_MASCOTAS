CREATE DATABASE tienda_mascotas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE tienda_mascotas;
CREATE TABLE IF NOT EXISTS django_migrations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    app VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    applied DATETIME NOT NULL
);

CREATE TABLE auth_group_permissions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES auth_group (id),
    FOREIGN KEY (permission_id) REFERENCES auth_permission (id)
);

CREATE TABLE auth_user_groups (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES auth_user (id),
    FOREIGN KEY (group_id) REFERENCES auth_group (id)
);

CREATE TABLE auth_user_user_permissions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES auth_user (id),
    FOREIGN KEY (permission_id) REFERENCES auth_permission (id)
);

CREATE UNIQUE INDEX auth_group_permissions_group_id_permission_id_uniq 
    ON auth_group_permissions (group_id, permission_id);

CREATE INDEX auth_group_permissions_group_id_idx 
    ON auth_group_permissions (group_id);

CREATE INDEX auth_group_permissions_permission_id_idx 
    ON auth_group_permissions (permission_id);

CREATE UNIQUE INDEX auth_user_groups_user_id_group_id_uniq 
    ON auth_user_groups (user_id, group_id);

CREATE INDEX auth_user_groups_user_id_idx 
    ON auth_user_groups (user_id);

CREATE INDEX auth_user_groups_group_id_idx 
    ON auth_user_groups (group_id);

CREATE UNIQUE INDEX auth_user_user_permissions_user_id_permission_id_uniq 
    ON auth_user_user_permissions (user_id, permission_id);

CREATE INDEX auth_user_user_permissions_user_id_idx 
    ON auth_user_user_permissions (user_id);

CREATE INDEX auth_user_user_permissions_permission_id_idx 
    ON auth_user_user_permissions (permission_id);

CREATE TABLE django_admin_log (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    object_id TEXT,
    object_repr VARCHAR(200) NOT NULL,
    action_flag SMALLINT UNSIGNED NOT NULL,
    change_message TEXT NOT NULL,
    content_type_id INT,
    user_id INT NOT NULL,
    action_time DATETIME NOT NULL,
    FOREIGN KEY (content_type_id) REFERENCES django_content_type (id),
    FOREIGN KEY (user_id) REFERENCES auth_user (id)
);

CREATE INDEX django_admin_log_content_type_id_idx 
    ON django_admin_log (content_type_id);

CREATE INDEX django_admin_log_user_id_idx 
    ON django_admin_log (user_id);

CREATE TABLE django_content_type (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    app_label VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    UNIQUE (app_label, model)
);

CREATE TABLE auth_permission (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content_type_id INT NOT NULL,
    codename VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY (content_type_id) REFERENCES django_content_type (id)
);

CREATE UNIQUE INDEX auth_permission_content_type_id_codename_uniq 
    ON auth_permission (content_type_id, codename);

CREATE INDEX auth_permission_content_type_id_idx 
    ON auth_permission (content_type_id);

CREATE TABLE auth_group (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE auth_user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(128) NOT NULL,
    last_login DATETIME,
    is_superuser BOOLEAN NOT NULL,
    username VARCHAR(150) NOT NULL UNIQUE,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL,
    is_staff BOOLEAN NOT NULL,
    is_active BOOLEAN NOT NULL,
    date_joined DATETIME NOT NULL,
    first_name VARCHAR(150) NOT NULL
);

CREATE TABLE productos_producto (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    imagen VARCHAR(100) NOT NULL,
    disponible BOOLEAN NOT NULL
);

CREATE TABLE django_session (
    session_key VARCHAR(40) NOT NULL PRIMARY KEY,
    session_data TEXT NOT NULL,
    expire_date DATETIME NOT NULL
);

CREATE INDEX django_session_expire_date_idx 
    ON django_session (expire_date);

CREATE TABLE productos_productocarrito (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cantidad INT UNSIGNED NOT NULL,
    producto_id BIGINT NOT NULL,
    session_id VARCHAR(255),
    usuario_id INT,
    FOREIGN KEY (producto_id) REFERENCES productos_producto (id),
    FOREIGN KEY (usuario_id) REFERENCES auth_user (id)
);

CREATE INDEX productos_productocarrito_producto_id_idx 
    ON productos_productocarrito (producto_id);

CREATE INDEX productos_productocarrito_usuario_id_idx 
    ON productos_productocarrito (usuario_id);
    
INSERT INTO productos_producto (nombre, descripcion, precio, imagen, disponible) 
VALUES 
('Arnés ajustable para perro', 'Arnés resistente y ajustable con correas acolchonadas para mayor comodidad.', 18.50, 'productos/arnes.jpeg', TRUE),

('Juguete Interactivo para perro', 'Juguete interactivo con diseño resistente que estimula la inteligencia de tu perro.', 12.00, 'productos/inter.jpg', TRUE),

('Colchón ortopédico para perro', 'Colchón cómodo con soporte ortopédico ideal para perros mayores o con problemas articulares.', 45.99, 'productos/ORTOPED.jpg', TRUE),

('Comida Premium Para perro sabor a pollo', 'Alimento de alta calidad con sabor a pollo, ideal para una dieta balanceada.', 22.50, 'productos/prem.jpg', TRUE),

('Rascador para gatos', 'Rascador vertical con base estable y diseño atractivo para el cuidado de las uñas de tu gato.', 25.00, 'productos/RASCADOR.jpeg', TRUE),

('Snack de pescado para gatos', 'Delicioso snack de pescado rico en omega 3 para la salud de tu gato.', 5.75, 'productos/snak.jpeg', TRUE),

('Transporte para perro pequeño', 'Transportadora segura y cómoda para perros pequeños, ideal para viajes.', 30.00, 'productos/transpo.jpg', TRUE);
