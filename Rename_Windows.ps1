# Renomear hostname para o valor digitado
$name = Read-Host -Prompt "Por favor, informe o nome do hostname!"
Rename-Computer -NewName $name

# Adicionar ao grupo de trabalho "MeusPedidos"
Add-Computer -WorkgroupName "MEUSPEDIDOS"