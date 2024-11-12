## TEMA 1 "Manejo de permisos a nivel de usuarios de base de datos."

Los permisos son los que nos permiten controlar qué acciones podemos realizar sobre los objetos de una base de datos, ya sean tablas, vistas, también si podemos agregar o eliminar datos, entre otras cosas. Estos permisos se dividen en:

### Permisos de DML (Data Manipulation Language)
Son operaciones de consulta y modificación de datos.
- **SELECT**: Permite consultar datos.
- **INSERT**: Permite agregar nuevos registros.
- **UPDATE**: Permite modificar registros existentes.
- **DELETE**: Permite eliminar registros.

### Permisos de ejecución
Permiten a los usuarios ejecutar procedimientos almacenados y funciones:
- **EXECUTE**: Permite la ejecución de procedimientos almacenados.

### Permisos de control de objetos
Permiten a los usuarios modificar o administrar objetos dentro de la base de datos:
- **ALTER**: Permite modificar la estructura de un objeto.
- **CONTROL**: Otorga el control total sobre un objeto.

SQL Server permite la creación y gestión de usuarios tanto a nivel de servidor como dentro de cada base de datos específica. La gestión de usuarios se realiza a través de la creación de cuentas y asignación de roles y permisos. Los usuarios pueden ser creados mediante el propio SQL Server o mediante autenticación de Windows. Para crear un usuario se utilizan comandos como `CREATE LOGIN` para la autenticación de servidor y `CREATE USER` para la creación del usuario dentro de una base de datos específica.

### Sintaxis de creación de un usuario mediante LOGIN y USER:

```sql
-- creación de usuario a nivel servidor
CREATE LOGIN alan WITH PASSWORD = '12345';

-- creación de usuario dentro de la base de datos proyecto_bd_I
USE proyecto_bd_I;
CREATE USER alan FOR LOGIN alan;
```
## Roles en SQL Server

Los roles son colecciones de permisos que se pueden asignar a los usuarios para facilitar la administración. SQL Server ofrece dos tipos de roles:

- **Roles fijos de servidor**: Roles como `sysadmin` y `securityadmin`, que son definidos por SQL Server y tienen permisos amplios a nivel de servidor.
- **Roles fijos de base de datos**: Roles como `db_owner`, `db_datareader`, y `db_datawriter`, que se aplican a nivel de base de datos para controlar operaciones específicas sobre los datos.

### Sintaxis:

```sql
-- asigna el rol db_owner al usuario 
ALTER ROLE db_owner ADD MEMBER alan;

-- crear un rol personalizado para analistas de datos 
CREATE ROLE AnalistaDeDatos;
```

La gestion de permisos se realiza principalmente a través de los comandos:
- **GRANT**: Otorga un permiso a un usuario o rol.
- **DENY**: Niega un permiso específico a un usuario o rol, incluso si se le ha otorgado anteriormente.
- **REVOKE**: Elimina un permiso previamente otorgado o denegado.

### Ejemplo:

```sql
-- otorga permiso SELECT al usuario 'pepito' sobre una tabla productos
GRANT SELECT ON productos TO pepito;
-- deniega permiso INSERT al usuario 'pepito' sobre una tabla perfiles
DENY INSERT, UPDATE ON perfiles TO pepito
```
El manejo adecuado de permisos en `SQL Server` es una de las estrategias fundamentales para proteger los datos y garantizar un acceso controlado. La implementación de roles, el uso del principio de menor privilegio y la revisión constante de permisos son prácticas esenciales para mantener la seguridad en un entorno de bases de datos relacionales. A través de herramientas como `SSMS` y mediante una correcta estructuración de permisos, los administradores pueden asegurar una gestión eficiente y segura de los datos.

## Conclusiones del tema 1:

Al desarrollar el tema de permisos y roles en SQL Server, entendimos cómo una adecuada gestión de accesos contribuye a la seguridad y eficiencia en el manejo de datos en entornos colaborativos. Desde los permisos individuales hasta la creación de roles específicos, como el de solo lectura, comprobamos que SQL Server permite personalizar y controlar el acceso a los datos de manera flexible y organizada.

En los ejercicios prácticos, implementamos permisos a nivel de usuario y de rol, asignando permisos de ejecución a un usuario con acceso limitado y comprobando cómo los roles facilitan la administración de múltiples usuarios. Esto no solo demostró que los roles permiten ahorrar tiempo y reducir errores al agregar o remover usuarios sin afectar los permisos individuales, sino que también minimiza errores administrativos, proporcionando un entorno más seguro y escalable para la administración de usuarios en la base de datos.