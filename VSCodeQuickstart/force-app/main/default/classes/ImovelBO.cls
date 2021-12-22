public with sharing class ImovelBO {
    public static void atualizarNomeImovel (Id idImovel, String NomeEmpreendimento) {
        Imovel__c imovelAtualizar = new Imovel__c();
        imovelAtualizar.Id = idImovel;
        imovelAtualizar.NomeEmpreendimento__c = NomeEmpreendimento;

        update imovelAtualizar;
    }

    public static void criarImovel() {
        Id idTipoRegistroImovelCasa = Schema.SObjectType.Imovel__c.getRecordTypeInfosByDeveloperName().get('Casa').getRecordTypeId();

        Imovel__c imovelCriar = new Imovel__c();
        imovelCriar.NomeEmpreendimento__c = 'Casa Teste 3';
        imovelCriar.RecordTypeId = idTipoRegistroImovelCasa;
        imovelCriar.Status__c = 'Disponível';
        imovelCriar.Unidade__c = 'Teste';
        imovelCriar.Bloco__c = 'B';
        imovelCriar.PossuiSacada__c = false;
        imovelCriar.PossuiQuintal__c = true;
        imovelCriar.QuantidadeVagas__c = 1;
        imovelCriar.ValorBase__c = 150000;
        imovelCriar.metragem__c = 300;

        insert imovelCriar;

    
    }

    public static void removerImovel(Id idImovel){
        Imovel__c removerDaOrg = new Imovel__c();
        removerDaOrg.Id = idImovel;

        delete removerDaOrg;
    }
    
    public static Imovel__c buscarImovelPorId(Id idImovel){
        return [
          SELECT 
              Id,
              Valorbase__c,
              Metragem__c,
              Status__c
  
          FROM
              Imovel__c
          WHERE
              Id = : idImovel
          ];
        
    }
}