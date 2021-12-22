public with sharing class Exercicio {
    public static Integer sum(Integer valor1, Integer valor2){
        
        Integer sumOfNumber = valor1 + valor2;

        System.debug(sumOfNumber);

        return sumOfNumber;
    }


    public static Integer sub(Integer valor1, Integer valor2){
        
        Integer subNumber = valor1 - valor2;

        System.debug(subNumber);

        return subNumber;
    }

    public static Integer mult(Integer valor1, Integer valor2){
        
        Integer multNumber = valor1 * valor2;

        System.debug(multNumber);

        return multNumber;
    }

    public static Double divide(Double valor1, Double valor2){
        
        Double divideNumber = valor1 / valor2;

        System.debug(divideNumber);

        return divideNumber;
    }

    public static String catenate(String text){
        
        String catenateText = text + ' #Everymind7anos ';

        System.debug(catenateText);

        return catenateText;
    }

    

}
