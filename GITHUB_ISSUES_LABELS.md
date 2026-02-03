# GitHub Issues y Etiquetas - Whack a Mole 🔨

## 📌 Etiquetas Recomendadas

### Tipos de Issues

| Etiqueta | Color | Descripción |
|----------|-------|-------------|
| `bug` | #d73a49 | Problemas o errores en el funcionamiento |
| `enhancement` | #a2eeef | Nuevas características o mejoras |
| `documentation` | #0075ca | Mejoras en documentación |
| `good first issue` | #7057ff | Problemas ideales para nuevos contribuyentes |
| `help wanted` | #008672 | Se solicita ayuda de la comunidad |
| `question` | #e1e4e8 | Preguntas o aclaraciones |
| `wontfix` | #e4e669 | Issues que no serán solucionados |

### Prioridades

| Etiqueta | Color | Descripción |
|----------|-------|-------------|
| `priority: critical` | #ff0000 | Critica - Requiere atención inmediata |
| `priority: high` | #ff6600 | Alta - Importante para la próxima versión |
| `priority: medium` | #ffcc00 | Media - Importante pero no urgente |
| `priority: low` | #99cc00 | Baja - Mejora menor |

### Categorías

| Etiqueta | Color | Descripción |
|----------|-------|-------------|
| `gameplay` | #7b3ff2 | Cambios relacionados a mecánicas de juego |
| `ui/ux` | #0366d6 | Interfaz de usuario y experiencia |
| `audio` | #1f6feb | Sonidos y música |
| `performance` | #fbca04 | Optimización y rendimiento |
| `mobile` | #0075ca | Problemas o mejoras para dispositivos móviles |

---

## 🎯 Ejemplos de Issues Previstas

### 1️⃣ Nuevas Características (Enhancement)

#### Issue: Sistema de Niveles de Dificultad
```
Título: Agregar niveles de dificultad progresiva
Etiquetas: enhancement, gameplay, priority: medium
Descripción:
Implementar diferentes niveles de dificultad que afecten:
- Velocidad de aparición de topos (más rápida en niveles superiores)
- Duración del juego (30s, 60s, 120s)
- Puntuación multiplicadora según dificultad

Nivel Fácil: Topos lentos, 30s, 1x puntos
Nivel Normal: Topos normales, 30s, 1x puntos
Nivel Difícil: Topos rápidos, 60s, 2x puntos
Nivel Extremo: Topos muy rápidos, 120s, 3x puntos
```

#### Issue: Sistema de Leaderboard
```
Título: Agregar tabla de clasificación (leaderboard)
Etiquetas: enhancement, ui/ux, priority: medium
Descripción:
- Guardar mejores puntuaciones en localStorage
- Mostrar top 10 de puntuaciones
- Permitir ingresar nombre de jugador
- Mostrar fecha de cada puntuación
- Opción para limpiar el leaderboard
```

#### Issue: Temas Visuales Alternativos
```
Título: Crear temas visuales adicionales
Etiquetas: enhancement, ui/ux, priority: low
Descripción:
Agregar opciones de tema al juego:
- Tema Oscuro (Actual - Glassmorphism)
- Tema Claro
- Tema Colorido
- Tema Retro/Pixelado
- Tema Cyberpunk

Cada tema debe mantener la funcionalidad del juego.
```

#### Issue: Poder Especiales y Power-ups
```
Título: Implementar sistema de power-ups
Etiquetas: enhancement, gameplay, priority: low
Descripción:
Agregar objetos especiales que aparecen ocasionalmente:
- ⭐ Doble Puntos: +50 puntos por topo
- 🛡️ Escudo: Evita 1 golpe fallido
- ⚡ Velocidad: Ralentiza los topos por 5 segundos
- 🎯 Precisión: Desactiva sonido de fallo por 10 segundos

Mostrar animaciones especiales cuando se obtienen.
```

#### Issue: Modo Multijugador Local
```
Título: Agregar modo multijugador local
Etiquetas: enhancement, gameplay, priority: low
Descripción:
- 2 jugadores en la misma pantalla
- Pantalla dividida o turnos
- Competencia por puntuación más alta
- Colores diferenciados para cada jugador
```

#### Issue: Sistema de Logros/Badges
```
Título: Crear sistema de logros desbloqueables
Etiquetas: enhancement, ui/ux, priority: medium
Descripción:
Implementar logros para motivar a jugadores:
- 🥉 Principiante: Obtener 100 puntos
- 🥈 Intermedio: Obtener 500 puntos
- 🥇 Avanzado: Obtener 1000 puntos
- 🎯 Cazador Perfecto: 10 golpes consecutivos sin fallar
- ⚡ Rayo: Golpear 3 topos en 5 segundos
- 🏆 Campeón: Obtener 2000+ puntos

Guardar en localStorage y mostrar en modal.
```

### 2️⃣ Mejoras de Experiencia de Usuario (UI/UX)

#### Issue: Agregar Tutorial Interactivo
```
Título: Crear tutorial para nuevos jugadores
Etiquetas: enhancement, ui/ux, documentation, priority: medium
Descripción:
- Primera ejecución muestra tutorial
- Explicar controles y objetivo
- Demostración rápida de mecánicas
- Opción para saltar tutorial
- Guardar estado "Tutorial visto" en localStorage
```

#### Issue: Estadísticas de Juego Mejoradas
```
Título: Mostrar estadísticas detalladas tras cada juego
Etiquetas: enhancement, ui/ux, priority: low
Descripción:
Agregar pantalla de resultados con:
- Puntuación final
- Topos golpeados
- Porcentaje de precisión (aciertos/intentos)
- Tiempo promedio de reacción
- Comparación con puntuación anterior
- Botón para compartir resultados
```

#### Issue: Modo Practica
```
Título: Crear modo práctica sin límite de tiempo
Etiquetas: enhancement, gameplay, ui/ux, priority: low
Descripción:
- Juego sin límite de tiempo
- Topos con velocidad controlada
- Ideal para principiantes
- Mostrar mensajes de retroalimentación
- Opción para terminar cuando el jugador quiera
```

### 3️⃣ Mejoras de Audio

#### Issue: Aumentar Variedad de Sonidos
```
Título: Agregar más efectos de sonido variados
Etiquetas: enhancement, audio, priority: low
Descripción:
Ampliar la paleta de sonidos:
- Múltiples variantes de sonido de acierto
- Sonido de inicio del juego
- Sonido de fin de juego
- Sonido de cuenta atrás final
- Opción para silenciar/mutear sonidos
- Control de volumen
```

#### Issue: Agregar Música de Fondo
```
Título: Implementar música de fondo ambiental
Etiquetas: enhancement, audio, priority: low
Descripción:
- Música relajante de fondo durante el juego
- Música diferente según nivel de dificultad
- Opción para activar/desactivar
- Control de volumen independiente
- Usar audio del CDN (ej: Zapsplat, Freepik)
```

### 4️⃣ Optimización y Performance

#### Issue: Optimizar para Dispositivos Móviles
```
Título: Mejorar responsividad en mobile
Etiquetas: enhancement, mobile, performance, priority: high
Descripción:
- Verificar experiencia en diferentes tamaños de pantalla
- Ajustar tamaño de botones y áreas táctiles
- Optimizar para orientación vertical y horizontal
- Mejorar velocidad de carga
- Pruebas en navegadores móviles principales
```

#### Issue: Lazy Loading de Recursos
```
Título: Implementar lazy loading para sonidos
Etiquetas: enhancement, performance, priority: low
Descripción:
- Cargar sonidos bajo demanda
- Precargar solo sonidos frecuentes
- Mejorar tiempo de carga inicial
- Implementar caché de navegador
```

### 5️⃣ Bugs y Correcciones

#### Issue: Sonidos no reproducen en algunos navegadores
```
Título: [BUG] Sonidos de juego no reproducen
Etiquetas: bug, audio, priority: high
Descripción:
Contexto:
Los sonidos no se reproducen en algunos navegadores/dispositivos

Pasos para reproducir:
1. Abrir juego en navegador específico
2. Iniciar juego
3. Golpear un topo

Resultado esperado:
Debe escucharse el sonido de acierto

Resultado actual:
No se produce sonido

Posibles soluciones:
- Usar diferentes formatos de audio
- Manejar políticas de autoplay
- Intentar cargar sonidos desde diferentes CDNs
```

#### Issue: Juego se congela en dispositivos antiguos
```
Título: [BUG] Performance baja en dispositivos antiguos
Etiquetas: bug, performance, mobile, priority: high
Descripción:
El juego presenta lag y bajo FPS en dispositivos antiguos

- Optimizar animaciones CSS
- Reducir cálculos en cada frame
- Implementar requestAnimationFrame donde sea necesario
- Pruebas de rendimiento
```

### 6️⃣ Documentación

#### Issue: Crear README detallado
```
Título: Mejorar documentación del README
Etiquetas: documentation, priority: high
Descripción:
- Instrucciones de instalación claras
- Características del juego
- Cómo contribuir
- Licencia
- Créditos de sonidos/assets
- Capturas de pantalla
```

#### Issue: Agregar comentarios al código
```
Título: Documentar código con comentarios explicativos
Etiquetas: documentation, priority: low
Descripción:
- Agregar JSDoc a funciones principales
- Explicar lógica compleja
- Comentarios en CSS para secciones
- Guía de arquitectura
```

---

## 📊 Tablero de Trabajo Sugerido

### Por Hacer (To Do)
- Sistema de Niveles
- Leaderboard
- Power-ups
- Temas Visuales

### En Progreso (In Progress)
- Optimización Mobile
- Tutorial Interactivo

### Hecho (Done)
- Juego base
- Glassmorphism Design
- Sistema de Sonidos

---

## 🚀 Roadmap Sugerido

### Versión 1.1 (Próxima)
- ✅ Sistema de niveles de dificultad
- ✅ Leaderboard con localStorage
- ✅ Optimización para mobile
- ✅ Tutorial interactivo

### Versión 1.2
- ✅ Sistema de logros
- ✅ Múltiples temas visuales
- ✅ Mejoras en audio

### Versión 2.0
- ✅ Modo multijugador
- ✅ Power-ups
- ✅ Estadísticas avanzadas
- ✅ Sincronización en la nube

---

## 💡 Notas para Contribuyentes

Para crear un nuevo issue en GitHub:
1. Usa las etiquetas apropiadas
2. Sé específico y proporciona detalles
3. Para bugs: incluye pasos para reproducir
4. Para features: explica el valor que añade
5. Vincula issues relacionados
6. Revisa issues existentes antes de crear uno nuevo

¡Gracias por contribuir! 🎮✨
