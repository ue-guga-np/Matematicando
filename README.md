# 🎮 Matematicando

> Jogo educativo desenvolvido na **Godot Engine 4.5** com foco no ensino de operações matemáticas básicas de forma divertida e interativa.

---

## 📖 Sobre o Projeto

**Matematicando** é um jogo de plataforma vertical no qual o jogador precisa resolver equações matemáticas para avançar. A cada resposta correta o personagem pula para a próxima plataforma; a cada erro, a zona de perigo se aproxima. O objetivo é acumular o máximo de pontos possível antes de ser alcançado pela área de dano.

O projeto foi desenvolvido como trabalho acadêmico na faculdade, unindo conceitos de **desenvolvimento de jogos** e **educação matemática**.

---

## 🕹️ Mecânicas de Jogo

| Mecânica | Descrição |
|---|---|
| **Equações** | Equações de soma, subtração, multiplicação e/ou divisão são geradas aleatoriamente. |
| **Respostas** | Três alternativas são apresentadas (uma correta e duas incorretas), embaralhadas a cada rodada. |
| **Acerto** | O jogador ganha pontos (10 pts para soma/subtração, 15 pts para multiplicação/divisão) e o personagem pula para a plataforma seguinte. |
| **Erro** | O jogador perde 5 pontos (mínimo 0) e a área de dano se aproxima em 100 pixels. |
| **Área de Dano** | Sobe continuamente com velocidade configurável. Quando toca o jogador, o jogo acaba. |
| **Recorde** | O maior score da sessão é salvo e exibido na tela inicial. |

---

## ⚙️ Configurações (Tela Inicial)

Na tela inicial o jogador pode personalizar a partida antes de começar:

- **Operações Disponíveis**: Soma (sempre ativa), Subtração, Multiplicação e Divisão podem ser ativadas/desativadas via checkboxes.
- **Dificuldade (Velocidade)**: Três níveis de velocidade da área de dano — Fácil (25), Médio (50) e Difícil (75).

---

## 🗂️ Estrutura do Projeto

```
Matematicando/
├── assets/                     # Recursos visuais e fonte
│   ├── Super Adorable.ttf      # Fonte customizada do jogo
│   ├── area_dano.png           # Sprite da área de perigo
│   ├── cenário.png             # Imagem de fundo do cenário
│   ├── menu.png                # Imagem de fundo do menu
│   ├── fim de jogo.png         # Imagem de fundo do Game Over
│   ├── plataforma.png          # Sprite das plataformas
│   ├── player_parado.png       # Sprite do jogador parado
│   ├── player_pulo.png         # Sprite do jogador pulando
│   ├── play.png                # Botão de iniciar
│   ├── botão_fácil.png         # Botão de dificuldade fácil
│   ├── botão_médio.png         # Botão de dificuldade médio
│   ├── botão_difícil.png       # Botão de dificuldade difícil
│   ├── botão_voltar.PNG        # Botão de voltar
│   └── botão_fim.png           # Botão da tela de game over
│
├── scenes/                     # Cenas do Godot (.tscn)
│   ├── TelaInicial.tscn        # Cena do menu principal
│   ├── Level.tscn              # Cena do jogo (gameplay)
│   ├── GameOver.tscn           # Cena de fim de jogo
│   ├── Hud.tscn                # Interface do jogador (HUD)
│   ├── Player.tscn             # Cena do personagem
│   └── Plataforma.tscn         # Cena da plataforma reutilizável
│
├── scripts/                    # Scripts GDScript
│   ├── GeradorDeEquacoes.gd    # Autoload — gera equações e armazena estado global
│   ├── TelaInicial.gd          # Lógica do menu principal
│   ├── Level.gd                # Lógica do gameplay (plataformas, pontos, perigo)
│   ├── Player.gd               # Movimentação e física do jogador
│   ├── GameOver.gd             # Tela de fim de jogo (reiniciar / voltar)
│   └── ControladorDoJogo.gd    # Controlador auxiliar de pontuação
│
├── project.godot               # Arquivo de configuração do projeto Godot
├── export_presets.cfg          # Configuração de exportação (Windows Desktop)
├── icon.png / icon.svg         # Ícones do projeto
└── iconeJogo.png               # Ícone personalizado do jogo
```

---

## 📜 Descrição dos Scripts

### `GeradorDeEquacoes.gd` (Autoload / Singleton)
Responsável por gerar as equações matemáticas aleatórias. Mantém o **estado global** do jogo, incluindo:
- Operações habilitadas (soma, subtração, multiplicação, divisão)
- Velocidade do jogo (dificuldade)
- Resposta correta da rodada atual
- Pontos da rodada (varia por operação)
- Recorde da sessão

### `TelaInicial.gd`
Controla o menu principal. Permite ao jogador configurar quais operações deseja praticar, selecionar a dificuldade e iniciar o jogo. Exibe o recorde da sessão.

### `Level.gd`
Coração do gameplay. Gerencia:
- Geração e posicionamento de plataformas
- Exibição de equações e alternativas (com respostas embaralhadas)
- Sistema de pontuação (acerto/erro)
- Movimentação da área de dano
- Detecção de Game Over quando a área de dano colide com o jogador
- Acompanhamento da câmera seguindo o jogador

### `Player.gd`
Controla a física do personagem (gravidade e pulo). Alterna entre dois sprites — parado e pulando — conforme o estado da velocidade vertical.

### `GameOver.gd`
Exibe a pontuação final, salva o recorde se necessário, e oferece opções para reiniciar a fase ou voltar à tela inicial.

### `ControladorDoJogo.gd`
Script auxiliar/legado que contém lógica base de pontuação e comunicação com o HUD e o Player.

---

## 🛠️ Tecnologias Utilizadas

- **Motor de Jogo**: [Godot Engine 4.5](https://godotengine.org/) (GL Compatibility)
- **Linguagem**: GDScript
- **Renderização**: GL Compatibility (compatível com desktop e mobile)
- **Plataforma de Exportação**: Windows Desktop (x86_64)
- **Versionamento**: Git

---

## 🚀 Como Executar

### Pré-requisitos
- [Godot Engine 4.5+](https://godotengine.org/download/) instalado

### Passos
1. Clone o repositório:
   ```bash
   git clone https://github.com/ue-guga-np/Matematicando.git
   ```
2. Abra o **Godot Engine 4.5**.
3. Clique em **Importar** e selecione o arquivo `project.godot` na raiz do projeto.
4. Pressione **F5** (ou clique em ▶️) para executar o jogo.

---

## 📱 Compatibilidade

O projeto está configurado com:
- Resolução: **1280×720**
- Modo de esticamento: `canvas_items` com aspecto `expand`
- Emulação de toque via mouse habilitada — pronto para adaptação mobile

---

## 👥 Colaboradores

| Nome | Função | Contato |
|---|---|---|
| Giovanna Beatriz Ramos | Arte & UI/UX Design | https://www.linkedin.com/in/giovanna-beatriz-ramos-a87711293/ |
| Gustavo Alexandro Pelissari | Programação & Game Design | https://www.linkedin.com/in/gustavo-pelissari-180505291/ |
| Igor Henrique Koga Vigato | Programação & Game Design | https://www.linkedin.com/in/igor-koga-021031292/ |
| João Gabriel De Araújo Meira | Programação & Game Design | https://www.linkedin.com/in/jo%C3%A3o-gabriel-de-ara%C3%BAjo-meira-93801b406/ |

---

## 📄 Licença

Este projeto foi desenvolvido única e exclusivamente para fins acadêmicos e educacionais. Ele não pode ser comercializado, distribuído ou utilizado para quaisquer fins que gerem monetização ou lucro.

---

<p align="center">
  Feito com ❤️ e Godot Engine 🎮
</p>
