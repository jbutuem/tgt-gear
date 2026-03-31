-- =============================================
-- TGT GEAR v5 — Migration SQL
-- Execute no Supabase SQL Editor
-- =============================================

-- 1. Adicionar fee_type na tabela productions
ALTER TABLE productions 
ADD COLUMN IF NOT EXISTS fee_type text 
DEFAULT 'fee' 
CHECK (fee_type IN ('fee', 'extra_fee'));

-- 2. Adicionar email e phone na tabela profiles
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS email text;

ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS phone text;

-- 3. Atualizar emails dos profiles existentes baseado no auth.users
UPDATE profiles p
SET email = u.email
FROM auth.users u
WHERE p.id = u.id
AND p.email IS NULL;

-- 4. Confirmar
SELECT 'Migration v5 concluída!' as status;
SELECT id, name, role, email, phone FROM profiles;
