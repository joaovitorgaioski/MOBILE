
const telaLista = document.getElementById('tela-lista');
const telaDetalhes = document.getElementById('tela-detalhes');
const telaSacola = document.getElementById('tela-sacola');

const listaProdutos = document.getElementById('lista-produtos');
const listaSacola = document.getElementById('lista-sacola');

const btnVoltar = document.getElementById('btn-voltar');
const btnVoltarSacola = document.getElementById('btn-voltar-sacola');
const btnSacolaHeader = document.getElementById('btn-sacola');
const btnAdicionarSacola = document.getElementById('btn-adicionar-sacola');
const btnFinalizar = document.getElementById('btn-finalizar');

const loading = document.getElementById('loading');
const totalSacola = document.getElementById('total-sacola');
const contadorSacola = document.getElementById('btn-contador-sacola');
const detalhesProduto = document.getElementById('detalhe-produtos');

async function carregarProdutos() {
    if (!listaProdutos) return;
    
    try {
        const response = await fetch(API_URL);
        const produtos = await response.json();
        if (loading) loading.style.display = 'none';
        console.log(produtos)

        produtos.forEach(produto => {
            const card = document.createElement('a');
            card.className = 'card-produto';
            card.href = `detalhes.html?id=${produto.id}`;

            card.innerHTML = `
                <img src="${produto.image}" alt="${produto.title}">
                <h3>${produto.title}</h3>
                <p class="preco">${formatarPreco(produto.price)}</p>
            `;

            // card.addEventListener('click', () => mostrarDetalhes(produto.id));

            listaProdutos.appendChild(card);
        })
    } catch (error) {
        if (loading) {
            loading.innerText = "Erro ao carregar produtos!";
        }
        console.log("Erro em index.js", error);
    }
}

carregarProdutos();