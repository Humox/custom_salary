Script de Pagos para Trabajos (ESX)
Este es un script diseñado para ser utilizado en servidores de FiveM con el framework ESX. El script permite realizar pagos periódicos a los jugadores de acuerdo con su trabajo y rango. Además, incluye un comando para administradores que les permite forzar el pago a los jugadores.

Descripción
Pagos Automáticos: Cada minuto se verifica si es tiempo de pagar a los jugadores según su trabajo y rango. El tiempo entre pagos está configurado en minutos, y cada trabajo puede tener diferentes intervalos de pago.
Comando de Administrador: Los administradores pueden utilizar el comando /forcepay para forzar pagos a todos los jugadores o a un trabajo específico.
Notificaciones: Los jugadores recibirán una notificación de pago con la cantidad de dinero recibido y su rango dentro del trabajo.
Instalación
Requisitos:

Tener un servidor de FiveM con ESX correctamente instalado.
Asegúrate de tener configurado un archivo config.lua donde puedas agregar los trabajos, rangos y salarios.
Archivos:

Coloca este script en la carpeta de recursos de tu servidor.
Asegúrate de que esté correctamente referenciado en el archivo server.cfg de tu servidor.
