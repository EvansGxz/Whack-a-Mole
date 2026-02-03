# Plantillas de GitHub Issues para Whack a Mole

## 📝 Cómo Usar Estas Plantillas

Copia el contenido de la plantilla que necesites y úsalo al crear un nuevo issue en GitHub.

---

## 🐛 Plantilla: Reporte de Bug

```markdown
## Descripción
[Descripción breve del problema]

## Pasos para reproducir
1. [Primer paso]
2. [Segundo paso]
3. [Paso final]

## Resultado Esperado
[Qué debería suceder]

## Resultado Actual
[Qué está sucediendo en realidad]

## Información del Sistema
- Navegador: [ej: Chrome 120]
- Sistema Operativo: [ej: Windows 10]
- Dispositivo: [ej: Desktop, Mobile]

## Capturas de Pantalla o Video
[Adjunta si es posible]

## Etiquetas
bug, priority: [critical/high/medium/low]
```

### Ejemplo Completado:
```markdown
## Descripción
El juego se congela cuando aparecen múltiples topos simultáneamente en dispositivos móviles antiguos.

## Pasos para reproducir
1. Abrir juego en un iPhone 6s
2. Iniciar el juego en nivel Difícil
3. Esperar a que el juego alcance 10+ segundos

## Resultado Esperado
El juego debe ejecutarse a 60 FPS sin interrupciones

## Resultado Actual
El juego se congela durante 2-3 segundos cada vez que aparecen topos

## Información del Sistema
- Navegador: Safari 16
- Sistema Operativo: iOS 16.1
- Dispositivo: iPhone 6s

## Etiquetas
bug, performance, mobile, priority: high
```

---

## ✨ Plantilla: Nueva Característica (Enhancement)

```markdown
## Descripción
[Explicación breve de la característica]

## Problema a Resolver
[Qué problema resuelve o por qué es importante]

## Solución Propuesta
[Cómo debería funcionar]

## Casos de Uso
- [Caso de uso 1]
- [Caso de uso 2]
- [Caso de uso 3]

## Criterios de Aceptación
- [ ] [Criterio 1]
- [ ] [Criterio 2]
- [ ] [Criterio 3]

## Recursos Adicionales
[Enlaces, documentación, referencias]

## Etiquetas
enhancement, [categoría], priority: [nivel]
```

### Ejemplo Completado:
```markdown
## Descripción
Agregar un sistema de niveles de dificultad progresiva al juego

## Problema a Resolver
Actualmente el juego tiene una sola dificultad, lo que limita el atractivo para jugadores de diferentes habilidades

## Solución Propuesta
Implementar 4 niveles de dificultad (Fácil, Normal, Difícil, Extremo) con diferentes parámetros

## Casos de Uso
- Jugadores nuevos pueden practicar en nivel Fácil
- Jugadores experimentados pueden desafiarse en nivel Extremo
- Progressión natural que mantiene al jugador engaged

## Criterios de Aceptación
- [ ] Crear pantalla de selección de dificultad
- [ ] Implementar lógica de velocidad variable por nivel
- [ ] Ajustar duración del juego según dificultad
- [ ] Guardar última dificultad seleccionada
- [ ] Mostrar indicador visual del nivel actual
- [ ] Aumentar multiplicador de puntuación por dificultad

## Recursos Adicionales
- Referencia: Juegos similares (Candy Crush, Flappy Bird)
- Sugerencia: Ver issue #23 para leaderboard

## Etiquetas
enhancement, gameplay, priority: high
```

---

## 🎯 Plantilla: Mejora de Documentación

```markdown
## Descripción
[Qué documentación falta o necesita mejora]

## Secciones a Actualizar
- [ ] [Sección 1]
- [ ] [Sección 2]
- [ ] [Sección 3]

## Cambios Propuestos
[Detalles específicos de lo que cambiaría]

## Archivos Afectados
- [archivo1.md]
- [archivo2.md]

## Etiquetas
documentation, priority: [nivel]
```

### Ejemplo Completado:
```markdown
## Descripción
El README no explica cómo instalar y ejecutar el proyecto localmente

## Secciones a Actualizar
- [ ] Sección "Instalación"
- [ ] Sección "Uso"
- [ ] Sección "Desarrollo Local"

## Cambios Propuestos
- Agregar paso a paso detallado para clonar el repo
- Explicar que no hay dependencias externas (HTML/CSS/JS puro)
- Mostrar cómo abrir el archivo en el navegador
- Agregar captura de pantalla del juego

## Archivos Afectados
- README.md

## Etiquetas
documentation, priority: high
```

---

## 🤔 Plantilla: Pregunta o Discusión

```markdown
## Pregunta
[Tu pregunta específica]

## Contexto
[Información relevante para entender la pregunta]

## Intentos Anteriores
[Qué ya has probado]

## Etiquetas
question
```

### Ejemplo Completado:
```markdown
## Pregunta
¿Cuál es la mejor manera de implementar sonidos en aplicaciones web sin problemas de autoplay?

## Contexto
Estoy intentando agregar sonidos adicionales al juego pero en algunos navegadores no reproducen automáticamente

## Intentos Anteriores
- Usar etiqueta <audio> con atributos autoplay
- Cargar sonidos desde CDN (Mixkit)
- Intentar reproducir con JavaScript

## Etiquetas
question, audio
```

---

## 🎓 Plantilla: Good First Issue (Para Nuevos Contribuyentes)

```markdown
## Descripción
[Explicación clara y amigable]

## Por Qué es un "Good First Issue"
[Explica por qué es ideal para principiantes]

## Pasos para Completar
1. [Paso 1]
2. [Paso 2]
3. [Paso 3]

## Recursos Útiles
- [Documentación relevante]
- [Ejemplos de código similar]
- [Tutoriales]

## Ayuda
[@mention] estoy disponible para preguntas

## Etiquetas
good first issue, priority: low, [categoría relevante]
```

### Ejemplo Completado:
```markdown
## Descripción
Agregar un botón "Mute" para silenciar el sonido del juego

## Por Qué es un "Good First Issue"
- Cambio pequeño y aislado
- No requiere entender toda la lógica del juego
- Útil para aprender a hacer cambios en HTML/CSS/JS
- Existe código de sonido similar para referenciar

## Pasos para Completar
1. Agregar botón HTML en la interfaz
2. Estilar el botón con CSS glassmorphism
3. Agregar funcionalidad en JavaScript para mutar/desmutar
4. Probar que funciona el toggle
5. Hacer commit y pull request

## Recursos Útiles
- [MDN: HTMLMediaElement.muted](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/muted)
- Ver función `playHitSound()` en golpea-al-topo.html
- Ejemplo: botón reset ya implementado

## Ayuda
@EvansGxz estoy disponible para preguntas

## Etiquetas
good first issue, priority: low, ui/ux
```

---

## 📋 Resumen de Etiquetas Principales

### Para Crear en GitHub Settings → Labels:

```yaml
Tipos:
- bug: #d73a49 (rojo)
- enhancement: #a2eeef (azul claro)
- documentation: #0075ca (azul)
- good first issue: #7057ff (púrpura)
- help wanted: #008672 (verde oscuro)
- question: #e1e4e8 (gris claro)
- wontfix: #e4e669 (amarillo)

Prioridades:
- priority: critical: #ff0000 (rojo brillante)
- priority: high: #ff6600 (naranja)
- priority: medium: #ffcc00 (amarillo)
- priority: low: #99cc00 (verde claro)

Categorías:
- gameplay: #7b3ff2 (púrpura)
- ui/ux: #0366d6 (azul)
- audio: #1f6feb (azul oscuro)
- performance: #fbca04 (amarillo)
- mobile: #0075ca (azul)
```

---

## 🔗 Vinculación Entre Issues

En la descripción de un issue puedes referenciar otros:
- `#123` vincula al issue 123
- `Closes #123` cierra automáticamente el issue al mergear el PR
- `Related to #123` indica relación

Ejemplo:
```markdown
Esta feature está relacionada con #45 (leaderboard)
y puede depender de #67 (localStorage)
```

---

## ✅ Checklist Antes de Crear un Issue

- [ ] El issue ya no existe (buscar en issues cerrados)
- [ ] Es clara la descripción
- [ ] Se incluyen etiquetas apropiadas
- [ ] Para bugs: incluí pasos para reproducir
- [ ] Para features: expliqué el valor agregado
- [ ] Vinculé issues relacionados si existen
- [ ] La información es relevante y completa

---

## 📞 Preguntas Frecuentes

**P: ¿Cuántas etiquetas puedo usar?**
R: 2-4 etiquetas es lo ideal. No más de 5.

**P: ¿Qué hago si el issue que quiero crear ya existe?**
R: Comenta en el issue existente. No crees duplicados.

**P: ¿Puedo crear issues sobre problemas que encontré pero no puedo arreglar?**
R: ¡Sí! Usa `help wanted` para solicitar ayuda de la comunidad.

---

¡Gracias por contribuir a Whack a Mole! 🎮✨
