# Um Simples Chat App

Chat app desenvolvido em Flutter

## Notas 

Fonte: https://codelabs.developers.google.com/codelabs/flutter/#0

Você descreve a parte da interface do usuário representada por um **widget** em seu método de construção. 
A estrutura chama os métodos `build ()` para `FriendlychatApp` ou `ChatScreen` ao inserir esses **widgets** na hierarquia de **widgets** e quando suas dependências mudam.

`@override` é uma anotação **Dart** que indica que o método marcado substitui o método de uma superclasse.

Alguns **widgets**, como `Scaffold` e `AppBar`, são específicos para aplicativos de **Material Design**. Outros **widgets**, como texto, são genéricos e 
podem ser usados em qualquer aplicativo. **Widgets** de diferentes bibliotecas na estrutura do **Flutter** são compatíveis e podem trabalhar juntos em um único 
aplicativo.

`TextField`: É um **widget** com monitoração de estado (um **widget** que possui estado mutável) com propriedades para personalizar o comportamento do 
campo de entrada. Estado são informações que podem ser lidas de forma síncrona quando o widget é construído e que podem mudar durante a vida útil do **widget**. 
A adição do primeiro **widget** com estado ao `Friendlychat` exige algumas modificações.

No **Flutter**, se você deseja apresentar visualmente os dados com estado em um **widget**, encapsule esses dados em um objeto `State`. 
Você pode associar seu objeto `State` a um **widget** que estende a classe `StatefulWidget`.

Classe `Icon`: https://api.flutter.dev/flutter/material/Icons-class.html

**Dica:** Na sintaxe do Dart, usar a seta `=>` é uma abreviação para `{ return expression; }`. 

Para personalizar o **widget** `CircleAvatar`, identifique-o com a primeira inicial do usuário, passando o primeiro caractere do valor da variável `_name` para um **widget** de texto filho. 
Usando `CrossAxisAlignment.start` como o argumento `crossAxisAlignment` do construtor `Row` para posicionar o avatar e as mensagens em relação aos **widgets** pai.

Para o avatar, o pai é um **widget** de Linha cujo eixo principal é horizontal; portanto, `CrossAxisAlignment.start` fornece a posição mais alta ao longo do eixo vertical. Para mensagens, 
o pai é um **widget** de Coluna cujo eixo principal é vertical; portanto, `CrossAxisAlignment.start` alinha o texto na posição mais à esquerda do eixo horizontal.

Ao lado do avatar, alinhe dois **widgets** de texto verticalmente para exibir o nome do remetente na parte superior e o texto da mensagem abaixo. 
Para estilizar o nome do remetente e torná-lo maior que o texto da mensagem, você precisará usar `Theme.of (context)` para obter um objeto `ThemeData` apropriado. 
Sua propriedade `textTheme` fornece acesso aos estilos lógicos do Design de materiais para textos como subtítulos, para que você possa evitar tamanhos de fonte codificados e outros atributos de texto.

`Column`: que estabelece seus filhos diretos verticalmente. A coluna pode ter vários **widgets** filhos, que serão uma lista de rolagem e uma linha para um campo de entrada.

`Flexíble`: como pai do `ListView`. Isso informa à estrutura para permitir que a lista de mensagens recebidas se expanda para preencher a altura da coluna enquanto o `TextField` permanece com um tamanho fixo.

`Divider`: para desenhar uma regra horizontal entre a interface do usuário para exibir mensagens e o campo de entrada de texto para compor mensagens.

`Container`: como pai do compositor de texto, útil para definir imagens de fundo, preenchimento, margens e outros detalhes comuns de **layout**. 
Use a decoração para criar um novo objeto `BoxDecoration` que define a cor do plano de fundo. Nesse caso, estamos usando o `cardColor` definido pelo objeto `ThemeData` do tema padrão. 
Isso fornece à interface do usuário para compor as mensagens um plano de fundo diferente da lista de mensagens.
Passe argumentos para o construtor `ListView.builder` para personalizar o conteúdo e a aparência da lista:

- `padding`: para espaço em branco ao redor do texto da mensagem
- `reverse`: para fazer o `ListView` iniciar na parte inferior da tela
- `itemCount`: para especificar o número de mensagens na lista
- `itemBuilder`: para uma função que cria cada **widget** em `[index]`. Como não precisamos do contexto de compilação atual, 
podemos ignorar o primeiro argumento do `IndexedWidgetBuilder`. Nomear o argumento `_` (sublinhado) é uma convenção para indicar que ele não será usado

A classe `AnimationController` permite definir características importantes da animação, como duração e direção da reprodução (avançar ou retroceder).
Ao criar um `AnimationController`, você deve transmitir a ele um argumento `vsync`. O `vsync` impede que as animações que estão fora da tela consumam recursos desnecessários. 
Para usar o `ChatScreenState` como `vsync`, inclua um **mixin** `TickerProviderStateMixin` na definição de classe `ChatScreenState`.

No **Dart**, um **mixin** permite que um corpo de classe seja reutilizado em várias hierarquias de classes. Para obter mais informações, consulte Classes, 
uma seção no [Dart Language Tour](https://dart.dev/guides/language/language-tour).

- Acelere ou diminua o efeito da animação modificando o valor da duração especificado no método `_handleSubmitted ()`.
- Especifique diferentes curvas de animação usando as constantes definidas na classe `Curves`.
- Crie um efeito de animação fade-in envolvendo o `Container` em um **widget** `FadeTransition` em vez de um `SizeTransition`.

Quando um usuário envia um texto que excede a largura da interface do usuário para exibir mensagens, as linhas devem ser quebradas 
para que a mensagem inteira seja exibida. No momento, as linhas que excedem são truncadas e uma mensagem de erro é exibida. 
Uma maneira simples de garantir que o texto ocorra corretamente é adicionar o `Expanded`.
```
...

new Expanded(                                               
  child: new Column(                                   
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Text(_name, style: Theme.of(context).textTheme.subhead),
      new Container(
        margin: const EdgeInsets.only(top: 5.0),
        child: new Text(text),
      ),
    ],
  ),
),                                                          

...
```
