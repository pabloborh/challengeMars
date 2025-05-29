# DevOps Challenge

## Tarea 1: Infraestructura como Código (`terraform/`)

### Estructura

* `envs/` contiene las definiciones por entorno. Por ejemplo:

  * `alpha`: desplegado en `eu-west-1`
  * `beta`: desplegado en `eu-west-2`
* `modules/` contiene:

  * `colony/`: define recursos de la colony.
  * `sqs/`: módulo reutilizable de colas.

### Características

* VPC con 2 subredes públicas y 2 privadas con acceso a internet (mediante NAT gateways).
* Soporte para DNS interno de AWS habilitado.

---

## Tarea 2: Despliegue de Aplicaciones (`apps/`, `charts/`, `jenkins/`)

### Jenkins (`jenkins/`)

* Levantamiento con Docker:

  ```bash
  docker-compose up --build -d
  ```
* El job de `mars-rover-fleet-tracker` está definido como código en:

  ```
  jenkins_jobs/mars/config.xml
  ```
* Se desactiva el asistente inicial, y se instalan los plugins necesarios automáticamente.
* Uso de mejores prácticas para tagging de imágenes con hash del commit.

### GitOps con ArgoCD (`apps/`)

* `apps/` contiene las definiciones de aplicaciones para ArgoCD.
* Los despliegues en Kubernetes son gestionados por GitOps.

### Helm Chart (`charts/mars-rover-fleet-tracker/`)

* Helm chart personalizado para la app.
* Valores diferenciados por entorno (`values.yaml`, `values-prod.yaml`, etc).
* Permite configurar el `command` para entornos de desarrollo:

  ```yaml
  command: ["npm", "run", "start:dev"]
  ```

---

## Tarea 3: Observabilidad (`observability/`)

### Stack

* `Prometheus` + `Alertmanager` + `Grafana`, levantados con:

  ```bash
  docker-compose up -d
  ```
* Requiere que la imagen `mars-rover-fleet-tracker:1` esté construida previamente.

### Configuración

* Archivos de configuración para reglas de alerta Prometheus:

  * Alertas por datos faltantes y condiciones críticas para `wind_speed` y `temperature`.
* Dashboard en Grafana preconfigurado para monitoreo de `mars-rover`.

---

> Autor: *Pablo Borja hernandez*
> Fecha: 2025
