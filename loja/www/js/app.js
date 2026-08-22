const CHAVE_SACOLA = "sacola_techstore";
const API_URL = "https://fakestoreapi.com/products";

document.addEventListener('deviceready', onDeviceReady, false);

// Serve para executar mesmo se não for o cordova
if (window.cordova === undefined) {
    onDeviceReady();
}


function onDeviceReady() {
    console.log('cordova ready');
    atualizarContadorSacola();
}

function atualizarContadorSacola() {
    const sacola = carregarSacola();
    const totalItens = sacola.reduce((acc, item) => acc + item.quantidade, 0);
    const contador = document.getElementById('contador-sacola');

    if (contador) {
        contador.textContent = totalItens;
    }
}

function carregarSacola() {
    const dadosSalvos = localStorage.getItem(CHAVE_SACOLA);

    if (dadosSalvos) {
        try {
            return JSON.parse(dadosSalvos);
        } catch (error) {
            return [];
        }
    }
    return [];
}

function salvarSacola(sacola) {
    localStorage.setItem(CHAVE_SACOLA, JSON.stringify(sacola));
}

function formatarPreco(valor) {
    return `R$ ${valor.toFixed(2).replace(".", ",")}`;
}
