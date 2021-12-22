public with sharing class ImovelBO {
public class StatusException extends Exception{}
public class DataRetroativaException extends Exception{}
public class ValorInvalidoException extends Exception{}
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
    
   /* public static Imovel__c buscarImovelPorId(Id idImovel){
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

    */


    /*
    public static Decimal recalcularValor(Id idImovel) {
        Decimal valorBaseCalculado = 0;
        Imovel__c imovel = buscarImovelPorId(idImovel);

        if (imovel.RecordType.DeveloperName == 'Apartamento'){
            valorBaseCalculado = imovel.ValorBase__c + (imovel.ValorBase__c * 0.04);
        } else if (imovel.RecordType.DeveloperName == 'Casa'){
            valorBaseCalculado = imovel.ValorBase__c + (imovel.ValorBase__c * 0.02);
        } else {
            valorBaseCalculado = imovel.ValorBase__c;
        }

        return valorBaseCalculado;
    }


    public static void criarPropostaCompra(Id idImovel, Id idContato, Id idVendedor, Decimal valor, Date dataProposta, Date dataChave ){
        
        try {
        
            Imovel__c imovel = buscarImovelPorId(idImovel);
            Date dataAtual = Date.Today();

            if (imovel.Status__c == 'Reservado' || imovel.Status__c == 'Vendido'){
                throw new StatusException ('O Status do imóvel é vendido ou Reservado, então não pode ser gerada uma proposta de compra');
            }

            if (dataAtual< dataProposta){
                throw new DataRetroativaException('A data da proposta é menor quuue a data Atual.');
            }
            if (valor <=0){
                throw new ValorInvalidoException('Vlor da proposta inválido, tente enviar um valor maior que 0.');
            }



            PropostaCompra__c propostaCompra = new PropostaCompra__c();

            PropostaCompra__c.Imovel__c = idImovel;
            PropostaCompra__c.Contato__c = idContato;
            PropostaCompra__c.Vendedor__c = idVendedor;
            PropostaCompra__c.Valor__c = valor;
            PropostaCompra__c.Data__c = dataProposta;
            PropostaCompra__c.DataEntregaChaves__c = dataChave;

            insert propostaCompra;
        
        } catch (DataRetroativaException erroDataException){
            System.debug('Data Exception => ' + erroDataException.getMessage());
        } catch(ValorInvalidoException erroValorException){
            System.debug('Valor Exception => ' + erroValorException.getMessage());
        } catch (StatusException erroStatusException){
            System.debug('Status Exception =>' + erroStatusException.getMessage());
        } catch (DmlException erroDmlException){
            System.debug('Dml Exception => ' + erroDmlException.getMessage());
        } catch (Exception erroException) {
            System.debug('Exception genérica');
        }

        
    }
    */

    public static List<Imovel__c> buscarImovelPorId(Id idImovel){
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

    public static List<Imovel__c> buscarImoveisPorSetId(Set<Id> setIdImovel){
        return [
            SELECT 
                Id,
                ValorBase__c,
                Metragem__c,
                Status__c,
                RecordType.DeveloperName
            FROM
                Imovel__c
            WHERE 
                Id IN :setIdImovel
        ];
    }



    public static void colecoesTeste(){

        Set<Id> setId = new Set<Id>();
        setId.add('');

        List<Imovel__c> listImoveisVendidos = new List<Imovel__c>();

        List<Imovel__c> listImoveis = buscarImoveisPorSetId(setId);

        for (Imovel__c item : listImoveis){
            System.debug('Percorrendo item ' + item.Name);
            System.debug('Status do Item ' + item.Status__c);

            if (item.Status__c == 'Vendido') {
                System.debug('Adicionando item.');
                listImoveisVendidos.add(item);
            }

            System.debug(item.Name);
        }
        
        System.debug('###### listImoveisVendidos =>' + listImoveisVendidos);

        Map<Id, Imovel__c> mapImovelPorId = new Map<Id, Imovel__c>();
        
        for (Imovel__c item : listImoveis){
            mapImovelPorId.put(item.Id, item);
        }

        for (Imovel__c item : listImoveis){
            Imovel__c imovelRetornado = mapImovelPorId.get(item.Id);
        }




        Set<Id> setIdImovel = new Set<Id>();
        List<Imovel__c> listImovel = new List<Imovel__c>();
        List<PropostaCompra__c> listPropostaCompra = new List<PropostaCompra__c>();

        Map<Id,List<PropostaCompra__c>> mapListPropostaPorIdImovel = new Map<Id, List<PropostaCompra__c>>();

        listPropostaCompra = [SELECT Id, Imovel__c FROM PropostaCompra__c];

        for (PropostaCompra__c itemProposta : listPropostaCompra){
            setIdImovel.add(itemProposta.Imovel__c);
            List<PropostaCompra__c> listPropostaPorImovel = mapListPropostaPorIdImovel.get(itemProposta.Imovel__c);
            
            if (listPropostaPorImovel ==null){
                listPropostaPorImovel = new List<PropostaCompra__c>();
            }

            listPropostaPorImovel.add(itemProposta);
            mapListPropostaPorIdImovel.put(itemProposta.Imovel__c, listPropostaPorImovel);
        }


        listImovel = buscarImoveisPorSetId(setIdImovel);

        for (){

        }

    }

}