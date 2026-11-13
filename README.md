# Práctica 8: Uso de Ansible para automatizar tareas en servidores

Se crean 5 servidores Ubuntu (contenedores Docker con SSH) y se automatizan tareas con Ansible.

## Archivos

| Archivo | Descripción |
|---|---|
| `Dockerfile` | Ubuntu con SSH server, usuario `ansible` (pass `ansible`) y sudo sin password |
| `docker-compose.yml` | 5 servicios (servidor1..servidor5) basados en esa imagen |
| `inventario.ini` | Nombres, IPs/puertos, usuario y clave de los servidores |
| `ansible.cfg` | Apunta al inventario e ignora la advertencia de SSH (host key checking) |
| `playbook.yml` | Actualiza APT, crea usuario `itla`, carpeta `app`, `hola.txt`, instala `cowsay` y `htop` |

## Pasos

1. Instalar Docker (en Windows: Docker Desktop con integración WSL).
2. (Windows) `wsl --install` en PowerShell como administrador y reiniciar.
3. En Ubuntu/WSL: `sudo apt update && sudo apt install -y ansible sshpass`
4. Levantar los servidores: `docker compose up -d --build`
5. Probar conexión: `ansible servidores -m ping`
6. Ejecutar el playbook: `ansible-playbook playbook.yml`

## Verificación

```bash
ansible servidores -a "ls -l /home/itla/app"
ansible servidores -a "cat /home/itla/app/hola.txt"
ansible servidores -a "/usr/games/cowsay Ansible funciona"
ansible servidores -a "which htop"
```

## Limpieza

```bash
docker compose down
```
