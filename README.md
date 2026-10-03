# Despliegue de Entornos DEV y QA con Terraform y Docker

Este proyecto implementa la infraestructura como código (IaC) para desplegar dos entornos aislados (**DEV** y **QA**) utilizando **Terraform** y el proveedor de **Docker**. Cada entorno cuenta con su propia red privada y una arquitectura de 3 capas: Base de Datos, API y Servidor Web.

---

## Arquitectura de los Entornos

| Entorno | Servicio | Imagen | Puerto Host | Puerto Contenedor | Red Docker |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **DEV** | `web-dev` | `nginx:alpine` | `4001` | `80` | `red-dev` |
| **DEV** | `api-dev` | `node:18-alpine` | `4002` | `3000` | `red-dev` |
| **DEV** | `bd-dev` | `postgres:15-alpine` | `4003` | `5432` | `red-dev` |
| **QA** | `web-qa` | `nginx:alpine` | `5001` | `80` | `red-qa` |
| **QA** | `api-qa` | `node:18-alpine` | `5002` | `3000` | `red-qa` |
| **QA** | `bd-qa` | `postgres:15-alpine` | `5003` | `5432` | `red-qa` |

---

## Requisitos Previos

* [Docker Desktop](https://www.docker.com/products/docker-desktop/) en ejecución.
* [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.0+ instalado.
* [Git](https://git-scm.com/) para el control de versiones.

---

## Instrucciones de Despliegue

1. **Ubicarse en la carpeta del proyecto:**
   ```bash
   cd tarea-terraform-environments

## 2. Instalación y despliegue

**Inicializar los proveedores de Terraform:**

```bash
terraform init
```

**Planificar el despliegue (opcional):**

```bash
terraform plan
```

**Aplicar la configuración:**

```bash
terraform apply -auto-approve
```

Este comando aplica la configuración definida en `main.tf` y crea los recursos correspondientes a los entornos DEV y QA.

## Verificación

Para confirmar que todos los contenedores están ejecutándose correctamente:

```bash
docker ps
```

También puedes comprobar los servidores web ingresando en el navegador a:

* **Entorno DEV (Nginx):** http://localhost:4001
* **Entorno QA (Nginx):** http://localhost:5001

**Convención de Commits**

Este proyecto sigue la convención de Conventional Commits:

feat: Adición de nuevos recursos de infraestructura.

fix: Corrección de errores en la configuración de contenedores.

docs: Documentación del proyecto.

**Destrucción de la infraestructura**

Para eliminar los recursos creados por Terraform y detener los contenedores:

terraform destroy

Confirma la operación cuando Terraform lo solicite. Para ejecutarla sin confirmación, utiliza terraform destroy -auto-approve.