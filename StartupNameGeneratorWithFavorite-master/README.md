# Startup App

Continuando a partir do ultimo app desenvolvido, vamos adicionar as seguintes funcionalidades: Favoritar uma palavra
da lista e apresentar a palavra escolhida em uma pagina.

Fonte: https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#0

## Codigo

Em **lib/main.dart** temos o seguinte codigo:
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
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

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
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
```
A varivel `_saved` é um `Set`, ou conjunto que não permite duplicatas e armazena as palavras favoritadas pelo usuario.

Dentro da função `_buildRow`, teremos a variavel `alreadySaved`, do qual, verifica se um emparelhamento de palavras ainda
não foi adicionado aos favoritos. Esta variavel estará vinculada ao icone de favoritos e quando clicado ficará vermelho.

Ainda dentro da função `_buildRow` temos a função a função `onTap: setState()`, do qual permite que o adicionamos uma palavra aos
favoritos ao clicar no respectivo icone; e ao clicar novamente no icone de favorito da palavra já existente na lista de 
favoritos removemos ele da lista. 

No Flutter, o Navegador gerencia uma pilha contendo as rotas do aplicativo. Empurrando uma rota para a pilha do Navegador, 
atualiza a exibição para essa rota. Ao sair de uma rota da pilha do Navegador, retorna a exibição para a rota anterior.

Dentro de `RandomWordsState` temos uma nova pagina além da principal representado pleo icone da lista, onde será os favoritos
ficarão. A função que dá vida a esse icone é o `_pushSaved()`, do qual possui o `MaterialPageRoute` e seu construtor. 
Por enquanto, adicione o código que gera as linhas `ListTile`. O método `divideTiles()` do `ListTile` adiciona espaçamento horizontal entre cada `ListTile`. 
A variável dividida mantém as linhas finais, convertidas em uma lista pela função de conveniência, `toList()`.

A propriedade do construtor retorna um `Scaffold`,contendo a barra de aplicativos para a nova rota, denominada "Sugestões salvas". 
O corpo da nova rota consiste em um `ListView` contendo as linhas `ListTiles`; cada linha é separada por um divisor.

Para alterar o tema de um app devemos configurar a classe `ThemeData`  dentro da classe `MyApp`. Neste app, mudamos a
cor padrão para branco
```
theme: ThemeData(         
        primaryColor: Colors.white,
      ),  
```

**DICA:** Usando a opção **Flutter Hot Reload** no Android Studio conseguimos recarregar o app rapidamente. Muito mais
rápido que o **Run** ou `F5`. 