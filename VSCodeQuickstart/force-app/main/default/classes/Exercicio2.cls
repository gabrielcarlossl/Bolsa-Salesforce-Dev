//EXERCICIO SOQL

//1
public with sharing class Exercicio2 {
    public static List<Imovel__c> buscarTodosImoveis() {
        return [
            SELECT 
                Id
                
            FROM
                Imovel__c];
    }

//2
    public static List<Imovel__c> buscarRecordTypeApartamento(){
        return [
            SELECT

                Id,
                RecordType.DeveloperName

            FROM

                Imovel__c

            WHERE 

                RecordType.DeveloperName = 'Apartamento'

        ];

    }

   //3
    public static Imovel__c buscarId(Id idImovel){
        return [
          SELECT 
              Id,
              Valorbase__c,
              Metragem__c
  
          FROM
              Imovel__c
          WHERE
              Id = : idImovel
          ];
        
    }
   
    public static Decimal calculoValorMetro(Id idImovel) {
          Imovel__c imovel = buscarId(idImovel);
          Decimal resultado = (imovel.Valorbase__c /  imovel.Metragem__c);
          System.debug(resultado);
          return resultado;

    }

    //4
    public static List<Imovel__c> maior1Milhao(){

        return [
            SELECT
                    
                    ValorBase__c

            FROM

                Imovel__c

            WHERE 

                ValorBase__c > 1000000
        ];

    }
    
//5
    public static List<AggregateResult> buscarVendidos(){

        return [
            SELECT 
                
                COUNT(Id) Qtd
                
            FROM
                Imovel__c

            WHERE 
                Status__c = 'Vendido'
            
        ];
    }

//6
    public static List<AggregateResult> somarVendidos(){
        return [
            SELECT
                SUM(ValorBase__c) Total
            FROM
                Imovel__c
            WHERE 
                Status__c = 'Vendido'
        ];
    }
//EXERCICIO DML 

   //1
    public static void criarImovel() {
        Id idTipoRegistroImovelCasa = Schema.SObjectType.Imovel__c.getRecordTypeInfosByDeveloperName().get('Casa').getRecordTypeId();

        Imovel__c imovelCriar = new Imovel__c();
        imovelCriar.NomeEmpreendimento__c = 'Casa 77 ';
        imovelCriar.RecordTypeId = idTipoRegistroImovelCasa;
        imovelCriar.Status__c = 'Disponível';
        imovelCriar.PossuiSacada__c = false;
        imovelCriar.PossuiQuintal__c = false;
        imovelCriar.QuantidadeVagas__c = 7;
        imovelCriar.ValorBase__c = 777777;
        imovelCriar.metragem__c = 777;

        insert imovelCriar;

    //2
    }

    public static void alterarStatus (Id idImovel) {
        Imovel__c statusAlterar = new Imovel__c();
        statusAlterar.Id = idImovel;
        statusAlterar.Status__c = 'Vendido';

        update statusAlterar;
    }
    //3
    public static void statusPersonalizado(Id idImovel, String novoStatus){
        Imovel__c personalizarStatus = new Imovel__c();
        personalizarStatus.Id = idImovel;
        personalizarStatus.Status__c = novoStatus;

        update personalizarStatus;
    }

    //4


    public static void novoValorBase(Id idImovel, Decimal porcentagem){
        Imovel__c novoValor = buscarId(idImovel);
        novoValor.Id = idImovel;
        novoValor.ValorBase__c = (novoValor.ValorBase__c + (porcentagem  * novoValor.ValorBase__c));

        System.debug(novoValor);
        update novoValor;

    }

    //5
    public static void removerImovel(Id idImovel){
        Imovel__c removerDaOrg = new Imovel__c();
        removerDaOrg.Id = idImovel;

        delete removerDaOrg;
    }
}
