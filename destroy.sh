#!/bin/bash

echo "🔁 Destruindo infraestrutura..."

# Inicializa o Terraform (caso necessário)
terraform.exe init -input=false

# Executa a destruição sem solicitar confirmação
terraform.exe destroy -auto-approve

echo "✅ Infraestrutura destruída com sucesso!"

