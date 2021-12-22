public with sharing class Exercicio4 {

    //1
    public List<Imovel__c> buscarImoveisCasaComQuintal() {
        return [
            SELECT
                Id, 
                Name,
                PossuiQuintal__c,
                RecordType.DeveloperName
            FROM
                Imovel__c
            WHERE
                RecordType.DeveloperName = 'Casa'
            AND
                PossuiQuintal__c = true
        ];
    }

    public static List<Imovel__c> buscarImoveisComQuintalLoop(){
        List<Imovel__c> listImovel = [SELECT Id, Name, PossuiQuintal__c, RecordType.DeveloperName FROM Imovel__c];
        List<Imovel__c> listImovelCasaComQuintal = new List<Imovel__c>();

        for (Imovel__c imovel : listImovel){
            if (imovel.PossuiQuintal__c && imovel.RecordType.DeveloperName == 'Casa'){
                listImovelCasaComQuintal.add(imovel);
            }
        }


        return listImovelCasaComQuintal;
    }
    //2

    public List<Imovel__c> buscarImoveisCasaSacada() {
        return [
            SELECT
                Id, 
                Name,
                PossuiSacada__c,
                RecordType.DeveloperName
            FROM
                Imovel__c
            WHERE
                RecordType.DeveloperName = 'Apartamento'
            AND
                PossuiSacada__c = true
        ];
    }
    
    public static List<Imovel__c> buscarImoveisComSacadaLoop(){
        List<Imovel__c> listImovel = [SELECT Id, Name, PossuiSacada__c, RecordType.DeveloperName FROM Imovel__c];
        List<Imovel__c> listImovelCasaComSacada = new List<Imovel__c>();

        for (Imovel__c imovel : listImovel){
            if (imovel.PossuiSacada__c && imovel.RecordType.DeveloperName == 'Apartamento'){
                listImovelCasaComSacada.add(imovel);
            }
        }


        return listImovelCasaComSacada;
    }

    //3
    public static Imovel__c buscarImovelMaiorValor(){
        List<Imovel__c> listImovel = [SELECT Id, Status__c, NomeEmpreendimento__c, ValorBase__c FROM Imovel__c ORDER BY ValorBase__c DESC];
    
        return listImovel[0];
    }

    //4
    public static List<AggregateResult> buscarPropostaMaior(){
        return [
            SELECT 
                MAX(Valor__c) 
            FROM 
                PropostaCompra__c];
    }
//5
    public static List<AggregateResult> buscarMaiorMetragem(){
        return [
            SELECT 
                MAX(Metragem__c) 
            FROM 
                Imovel__c];
    }

}
