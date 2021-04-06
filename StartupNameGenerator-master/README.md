# Startup Name Generator

Um app que gera no nomes randômicos para **startups**.

## Começando 
Este projeto faz parte dos tutoriais presentes no [Codelabs](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/#0).

## Usando um pacote externo

Para que a aplicação gere palavras (em inglês), antes configuramos um pacote open-source chamado `english_words`, do qual, além de 
possuir um monte de palavras mais usadas em inglês, também possui algumas funções uteis.

In **pubspec.yaml**
```
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^0.1.2
  english_words: ^3.1.0   # adicione esta linha
```
Então, clique em **Pub get**, do qual apresentará isto no console:
```
flutter packages get
Running "flutter packages get" in startup_namer...
Process finished with exit code 0
```
Pacote instalado, em **lib/main.dart** chamamos o pacote `english_words`
```
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; // adicione esta linha
```
Quando o pacote não está sendo usado, esta linha fica em cinza, pelo contrario quando está sendo usado a linha fica verde.

## Partes uteis do codigo

Em **lib/main.dart**, temos o seguinte codigo:
```
import 'package:flutter/material.dart'; 
import 'package:english_words/english_words.dart'; 


void main() => runApp(MyApp()); 

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) { 
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator', 
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // Prefixing an identifier with an underscore enforces privacy in the Dart language
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        if (index >= _suggestions.length) {
          
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

}
```
Os **widgets** com estado mantêm um estado que pode mudar durante a vida útil do **widget**. 
A implementação de um **widget** com monitoração de estado requer pelo menos duas classes: 
1) um `StatefulWidget` que cria uma instância de uma classe de estado. O objeto `StatefulWidget` é, por si só, imutável, 
mas o objeto `State` persiste durante o tempo de vida do **widget**.

No codigo acima temos: um **widget** com estado chamado `RandomWords`, do qual cria sua classe `State` chamada `RandomWordsState`

Então na classe `MyApp` (esta que é uma **widget** sem estado) usamos a `RandomWords`.

Neste app, que usuário rola, a lista(exibida em um **widget** `ListView`) aumenta infinitamente. O construtor de fábrica do construtor 
no `ListView` permite criar preguiçosamente uma exibição de lista sob demanda.

Na variavel `_suggestions` as palavras sugeridas são salvas, enquanto que, na variavel `_biggerFont` definimos o tamanho da fonte para 18.

**DICA:** Prefixar um identificador com um sublinhado reforça a privacidade no Dart.

Na função `_buildSuggestions()` construimos uma `ListView` com as palavras sugeridas. A classe `ListView` fornece uma propriedade do construtor, 
`itemBuilder`, que é uma função de construtor de fábrica e retorno de chamada especificada como uma função anônima. 
Dois parâmetros são passados para a função - o `BuildContext` e o iterador de linha, `i`. O iterador começa em 0 e aumenta sempre que a função é chamada, 
uma vez para cada emparelhamento de palavras sugerido. Esse modelo permite que a lista de sugestões cresça infinitamente à medida que o usuário rola.

A função `_buildSuggestions` chama a função `_buildRow` para cada palavra sugerida. Essa função exibe cada novo par em um `ListTile`, o que permite tornar as linhas mais atraentes.

## Observações

- Este exemplo cria um aplicativo Material. Material é uma linguagem de design visual padrão no celular e na web. 
O Flutter oferece um rico conjunto de widgets de materiais.

- O método `main` usa a notação de seta (=>). Use a notação de seta para funções ou métodos de uma linha.

- O aplicativo estende o `StatelessWidget`, o que torna o aplicativo em si um **widget**. No Flutter, quase tudo é um **widget**, incluindo alinhamento, preenchimento e layout.

- O widget `Scaffold`, da biblioteca Material, fornece uma barra de aplicativos padrão, um título e uma propriedade do corpo que contém a árvore do 
widget para a tela inicial. A subárvore do widget pode ser bastante complexa.

- A principal tarefa de um **widget** é fornecer um método de construção que descreva como exibir o widget em termos de outros widgets de nível inferior.

No codigo abaixo tem um detalhe: 
```
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
```
O corpo para este exemplo consiste em um **widget** `Center` contendo um **widget** `child: Text`. O **widget** `Center` alinha sua subárvore de **widget** ao centro da tela.
