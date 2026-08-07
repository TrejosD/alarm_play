# alarm_play

Este nuevo proyecto va a permitir al usuario crear alarmas a pedido. Y disfrutar con estas de su play list.
Ya no despertaras cada mañana con el mismo sonido monotono. Ahora te sorprenderas al despertar con un nuevo sonido cada mañana.

## Getting Started

Este proyecto utiliza play list precargadas y permite crear nuevas de acuerdo a los archivos guardados en tu telefono.
Integrasion con Spotify y YouTube music coming soon.

- Este proyecto utiliza metodos puros de android para manejar las alarmas de manera nativa.

## Desarrollo

### Cambios en el splash Screen

```
dart run flutter_native_splash:create --path=C:/Users/Diego/Documents/apps/alarm_play/flutter_native_splash.yaml
```

### Cambios en local-DB

```
dart run build_runner build
```

### Cambiar el nombre del app

- Utilizando el rename CLI en powerchell. - Bash no funciona
- Comando para buscar el nombre actual

```
rename getAppName
```

- Comando para cambiar el nombre del app.

```
rename setAppName --targets ios,android --value "New App Name"
```

### Observaciones

- Si decido llevar el app a produccion, remover la copia de archivos de sonido.
- Agregar mas fuentes de archivos de sonido, dropbox, youtube, etc...
