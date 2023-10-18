package iptuvv;

import java.util.Date;
import java.util.Scanner;

/* @author 
  Grupo 12:
   William Alexsander Santos Siqueira
   Richard Madson
   Emanuel Joaquim
   Antonio Correa

*/

class Iptuvv {
    
    String nomeProprietario;
    double impostoAnual;
    int mesesAtraso;

    public Iptuvv(String nomeProprietario, double impostoAnual, int mesesAtraso) {
        
        Date relogio = new Date();
        System.out.println("A hora do sistema e:");
        System.out.println(relogio.toString());
        
        this.nomeProprietario = nomeProprietario;
        this.impostoAnual = impostoAnual;
        this.mesesAtraso = mesesAtraso;
       
    } // iptuvv
    
    public double calcularMulta(){                        // Calculo do valor corrigido com base nos meses em atraso.
             if (mesesAtraso == 0) {
            return 0;
        } else if (mesesAtraso <= 5) {
            return impostoAnual * 0.01 * mesesAtraso;    // 1%
        } else if (mesesAtraso <= 8) {
            return impostoAnual * 0.023 * mesesAtraso;   // 2.3%
        } else if (mesesAtraso <= 10) {
            return impostoAnual * 0.03 * mesesAtraso;   // 3%
        } else if (mesesAtraso <= 12) {
            return impostoAnual * 0.054 * mesesAtraso;  // 5.4%
        } else {
            return impostoAnual * 0.1 * mesesAtraso;
        } 
    } // calcularmulta
    
      public static void main(String[] args) {         // Scanner de informações dadas pelo usuário
        Scanner scanner = new Scanner(System.in);

          System.out.println("CALCULO DE IPTU");
        System.out.print("Nome do proprietario: ");
        String nomeProprietario = scanner.nextLine();        // Nome Proprietario

        System.out.print("Valor do imposto a ser pago[em R$]: ");
        double impostoAnual = scanner.nextDouble();         // Valor total do imposto

        System.out.print("Quantidade de meses de atraso: ");
        int mesesAtraso = scanner.nextInt();                // Meses de atraso

        Iptuvv iptuvv = new Iptuvv(nomeProprietario, impostoAnual, mesesAtraso);
        double multa = iptuvv.calcularMulta();

        System.out.println("A multa a ser paga pelo proprietario " + nomeProprietario + " eh de R$" + multa); // @return valor da multa
    
}

 } // fim
