# Flutter Intermedio: Diseños profesionales y animaciones

Del curso de Fernando Herrera: https://cursos.devtalles.com/courses/flutter-Intermedio

## Music Player

![alt idea](./images/goal.png)

Principalmente veremos:

- Crear imágenes que giren
- Usar controladores de la animación
- AnimatedIcons
- Controladores de los iconos animados
- Reproducción de audio
- Barras de progreso
- Manejo de tiempo
- Y más

### Inicio de proyecto

Creamos el proyecto, vamos a `main.dart` y lo vamos modificando.

En la raiz del proyecto creamos la carpeta `assets` y colocamos las imágenes que vienen con el proyecto.

En el archivo `pubscpec.yaml` añadimos la carpeta `assets` para que se puedan ver nuestras imágenes.

En la carpeta `lib` creamos la carpeta `src` y dentro las carpetas `widgets`, `helpers`, `models`, `pages` y `theme`.

Para este proyecto, para no repetir cosas ya vistas en el curso, se da hecho `helpers.dat` y `theme.dart`.

En la carpeta `pages` creamos el archivo `music_player_page.dart`.

En `main.dart` llamamos a nuestra nueva page.

### Custom AppBar

Instalamos el paquete `font_awesome_flutter`.

En la carpeta `widgets` creamos el archivo `custom_appbar.dart`.

En `music_player_page.dart` llamamos a nuestro nuevo widget.

### Imagen del disco

Modificamos `music_player_page.dart`.

### Progreso de la canción

Modificamos `music_player_page.dart`.

### Título y botón de Play

Modificamos `music_player_page.dart`.

### Lyrics - ListWheelScrollView

ListWheelScrollView es un ListView con un efecto circular.

Modificamos `music_player_page.dart`.

### Fondo con gradiente

Modificamos `music_player_page.dart`.

Es la última clase de diseño de esta app.

### Icono animado

Empezamos con la funcionalidad.

Modificamos `music_player_page.dart`.

### Animación del disco

Vamos a hacer que el disco gire. Lo más difícil es enlazar el giro del disco con el botón de play, y para eso usaremos un provider.

Instalamos los paquetes `animate_do` de animaciones y `provider` para hacer comunicación entre widgets..

En la carpeta `models` creamos el archivo `audioplayer_model.dart`.

Añadimos en `main.dart` el Provider.

Modificamos `music_player_page.dart`.

### Determinar la duración del disco

Modificamos `audioplayer_model.dart`.

### Reproducir música

Instalamos el paquete `assets_audio_player`.

Modificamos `music_player_page.dart`.
