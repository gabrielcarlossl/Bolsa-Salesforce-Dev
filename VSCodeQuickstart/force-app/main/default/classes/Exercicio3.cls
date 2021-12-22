//1
public with sharing class Exercicio3 {
public class PropostaException extends Exception {}    
        public static Imovel__c buscarId(Id idImovel){
            return [
            SELECT 
                Id,
                Valorbase__c,
                RecordType.DeveloperName,
                Status__c
    
            FROM
                Imovel__c
            WHERE
                Id = : idImovel
            ];
            
        }

        public static void aumentarValorBase(Id idImovel) {
            Imovel__c imovel = buscarId(idImovel);
            
            if (imovel.RecordType.DeveloperName == 'Apartamento'){
                imovel.ValorBase__c = (imovel.ValorBase__c + (imovel.ValorBase__c * 0.04));
                update imovel;
            } else if (imovel.RecordType.DeveloperName == 'Casa'){
                imovel.ValorBase__c = (imovel.ValorBase__c + (imovel.ValorBase__c * 0.02));
                update imovel;
            }

        }

    //2

        public static void criarNovaPropostaCompra(Id idImovel, String contato, String vendedor, Integer valor ){
            
            PropostaCompra__c NovaProposta = new PropostaCompra__c();
            Imovel__c imovel = buscarId(idImovel);

                NovaProposta.Imovel__c = idImovel; //a035f000005eb3fAAA
                NovaProposta.Contato__c = contato; //'0035f00000Dp3q4AAB'
                NovaProposta.Vendedor__c = vendedor; //'0055f000006021ZAAQ'
                NovaProposta.Valor__c = valor; //400000
                NovaProposta.Data__c = date.newInstance(2021, 12, 21);
                NovaProposta.DataEntregaChaves__c = date.newInstance(2021, 12, 21);
                Date hoje = date.Today();
                insert NovaProposta;

                if (imovel.Status__c == 'Reservado'){
                    delete NovaProposta;
                    throw new PropostaException('Proposta não criada porque o Imóvel está Reservado.');
                }
                if (imovel.Status__c == 'Vendido'){
                    delete NovaProposta;
                    throw new PropostaException('Proposta não criada porque o Imóvel está Vendido.');
                }
                if (NovaProposta.Data__c < hoje){
                    delete NovaProposta;
                    throw new PropostaException('Proposta não criada porque a data é menor que a data de hoje.');

                }
                if (NovaProposta.Valor__c <= 0  ){
                    delete NovaProposta;
                    throw new PropostaException('Proposta não criada porque o Valor da proposta é menor ou igual a 0.');
                }
        }
}
