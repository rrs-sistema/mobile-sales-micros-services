import './../../../pages/views_models/views_models.dart';

List<CartItemViewModel> cartItem = [
  CartItemViewModel(
      item: ProductViewModel(
        id: 1000,
        name: 'Bíblia Sagrada Nova Almeida Atualizada',
        description:
            'Essa edição da Bíblia Sagrada é ideal para quem deseja ler a Palavra de Deus diariamente e procura um texto clássico mas com linguagem atual. A Nova Almeida Atualizada (NAA) é uma tradução lançada em 2017 pela SBB, resultado de uma profunda revisão da consagrada tradução Almeida Revista e Atualizada. Ela apresenta um texto clássico com uma linguagem atual, seguindo a norma padrão do português escrito e falado no Brasil.',
        imgUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61lCKdWUOLL.jpg',
        quantityAvailable: 8,
        createdAt: '07/08/2022 02:20:46',
        price: 47.76,
        supplier:
            SupplierViewModel(id: 1000, name: 'Sociedade Bíblica do Brasil'),
        category: CategoryViewModel(id: 1000, description: 'Bíblia'),
      ),
      quantity: 3),
  CartItemViewModel(
      item: ProductViewModel(
        id: 1004,
        name:
            'Flutter na Prática: Melhore seu Desenvolvimento Mobile com o SDK Open Source Mais Recente do Google',
        description:
            'Saiba o que o Flutter tem para oferecer, de onde ele veio e para onde vai. O desenvolvimento de aplicativos móveis está progredindo rapidamente, e com o Flutter – um SDK open source de desenvolvimento de aplicações móveis criado pelo Google – você pode desenvolver aplicações para Android e iOS, assim como para o Google Fuchsia.',
        imgUrl:
            'https://images-na.ssl-images-amazon.com/images/I/41EACuSeCvL._SX347_BO1,204,203,200_.jpg',
        quantityAvailable: 4,
        createdAt: '28/07/2022 08:00:00',
        price: 77.47,
        supplier: SupplierViewModel(id: 1003, name: 'Novatec'),
        category:
            CategoryViewModel(id: 1003, description: 'Tecnologia e Ciência'),
      ),
      quantity: 2),
  CartItemViewModel(
      item: ProductViewModel(
        id: 1004,
        name: 'Básico: Enciclopédia de Receitas do Brasil',
        description:
            'Básico, o novo livro de Ana Trajano, apresenta a cozinha brasileira viva em várias versões. São 512 receitas, resultantes dos dezenove anos de andanças pelo nosso país e de muitas pesquisas da autora sobre a nossa culinária de raiz. Ele começa com um Tira-gosto, capítulo de petiscos que dá boas-vindas ao leitor da mesma maneira que recebemos nossos amigos em casa. Depois vêm os pratos principais, Mistura, seguidos pelos acompanhamentos que ajudam dar Sustância ao prato. Em seguida, as Sobremesas que revela a Fartura da doçaria brasileira e por fim, os Pães e Quitandas que acompanham nosso tradicional cafezinho.',
        imgUrl:
            'https://m.media-amazon.com/images/P/B078WVN3J2.01._SCLZZZZZZZ_SX500_.jpg',
        quantityAvailable: 12,
        createdAt: '28/07/2022 08:00:00',
        price: 96.24,
        supplier: SupplierViewModel(id: 1004, name: 'Viva bem'),
        category: CategoryViewModel(id: 1004, description: 'Gastronomia'),
      ),
      quantity: 2),
];
