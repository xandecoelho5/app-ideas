import { Component } from "@angular/core";

class Opcao {
  nome: string;
  correta?: boolean;
}

class Questao {
  pergunta: string;
  opcoes: Opcao[];

  constructor(pergunta: string, opcoes: Opcao[]) {
    this.pergunta = pergunta;
    this.opcoes = opcoes;
  }
}

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"],
})
export class HomeComponent {
  showCard: boolean;
  acertou: boolean;

  question1 = this.createQuestao("Qual é a cor do leite?", [
    this.createOpcao("1 - Azul"),
    this.createOpcao("2 - Branco", true),
    this.createOpcao("3 - Amarelo"),
    this.createOpcao("4 - Roxo"),
  ]);

  question2 = this.createQuestao("Qual a cor do seu teclado?", [
    this.createOpcao("1 - Azul"),
    this.createOpcao("2 - Branco"),
    this.createOpcao("3 - Amarelo"),
    this.createOpcao("4 - Preto", true),
  ]);

  questions = [this.question1, this.question2];
  currentQuestion: Questao;
  counter: number;

  constructor() {
    this.showCard = false;
    this.acertou = false;
    this.counter = 0;
    this.currentQuestion = this.questions[this.counter];
  }

  showConsole(opcao: Opcao) {
    if (opcao.correta) {
      this.acertou = true;
    } else {
      console.log("Resposta errada");
    }
  }

  createOpcao(nome: string, correta?: boolean): Opcao {
    const opcao = new Opcao();
    opcao.nome = nome;
    opcao.correta = correta ? correta : false;
    return opcao;
  }

  createQuestao(pergunta: string, opcoes: Opcao[]): Questao {
    return new Questao(pergunta, opcoes);
  }

  nextWord() {
    this.counter++;
    this.currentQuestion = this.questions[this.counter];
    this.acertou = false;
  }
}
