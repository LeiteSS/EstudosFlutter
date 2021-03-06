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
A varivel `_saved` ?? um `Set`, ou conjunto que n??o permite duplicatas e armazena as palavras favoritadas pelo usuario.

Dentro da fun????o `_buildRow`, teremos a variavel `alreadySaved`, do qual, verifica se um emparelhamento de palavras ainda
n??o foi adicionado aos favoritos. Esta variavel estar?? vinculada ao icone de favoritos e quando clicado ficar?? vermelho.

Ainda dentro da fun????o `_buildRow` temos a fun????o a fun????o `onTap: setState()`, do qual permite que o adicionamos uma palavra aos
favoritos ao clicar no respectivo icone; e ao clicar novamente no icone de favorito da palavra j?? existente na lista de 
favoritos removemos ele da lista. 

No Flutter, o Navegador gerencia uma pilha contendo as rotas do aplicativo. Empurrando uma rota para a pilha do Navegador, 
atualiza a exibi????o para essa rota. Ao sair de uma rota da pilha do Navegador, retorna a exibi????o para a rota anterior.

Dentro de `RandomWordsState` temos uma nova pagina al??m da principal representado pleo icone da lista, onde ser?? os favoritos
ficar??o. A fun????o que d?? vida a esse icone ?? o `_pushSaved()`, do qual possui o `MaterialPageRoute` e seu construtor. 
Por enquanto, adicione o c??digo que gera as linhas `ListTile`. O m??todo `divideTiles()` do `ListTile` adiciona espa??amento horizontal entre cada `ListTile`. 
A vari??vel dividida mant??m as linhas finais, convertidas em uma lista pela fun????o de conveni??ncia, `toList()`.

A propriedade do construtor retorna um `Scaffold`,contendo a barra de aplicativos para a nova rota, denominada "Sugest??es salvas". 
O corpo da nova rota consiste em um `ListView` contendo as linhas `ListTiles`; cada linha ?? separada por um divisor.

Para alterar o tema de um app devemos configurar a classe `ThemeData`  dentro da classe `MyApp`. Neste app, mudamos a
cor padr??o para branco
```
theme: ThemeData(         
        primaryColor: Colors.white,
      ),  
```

**DICA:** Usando a op????o **Flutter Hot Reload** no Android Studio conseguimos recarregar o app rapidamente. Muito mais
r??pido que o **Run** ou `F5`. 