public with sharing class ColecoesBO {
    public static List<Imovel__c> buscarImovelPorId(Id idImovel) {
        return [
            SELECT
                Id,
                ValorBase__c,
                Metragem__c,
                Status__c,
                RecordType.DeveloperName
            FROM
                Imovel__c
        ];
    }

    public static List<Imovel__c> buscarImoveisPorSetId(Set<Id> setIdImovel) {
        return [
            SELECT
                Id,
                ValorBase__c,
                Metragem__c,
                Status__c,
                RecordType.DeveloperName,
                Name
            FROM
                Imovel__c
            WHERE
                Id IN :setIdImovel
        ];
    }

    public static void colecoesTeste() {
        /*Set<Id> setId = new Set<Id>();
        setId.add('a025f000005oEJtAAM');
        setId.add('a025f000005oE9HAAU');

        List<Imovel__c> listImoveisVendidos = new List<Imovel__c>();

        List<Imovel__c> listImoveis = buscarImoveisPorSetId(setId);

        for(Imovel__c item : listImoveis) {
            System.debug('-----------------------------------------------');
            System.debug('###### Percorrendo item ' + item.Name);
            System.debug('###### Status do Item ' + item.Status__c);
            if(item.Status__c == 'Vendido') {
                System.debug('###### item adicionado na lista');
                listImoveisVendidos.add(item);
            }
        }

        System.debug('###### listImoveisVendidos => ' + listImoveisVendidos);

        Map<Id, Imovel__c> mapImovelPorId = new Map<Id, Imovel__c>();

        for(Imovel__c item : listImoveis) {
            Imovel__c imovelRetornado = mapImovelPorId.get(item.Id);
        }*/


        Set<Id> setIdImovel = new Set<Id>();
        List<Imovel__c> listImovel = new List<Imovel__c>();
        List<PropostaCompra__c> listPropostaCompra = new List<PropostaCompra__c>();




        Map<Id, List<PropostaCompra__c>> mapListPropostaPorIdImovel = new Map<Id, List<PropostaCompra__c>>();

        listPropostaCompra = [SELECT Id, Imovel__c FROM PropostaCompra__c];

        for(PropostaCompra__c itemProposta : listPropostaCompra) {

            List<PropostaCompra__c> listPropostaPorImovel = mapListPropostaPorIdImovel.get(itemProposta.Imovel__c);

            if(listPropostaPorImovel == null) {
                listPropostaPorImovel = new List<PropostaCompra__c>();
            }

            listPropostaPorImovel.add(itemProposta);
            mapListPropostaPorIdImovel.put(itemProposta.Imovel__c, listPropostaPorImovel);
        }


        System.debug('###### mapListPropostaPorIdImovel => ' + JSON.serialize(mapListPropostaPorIdImovel));

        listImovel = buscarImoveisPorSetId(setIdImovel);

        
    }
}
