const detalhesProduto = document.getElementById('detalhes-produto');
const btnAdicionarSacola = document.getElementById('btn-adicionar-sacola');

function pegarIdURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get('id');
}

async function carregarDetalhes(id) {
    console.log(id);
    try {
        const response = await fetch(`${API_URL}/${id}`);
        const produto = await response.json();

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

carregarDetalhes(pegarIdURL());