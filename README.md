# Controlador PID para Sistema Viga-Cilindro

Este proyecto implementa un controlador PID discreto para un sistema no lineal de viga-cilindro utilizando MATLAB. El objetivo principal es controlar tanto la posición como el ángulo del cilindro sobre la viga, logrando un error permanente igual a cero. A continuación, se detallan los aspectos más relevantes del desarrollo, implementación y resultados obtenidos.

## 1. Introducción

El sistema viga-cilindro es un modelo no lineal proporcionado como parte del curso de Control Automático. Dado que los métodos tradicionales para sistemas lineales no son aplicables directamente, se optó por diseñar un controlador PID discreto ajustado mediante prueba y error. Este enfoque permitió obtener un sistema estable con un error permanente que tiende a cero.

## 2. Implementación del Controlador

### 2.1. Tipo de Controlador y Características

Se utilizó un controlador PID discreto debido a su capacidad para manejar sistemas no lineales y discretos. Este controlador incluye una retención de orden, simulando el comportamiento real del sistema. La ecuación general del controlador PID discreto es:

Donde:
- `kp` es la ganancia proporcional.
- `ki' = ki * Δt` es la ganancia integral ajustada al tiempo de muestreo.
- `kd' = kd / Δt` es la ganancia derivativa ajustada al tiempo de muestreo.

### 2.2. Controlador de Posición

El primer paso fue diseñar un controlador PID para la posición del cilindro. Se realizaron múltiples pruebas variando los valores de `kp`, `ki` y `kd`, obteniendo los mejores resultados con:
- `kp = 400`
- `ki = 100`
- `kd = 1.2`

### 2.3. Controlador de Ángulo

Posteriormente, se diseñó un controlador PID para mantener el ángulo de la viga en 0°. Los mejores resultados se obtuvieron con:
- `kp = 5000`
- `ki = 1000`
- `kd = 7`

### 2.4. Controlador Final

Finalmente, se combinaron ambos controladores (posición y ángulo) para trabajar de manera conjunta. Los valores óptimos encontrados fueron:
- Controlador angular:
  - `kp = 6000`
  - `ki = 1000`
  - `kd = 200`
- Controlador de posición:
  - `pos_kp = 3000`
  - `pos_ki = 200`
  - `pos_kd = 250`

## 3. Resultados

Los resultados obtenidos muestran que el sistema logra estabilizarse con un error permanente que tiende a cero. A continuación, se destacan los principales logros:
- El controlador angular mantiene el ángulo de la viga en 0°.
- El controlador de posición permite que el cilindro alcance la referencia deseada.
- El sistema es capaz de manejar referencias intermedias con buenos resultados.

### Gráficos Representativos
- **Posición del cilindro en el tiempo**: Muestra cómo el cilindro alcanza la referencia deseada.
- **Velocidad del cilindro**: Indica la estabilidad del sistema.
- **Ángulo de la viga**: Permanece cercano a 0°.
- **Derivada del ángulo**: Refleja la suavidad del control angular.

## 4. Análisis y Supuestos

- **Método de ajuste**: Se utilizó prueba y error debido a la naturaleza no lineal del sistema.
- **Suposiciones**: Se asumió que ajustar los controladores por separado era la mejor estrategia para luego combinarlos.
- **Limitaciones**: Aunque el controlador PID fue efectivo, otros enfoques como controladores en cascada podrían mejorar el rendimiento.

## 5. Conclusiones

El proyecto demuestra que es posible controlar un sistema no lineal como el viga-cilindro utilizando un controlador PID discreto. Los resultados obtenidos validan la efectividad del método de prueba y error para ajustar los parámetros del controlador. Aunque el sistema presenta una sobreoscilación inicial, logra estabilizarse con un error permanente igual a cero.

Este trabajo sienta las bases para futuras mejoras, como la implementación de controladores más avanzados o la optimización automática de los parámetros del PID.

## 6. Archivos del Proyecto

- `VB_Lazo_Abierto.m`: Simulación del sistema en lazo abierto.
- `VB_cont1_ang.m`: Controlador PID para el ángulo.
- `VB_cont2_pos.m`: Controlador PID para la posición.
- `VB_final.m`: Controlador combinado para posición y ángulo.
- `Entrega_2_Control_Automatico_Perez_Ignacio.pdf`: Informe detallado del proyecto.

## 7. Requisitos

- MATLAB R2021a o superior.
- Paquete de herramientas de simulación de sistemas dinámicos.

## 8. Ejecución

Para ejecutar el controlador final, abra el archivo `VB_final.m` en MATLAB y ejecútelo. Los gráficos generados mostrarán los resultados de la simulación.

---
**Autor**: Ignacio Pérez  
**Curso**: Control Automático
