public with sharing class TratamentoExcecoes {
    public class ValorBaseException extends Exception {}

    public static void calcularValorBase() {
        try {
            Imovel__c imovel = new Imovel__c();

            if(imovel.ValorBase__c == null) {
                throw new ValorBaseException('O valor base é nulo');
            }

            Decimal valorBase = imovel.ValorBase__c * 10;
            System.debug(valorBase);
        } catch(ValorBaseException valorBaseExceptionError) {
            System.debug('Erro encontrado ValorBaseException => ' + valorBaseExceptionError.getMessage());
        } catch(NullPointerException nullPointerExceptionError) {
            System.debug('Erro encontrado NullPointer => ' + nullPointerExceptionError.getMessage());
            System.debug('Erro encontrado NullPointer => ' + nullPointerExceptionError.getStackTraceString());
        } catch(Exception exceptionError) {
            System.debug('Erro encontrado Generico => ' + exceptionError.getMessage());
        }
    }
}
