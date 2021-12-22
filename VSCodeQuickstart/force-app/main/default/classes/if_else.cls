public with sharing class if_else {
    public static void zerarValorBaseImovelPorStatus(Id idImovel) {
        Imovel__c imovel = ImovelBO.buscarImovelPorId(idImovel);
        
        if (imovel.Status__c == 'Disponível'){
            System.debug('Nova regra, imóvel zera valor quando Disponível');
            imovel.ValorBase__c = 0;
            update imovel;
        }if (imovel.Status__c == 'Vendido'){
            System.debug('O imóvel teve valor zerado');
            imovel.ValorBase__c = 0;
            update imovel;
        }else if(imovel.Status__c == 'Disponível') {
            System.debug('O imóvel teve o valor ajustado ');
            imovel.ValorBase__c = (imovel.ValorBase__c + 1000);
            update imovel;
        } else{
            System.debug('O imóvel não está vendido');
        }


    }












}
