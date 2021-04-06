# Trabalhando com banco de dados 

Desenvolvendo um app para que os usuarios escolham qual é o melhor nome para bebê. 

## Começando

Assim como qualquer outra aplicação é possivel popular variaveis com dados e apresentar na interface
```
final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];
```
Entretanto, para app mais sofisticados é possivel usar um banco de dados, neste caso o [Firebase](https://firebase.google.com/).

Basta seguir o tutorial:)


## Nota

Você também pode fazer alterações atômicas nos dados usando transações. Embora isso seja um pouco pesado para aumentar o 
total de votos, é a abordagem certa para mudanças mais complexas. 
Aqui está a aparência de uma transação que atualizou a contagem de votos.
```
onTap: () => Firestore.instance.runTransaction ((transaction) async {

freshSnapshot final = aguardar transaction.get (record.reference);

final fresco = Record.fromSnapshot (freshSnapshot);

aguardar transação

.update (record.reference, {'votos': fresh.votes + 1});

}),
```
Ao agrupar as operações de leitura e gravação em uma transação, você está dizendo ao 
**Cloud Firestore** para confirmar apenas uma alteração se não houver alterações externas 
nos dados subjacentes enquanto a transação estiver em execução. 
Se dois usuários não estiverem votando simultaneamente nesse nome específico, 
a transação será executada exatamente uma vez. Mas se o número de votos mudar entre as chamadas `transaction.get (...)` 
e `transaction.update (...)`, a execução atual não será confirmada e a transação será tentada novamente. 
Após 5 tentativas com falha, a transação falha

Para ter acesso as versões recentes dos pacotes entre em [Pub Dev](https://pub.dev/).
