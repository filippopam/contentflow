# ContentFlow 📅

Plataforma de calendario editorial para redes sociales.

## Setup en 3 pasos

### 1. Supabase — Crear las tablas

1. Ve a [supabase.com](https://supabase.com) → tu proyecto
2. Click en **SQL Editor** → **New Query**
3. Pega el contenido de `supabase/schema.sql` y haz click en **Run**

### 2. Supabase — Crear el bucket de almacenamiento

1. Ve a **Storage** en el sidebar
2. Click **New bucket**
3. Nombre: `contentflow-media`
4. Activa **Public bucket** ✓
5. Click **Create bucket**

Luego, en **Policies** del bucket, agrega una policy:
- **Policy name:** `public access`
- **Allowed operation:** SELECT, INSERT, UPDATE, DELETE
- **Target roles:** public

### 3. Vercel — Deploy

1. Sube este proyecto a GitHub
2. Ve a [vercel.com](https://vercel.com) → **New Project**
3. Importa el repositorio de GitHub
4. Click **Deploy** (sin configuración extra)

¡Listo! Tu app estará en `https://tu-proyecto.vercel.app`

## Uso

- Cualquier persona con el link puede ver y editar el calendario
- Los datos se guardan en tu base de datos de Supabase
- Las imágenes y videos se guardan en Supabase Storage
- Funciona desde cualquier computadora o celular
