#!/bin/bash
echo "⏳ Importando datos de facturas.json a la base de datos finanzas..."

mongoimport \
  --db finanzas \
  --collection facturas \
  --username mongo \
  --password mongo \
  --authenticationDatabase admin \
  --file /tmp/facturas.json


echo "✅ Import completo."

