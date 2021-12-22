public with sharing class ImovelDAO {
    public static List<Imovel__c> buscarTodosOsImoveis() {
        return [
            SELECT 
                Id, 
                Name, 
                NomeEmpreendimento__c, 
                ValorBase__c,
                RecordType.DeveloperName
            FROM
                Imovel__c];
    }
}