const listaSacola = document.getElementById('lista-sacola');
const totalSacola = document.getElementById('total-sacola');
const btnFinalizar = document.getElementById('btn-finalizar');

function renderizarSacola() {
    let sacola = carregarSacola();

    if (sacola.length === 0) {
        listaSacola.innerHTML = '<p class="sacola-vazia">Sua sacola está vazia.</p>'
        totalSacola.innerHTML = '';
        btnFinalizar.style.display = 'none';
        return;
    }

    btnFinalizar.style.display = 'block';
    listaSacola.innerHTML = '';
    let total = 0

    sacola.forEach(item => {
        const subtotal = item.price * item.quantidade;
        total += subtotal;

        const div = document.createElement('div');
        div.className = 'item-sacola';
        div.innerHTML = `
            <img src="${item.image}" alt="${item.title}">
            <div class="item-info">
                <h4>${item.title}</h4>
                <p class="preco-item">${formatarPreco(subtotal)}</p>
                <div class="controles-quantidade">
                    <button data-acao="diminuir" data-id="${item.id}">-</button>
                    <span>${item.quantidade}</span>
                    <button data-acao="aumentar" data-id="${item.id}">+</button>
                    <button data-acao="remover" data-id="${item.id} class="btn-remover">🗑️</button>
                </div>
            </div>
        `;

        listaSacola.appendChild(div);
    });

    totalSacola.innerHTML = `Total: <span>${formatarPreco(total)}</span>`;

    listaSacola.querySelectorAll('button').forEach(btn => {
        btn.addEventListener('click', (e) => {
            const id = parseInt(e.target.dataset.id);
            const acao = e.target.dataset.acao;

            switch (acao) {
                case 'aumentar':
                    alterarQuantidade(id, 1);
                    break;

                case 'diminuir':
                    alterarQuantidade(id, -1);
                    break;

                case 'remover':
                    removerItem(id);
                    break;
            }
        })
    })
}

function alterarQuantidade(id, diferenca) {
    let sacola = carregarSacola();

    const item = sacola.find(i => i.id == id);
    if(!item) return;

    item.quantidade += diferenca;

    console.log(item.quantidade);
    if(item.quantidade <= 0) {
        sacola = sacola.filter(i => i.id !== id);
    }

    salvarSacola(sacola);
    atualizarContadorSacola();
    renderizarSacola();
}

renderizarSacola();