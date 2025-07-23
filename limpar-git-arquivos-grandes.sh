#!/bin/bash

# CONFIGURAR
REPO_URL="https://github.com/caduunisal/learn-terraform-get-started-aws.git"
REPO_NOME="learn-terraform-get-started-aws"
MIRROR_NOME="${REPO_NOME}-mirror"
BFG_JAR="bfg-1.14.0.jar"

echo "✅ Instalando dependências (Java)..."
sudo apt update && sudo apt install -y openjdk-17-jre wget git

echo "📥 Baixando BFG Repo-Cleaner..."
wget -O $BFG_JAR https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar

echo "🔄 Clonando o repositório em modo espelho..."
git clone --mirror $REPO_URL $MIRROR_NOME
cd $MIRROR_NOME || { echo "❌ Erro ao acessar pasta $MIRROR_NOME"; exit 1; }

echo "🧹 Limpando arquivos maiores que 100MB..."
java -jar ../$BFG_JAR --strip-blobs-bigger-than 100M

echo "🧼 Limpando histórico restante..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo "🚀 Forçando push para repositório remoto..."
git push --force

echo "✅ Finalizado com sucesso! Você pode deletar a pasta '$MIRROR_NOME' se quiser."

