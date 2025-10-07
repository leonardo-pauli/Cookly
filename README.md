🍳 Cookly: Aplicativo de Receitas com Arquitetura MVVM e Otimização.

Cookly é um aplicativo mobile de receitas desenvolvido em Flutter e Dart. Este projeto serve como um estudo prático e completo de arquitetura MVVM (Model-View-ViewModel), focando em código limpo, separação de responsabilidades e otimização de performance.

✨ Recursos e Destaques
Arquitetura MVVM: Separação estrita entre View (páginas), ViewModel (lógica de UI) e Repository (lógica de dados).

Otimização de Performance: Uso de Future.wait no Repositório para executar múltiplas chamadas de API (Look-up by Filter) simultaneamente, reduzindo drasticamente o tempo de carregamento da Home Page.

Persistência de Dados: Gerenciamento de favoritos persistente usando shared_preferences.

Design Profissional: Suporte completo a Dark Mode com temas Laranja e Preto, e navegação via BottomNavigationBar.

Funcionalidades: Home Page com filtro de categorias dinâmicas, busca por nome, lista de favoritos e tela de detalhes da receita.

🛠️ Tecnologias Utilizadas

Framework: Flutter

Linguagem: Dart

Gerenciamento de Estado: Provider (com ChangeNotifier)

Rede: http

Persistência Local: shared_preferences

API: TheMealDB


🚀 Como Rodar o Projeto Localmente
Pré-requisitos
Certifique-se de ter o Flutter SDK instalado e configurado em sua máquina.

1 - Clone o Repositório:

git clone https://github.com/leonardo-pauli/Cookly.git
cd Cookly

2 - Instale as Dependências:

flutter pub get
Execute o Aplicativo:

3 - flutter run

(Para testes de performance mais realistas, use flutter run --release)

🤝 Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir uma Issue para relatar bugs ou submeter um Pull Request com novas funcionalidades.

📜 Licença
Este projeto está licenciado sob a Licença MIT.
