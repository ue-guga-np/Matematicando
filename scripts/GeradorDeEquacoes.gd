extends Node

var resposta_correta = 0
var pontos_da_rodada = 10
var recorde_sessao = 0

var usar_soma = true 
var usar_subtracao = false
var usar_multiplicacao = false
var usar_divisao = false

var velocidade_jogo = 50

func gerar_nova_conta() -> String:
	var operacoes_permitidas = []
	
	if usar_soma: operacoes_permitidas.append(0)
	if usar_subtracao: operacoes_permitidas.append(1)
	if usar_multiplicacao: operacoes_permitidas.append(2)
	if usar_divisao: operacoes_permitidas.append(3)
		
	var operacao_escolhida = operacoes_permitidas.pick_random()
	
	var num1 = randi_range(1, 10)
	var num2 = randi_range(1, 10)
	var texto_conta = ""
	
	match operacao_escolhida:
		0: # Soma
			pontos_da_rodada = 10 # <-- DEFINE OS PONTOS
			resposta_correta = num1 + num2
			texto_conta = str(num1) + " + " + str(num2)
		1: # Subtração
			pontos_da_rodada = 10 # <-- DEFINE OS PONTOS
			if num1 < num2:
				var temp = num1
				num1 = num2
				num2 = temp
			resposta_correta = num1 - num2
			texto_conta = str(num1) + " - " + str(num2)
		2: # Multiplicação
			pontos_da_rodada = 15 # <-- DEFINE OS PONTOS
			resposta_correta = num1 * num2
			texto_conta = str(num1) + " x " + str(num2)
		3: # Divisão
			pontos_da_rodada = 15 # <-- DEFINE OS PONTOS
			var produto = num1 * num2
			resposta_correta = num1 
			texto_conta = str(produto) + " ÷ " + str(num2)
			
	return texto_conta + " = ?"
