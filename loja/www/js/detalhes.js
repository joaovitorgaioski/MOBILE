const detalhesProduto = document.getElementById('detalhes-produto');
const btnAdicionarSacola = document.getElementById('btn-adicionar-sacola');

let produtoAtual = null;

function pegarIdURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get('id');
}

async function carregarDetalhes(id) {
    console.log(id);
    try {
        const response = await fetch(`${API_URL}/${id}`);
        const produto = await response.json();

        produtoAtual = produto;

        detalhesProduto.innerHTML = `
        <img src="${produto.image}" alt="${produto.title}">
        <h2>${produto.title}</h2>
        <p class="preco-detalhe">${formatarPreco(produto.price)}</p>
        <p class="descricao">${produto.description}</p>
        <p style="margin-top:15px; font-size:12px; color:#999;">Categoria: ${produto.category}</p>
        `;
    } catch (error) {
        console.log("Erro em detalhes.js", error);
    }
}

function adicionarProdutoNaSacola(){
    if (!produtoAtual) return;

    const sacola = carregarSacola();
    const itemExistente = sacola.find(item => item.id === produtoAtual.id);

    if(itemExistente) {
        itemExistente.quantidade += 1;
    } else {
        sacola.push({
            id: produtoAtual.id,
            title: produtoAtual.title,
            price: produtoAtual.price,
            image: produtoAtual.image,
            quantidade: 1
        });
    }

    salvarSacola(sacola);
    atualizarContadorSacola();
}

btnAdicionarSacola.addEventListener('click', adicionarProdutoNaSacola);
carregarDetalhes(pegarIdURL());