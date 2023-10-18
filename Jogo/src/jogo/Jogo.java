package Jogo;

/* @author 
  Grupo 12:
   William Alexsander Santos Siqueira
   Richard Madson
   Emanuel Joaquim
   Antonio Correa

*/

import java.util.Random;
import java.util.Scanner;

public class Jogo {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.print("Digite o nome do Guerreiro: ");
            String nomeGuerreiro = scanner.nextLine();

            Guerreiro guerreiro1 = new Guerreiro(nomeGuerreiro);
            guerreiro1.setVidas();

            System.out.print("Digite o nome do Oraculo: ");
            String nomeOraculo = scanner.nextLine();

            Oraculo oraculo1 = new Oraculo(nomeOraculo, guerreiro1);

            String introducao = prologoIntroducao(oraculo1);
            System.out.println(introducao);

            menuDeJogos(oraculo1, scanner);
        }
    }

    private static String prologoIntroducao(Oraculo oraculo) {
        String nomeOraculo = oraculo.getNome();
        String nomeGuerreiro = oraculo.getWarrior().getNome();
        int qtdVidasGuerreiro = oraculo.getWarrior().getQtdVidas();

        String introducao = "Nome do Oraculo: " + nomeOraculo + "\n" +
                "Nome do Guerreiro: " + nomeGuerreiro + "\n" +
                "Quantidade de Vidas do Guerreiro: " + qtdVidasGuerreiro;

        return introducao;
    }

    private static void menuDeJogos(Oraculo oraculo, Scanner scanner) {
        int escolha;

        do {
            System.out.println("\nEscolha um jogo:");
            System.out.println("1. Adivinhacao de Numero");
            System.out.println("2. Par ou Impar");
            System.out.println("3. Pedir Vida Extra");
            System.out.println("4. Sair do Menu de Jogos");
            System.out.print("Escolha: ");
            escolha = scanner.nextInt();

            switch (escolha) {
                case 1 -> jogarAdivinhacao(oraculo, scanner);
                case 2 -> jogarParOuImpar(oraculo, scanner);
                case 3 -> pedirVidaExtra(oraculo, scanner);
                case 4 -> System.out.println("Saindo do Menu de Jogos.");
                default -> System.out.println("Escolha invalida. Tente novamente.");
            }
        } while (escolha != 4);
    }

    private static void jogarAdivinhacao(Oraculo oraculo, Scanner scanner) {
   
        boolean vitoria = true; 
        if (vitoria) {
            System.out.println(prologoVencedor(oraculo));
        } else {
            System.out.println(prologoPerdedor(oraculo));
        }
    }

 private static void jogarParOuImpar(Oraculo oraculo, Scanner scanner) {
    Random random = new Random();
    int numeroAleatorio = random.nextInt(11); // Gere um número aleatório de 0 a 10

    System.out.print("Escolha (Par/Impar): ");
    String escolha = scanner.next();

    if (!(escolha.equalsIgnoreCase("Par") || escolha.equalsIgnoreCase("Ímpar"))) {
        System.out.println("Escolha invalida. Tente novamente.");
        return; // Saia do método se a escolha for inválida
    }

    System.out.print("Digite um number (0-10): ");
    int numeroJogador = scanner.nextInt();

    int soma = numeroAleatorio + numeroJogador;
    boolean vitoria = (soma % 2 == 0 && escolha.equalsIgnoreCase("Par")) || (soma % 2 != 0 && escolha.equalsIgnoreCase("Impar"));

    if (vitoria) {
        System.out.println("Vc venceu! A soma eh " + soma + ", que eh " + escolha + ".");
    } else {
        System.out.println("Vc perdeu! A soma eh " + soma + ", que nao eh " + escolha + ".");
    }
}
      private static boolean concederVidaExtra(String pedidoMisericordia) {
    String[] palavras = pedidoMisericordia.split("\\s+");

    int numeroPalavras = palavras.length;
    return numeroPalavras > 5;
}
    
   private static void pedirVidaExtra(Oraculo oraculo, Scanner scanner) {
    scanner.nextLine(); 
    System.out.print("Guerreiro pede arrego. (Digite seu pedido): ");
    String pedidoMisericordia = scanner.nextLine();

    boolean concedeVidaExtra = concederVidaExtra(pedidoMisericordia);

    if (concedeVidaExtra) {
        System.out.println("Vida Extra concedida!");
        oraculo.getWarrior().adicionarVidaExtra();
    } else {
        System.out.println("Pedido de arrego negado.");
    }
}

    private static String prologoVencedor(Oraculo oraculo) {
        return "Congratulations, Guerreiro " + oraculo.getWarrior().getNome() + "! Vc h um VENCEDOR!";
    }

    private static String prologoPerdedor(Oraculo oraculo) {
        return "Guerreiro " + oraculo.getWarrior().getNome() + ", vc nao conseguiu vencer desta vez. Melhor sorte na proxima!";
    }
}

class Guerreiro {                              // Classe Guerreiro 
    private int qtdVidas;
    private String nome;

    public Guerreiro(String nome) {
        this.nome = nome;
    }

    public void setVidas() {
        Random random = new Random();
        this.qtdVidas = random.nextInt(4) + 9;
    }

    public int getQtdVidas() {
        return qtdVidas;
    }

    public String getNome() {
        return nome;
    }

    public void adicionarVidaExtra() {
        qtdVidas++;
    }
}

class Oraculo {                           // Classe Oraculo
    private final String nome;
    private final Guerreiro warrior;

    public Oraculo(String nome, Guerreiro warrior) {
        this.nome = nome;
        this.warrior = warrior;
    }

    public String getNome() {
        return nome;
    }

    public Guerreiro getWarrior() {
        return warrior;
    }

}