const String aboutUs =
    """Fonoaudióloga há mais de 20 anos, atuando na reabilitação de adultos com Afasia, Demências, Disartria, Apraxia e Disfagia. Durante minha trajetória profissional, sempre percebi a carência de recursos adequados para estimular a linguagem em adultos. Motivada por essa lacuna, surgiu a ideia de desenvolver o aplicativo FonoTerapia, concebido como uma ferramenta destinada aos fonoaudiólogos que trabalham na reabilitação de adultos.\n
Além de minha vasta experiência clínica, atualmente sou doutoranda na UNIFESP - Baixada Santista em Ciências da Saúde. Possuo graduação em Fonoaudiologia pela UNIFESP (2002), especialização em Linguagem do Adulto e do Idoso pela USP (2003) e mestrado em Interdisciplinar em Ciências da Saúde pela UNIFESP (2020).""";

const String contacts = """Instagram: @Fono.jugonzalez
Email: gonzalezdiazjuliana@gmail.com
Telefone(Whatsapp): (13) 98143-0426""";

const String contactsDev = """Guilherme Garcia
Email: gui123.garcia@gmail.com
Telefone(Whatsapp): (11) 97262-2224""";

enum Levels { facil, medio, dificil }

const nameList = [
  "Abelha",
  "Água",
  "Anel",
  "Arroz",
  "Árvore",
  "Banana",
  "Barata",
  "Batom",
  "Bife",
  "Boca",
  "Bola",
  "Bolo",
  "Borracha",
  "Botão",
  "Cabelo",
  "Cachorro",
  "Cadeira",
  "Café",
  "Cama",
  "Caneta",
  "Carro",
  "Casa",
  "Cavalo",
  "Cebola",
  "Cerveja",
  "Chuveiro",
  "Cobra",
  "Cola",
  "Colher",
  "Cueca",
  "Dado",
  "Dedo",
  "Dente",
  "Espelho",
  "Faca",
  "Feijão",
  "Flor",
  "Fogão",
  "Frango",
  "Garfo",
  "Gato",
  "Geladeira",
  "Hospital",
  "Igreja",
  "Lápis",
  "Leão",
  "Leite",
  "Livro",
  "Lua",
  "Maçã",
  "Macaco",
  "Macarrão",
  "Manga",
  "Mão",
  "Maracujá",
  "Médico",
  "Meia",
  "Mesa",
  "Moto",
  "Nariz",
  "Olho",
  "Ônibus",
  "Orelha",
  "Panela",
  "Pão",
  "Papel",
  "Pato",
  "Pé",
  "Peixe",
  "Pente",
  "Perna",
  "Pizza",
  "Porco",
  "Porta",
  "Prato",
  "Rato",
  "Relógio",
  "Saia",
  "Salada",
  "Sapato",
  "Sapo",
  "Shorts",
  "Sofá",
  "Sol",
  "Sorvete",
  "Suco",
  "Sutiã",
  "Telefone",
  "Televisão",
  "Tênis",
  "Tomate",
  "Trem",
  "Uva",
  "Vaca",
  "Vaso",
  "Vela",
  "Vestido",
  "Vinho",
  "Violão",
  "A criança está chorando",
  "A família está viajando",
  "A mãe beijou seu filho",
  "A mulher está bebendo água",
  "A mulher está comendo",
  "A mulher está escrevendo",
  "A mulher está lavando a louça",
  "A mulher está ouvindo música",
  "A mulher está pagando a conta",
  "A mulher está pintando",
  "A mulher está rezando",
  "A mulher está sorrindo",
  "A mulher está trabalhando",
  "A mulher está varrendo a casa",
  "A mulher passou a roupa",
  "As crianças estão brincando",
  "As crianças estão jogando futebol",
  "As luzes estão acesas",
  "Elas estão conversando",
  "Elas estão fazendo exercícios",
  "Eles estão caminhando na praia",
  "Eles estão dançando",
  "Eles estão no cinema",
  "Eles estão se abraçando",
  "Escovando os dentes",
  "Está chovendo",
  "Estou com calor",
  "Estou com dor",
  "O bebê nasceu",
  "O cachorro está dormindo",
  "O café está quente",
  "O homem caiu no chão",
  "O homem está comendo",
  "O homem está correndo",
  "O homem está cortando as unhas",
  "O homem está cortando o pão",
  "O homem está cozinhando",
  "O homem está dirigindo",
  "O homem está fazendo churrasco",
  "O homem está lendo um livro",
  "O homem está nadando",
  "O homem está plantando",
  "O homem está tomando banho",
  "O homem quebrou o pé",
  "O médico me atendeu hoje",
  "O telefone está tocando",
  "Passei manteiga no pão",
  "Penteando o cabelo",
  "Precisa lavar a roupa",
  "Preciso fazer compras",
  "Gato",
  "Pato",
  "Dente",
  "Pente",
  "Boca",
  "Bola",
  "Bola",
  "Cola",
  "Doce",
  "Doze",
  "Banco",
  "Branco",
  "Faca",
  "Vaca",
  "Bota",
  "Gota",
  "Bingo",
  "Pingo",
  "Bar",
  "Par",
  "Quadro",
  "Quatro",
  "Cola",
  "Gola",
  "Vaga",
  "Vaca",
  "Foto",
  "Voto",
  "Fila",
  "Filha",
  "Inferno",
  "Inverno",
  "Farinha",
  "Varinha",
  "Queijo",
  "Queixo",
  "Giz",
  "Xis",
  "Mala",
  "Mapa",
  "A geladeira deixa a comida quente?",
  "A música ouve as pessoas?",
  "A unha tem pelos?",
  "Anéis são usados nos dedos?",
  "As folhas das árvores são roxas?",
  "As tartarugas voam?",
  "Bibliotecas são silenciosas?",
  "Carros são mais rápidos do que os aviões?",
  "Cavalos são mais rápidos do que tartarugas?",
  "Elefantes são mais leves do que patos?",
  "Idosos são mais novos do que crianças?",
  "Maçã é uma fruta?",
  "Na padaria vende televisão?",
  "No açougue vende carne?",
  "No futebol ganha quem fizer mais gols?",
  "O Brasil fica na Europa?",
  "O café é branco?",
  "O carro é dirigido pelo homem?",
  "O céu é azul?",
  "O chocolate é salgado?",
  "O fogo é quente?",
  "O mar é rosa?",
  "O nariz é cheirado pela flor?",
  "O pescador pesca vacas?",
  "O sol pode ser visto a noite?",
  "O sorvete é gelado?",
  "O verão é quente?",
  "O vôlei é jogado com as mãos?",
  "Óculos ajudam a enxergar melhor?",
  "Ônibus são menores do que carros?",
  "Os cavalos voam?",
  "Os gatos latem?",
  "Os gatos põem ovos?",
  "Os gatos tem escamas?",
  "Os olhos escutam?",
  "Os peixes andam?",
  "Os pés tem dentes?",
  "Os relógios mostram as horas?",
  "Podemos comer portas?",
  "Portas trancam as chaves?",
  "Quando estamos doentes vamos ao médico?",
  "Sapatos são usados nas mãos?",
  "Tecidos são mais duros do que madeira?",
  "Tem areia na praia?",
  "Tem crianças na escola?",
  "Tia é a filha da sua mãe?",
  "Um ano tem 30 dias?",
  "Um cachorro pode falar?",
  "Um carro é pesado?",
  "Um dia tem 24 horas?",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];

const imagePathList = [
  "assets/db_images/Abelha.png",
  "assets/db_images/Agua.png",
  "assets/db_images/Anel.png",
  "assets/db_images/Arroz.png",
  "assets/db_images/Arvore.png",
  "assets/db_images/Banana.png",
  "assets/db_images/Barata.png",
  "assets/db_images/Batom.png",
  "assets/db_images/Bife.png",
  "assets/db_images/Boca.png",
  "assets/db_images/Bola.png",
  "assets/db_images/Bolo.png",
  "assets/db_images/Borracha.png",
  "assets/db_images/Botao.png",
  "assets/db_images/Cabelo.png",
  "assets/db_images/Cachorro.png",
  "assets/db_images/Cadeira.png",
  "assets/db_images/Cafe.png",
  "assets/db_images/Cama.png",
  "assets/db_images/Caneta.png",
  "assets/db_images/Carro.png",
  "assets/db_images/Casa.png",
  "assets/db_images/Cavalo.png",
  "assets/db_images/Cebola.png",
  "assets/db_images/Cerveja.png",
  "assets/db_images/Chuveiro.png",
  "assets/db_images/Cobra.png",
  "assets/db_images/Cola.png",
  "assets/db_images/Colher.png",
  "assets/db_images/Cueca.png",
  "assets/db_images/Dado.png",
  "assets/db_images/Dedo.png",
  "assets/db_images/Dente.png",
  "assets/db_images/Espelho.png",
  "assets/db_images/Faca.png",
  "assets/db_images/Feijao.png",
  "assets/db_images/Flor.png",
  "assets/db_images/Fogao.png",
  "assets/db_images/Frango.png",
  "assets/db_images/Garfo.png",
  "assets/db_images/Gato.png",
  "assets/db_images/Geladeira.png",
  "assets/db_images/Hospital.png",
  "assets/db_images/Igreja.png",
  "assets/db_images/Lapis.png",
  "assets/db_images/Leao.png",
  "assets/db_images/Leite.png",
  "assets/db_images/Livro.png",
  "assets/db_images/Lua.png",
  "assets/db_images/Maca.png",
  "assets/db_images/Macaco.png",
  "assets/db_images/Macarrao.png",
  "assets/db_images/Manga.png",
  "assets/db_images/Mao.png",
  "assets/db_images/Maracuja.png",
  "assets/db_images/Medico.png",
  "assets/db_images/Meia.png",
  "assets/db_images/Mesa.png",
  "assets/db_images/Moto.png",
  "assets/db_images/Nariz.png",
  "assets/db_images/Olho.png",
  "assets/db_images/Onibus.png",
  "assets/db_images/Orelha.png",
  "assets/db_images/Panela.png",
  "assets/db_images/Pao.png",
  "assets/db_images/Papel.png",
  "assets/db_images/Pato.png",
  "assets/db_images/Pe.png",
  "assets/db_images/Peixe.png",
  "assets/db_images/Pente.png",
  "assets/db_images/Perna.png",
  "assets/db_images/Pizza.png",
  "assets/db_images/Porco.png",
  "assets/db_images/Porta.png",
  "assets/db_images/Prato.png",
  "assets/db_images/Rato.png",
  "assets/db_images/Relogio.png",
  "assets/db_images/Saia.png",
  "assets/db_images/Salada.png",
  "assets/db_images/Sapato.png",
  "assets/db_images/Sapo.png",
  "assets/db_images/Shorts.png",
  "assets/db_images/Sofa.png",
  "assets/db_images/Sol.png",
  "assets/db_images/Sorvete.png",
  "assets/db_images/Suco.png",
  "assets/db_images/Sutia.png",
  "assets/db_images/Telefone.png",
  "assets/db_images/Televisao.png",
  "assets/db_images/Tenis.png",
  "assets/db_images/Tomate.png",
  "assets/db_images/Trem.png",
  "assets/db_images/Uva.png",
  "assets/db_images/Vaca.png",
  "assets/db_images/Vaso.png",
  "assets/db_images/Vela.png",
  "assets/db_images/Vestido.png",
  "assets/db_images/Vinho.png",
  "assets/db_images/Violao.png",
  "assets/db_images/A_crianca_esta_chorando.png",
  "assets/db_images/A_familia_esta_viajando.png",
  "assets/db_images/A_mae_beijou_seu_filho.png",
  "assets/db_images/A_mulher_esta_bebendo_agua.png",
  "assets/db_images/A_mulher_esta_comendo.png",
  "assets/db_images/A_mulher_esta_escrevendo.png",
  "assets/db_images/A_mulher_esta_lavando_a_louca.png",
  "assets/db_images/A_mulher_esta_ouvindo_musica.png",
  "assets/db_images/A_mulher_esta_pagando_a_conta.png",
  "assets/db_images/A_mulher_esta_pintando.png",
  "assets/db_images/A_mulher_esta_rezando.png",
  "assets/db_images/A_mulher_esta_sorrindo.png",
  "assets/db_images/A_mulher_esta_trabalhando.png",
  "assets/db_images/A_mulher_esta_varrendo_a_casa.png",
  "assets/db_images/A_mulher_passou_a_roupa.png",
  "assets/db_images/As_criancas_estao_brincando.png",
  "assets/db_images/As_criancas_estao_jogando_futebol.png",
  "assets/db_images/As_luzes_estao_acesas.png",
  "assets/db_images/Elas_estao_conversando.png",
  "assets/db_images/Elas_estao_fazendo_exercicios.png",
  "assets/db_images/Eles_estao_caminhando_na_praia.png",
  "assets/db_images/Eles_estao_dancando.png",
  "assets/db_images/Eles_estao_no_cinema.png",
  "assets/db_images/Eles_estao_se_abracando.png",
  "assets/db_images/Escovando_os_dentes.png",
  "assets/db_images/Esta_chovendo.png",
  "assets/db_images/Estou_com_calor.png",
  "assets/db_images/Estou_com_dor.png",
  "assets/db_images/O_bebe_nasceu.png",
  "assets/db_images/O_cachorro_esta_dormindo.png",
  "assets/db_images/O_cafe_esta_quente.png",
  "assets/db_images/O_homem_caiu_no_chao.png",
  "assets/db_images/O_homem_esta_comendo.png",
  "assets/db_images/O_homem_esta_correndo.png",
  "assets/db_images/O_homem_esta_cortando_as_unhas.png",
  "assets/db_images/O_homem_esta_cortando_o_pao.png",
  "assets/db_images/O_homem_esta_cozinhando.png",
  "assets/db_images/O_homem_esta_dirigindo.png",
  "assets/db_images/O_homem_esta_fazendo_churrasco.png",
  "assets/db_images/O_homem_esta_lendo_um_livro.png",
  "assets/db_images/O_homem_esta_nadando.png",
  "assets/db_images/O_homem_esta_plantando.png",
  "assets/db_images/O_homem_esta_tomando_banho.png",
  "assets/db_images/O_homem_quebrou_o_pe.png",
  "assets/db_images/O_medico_me_atendeu_hoje.png",
  "assets/db_images/O_telefone_esta_tocando.png",
  "assets/db_images/Passei_manteiga_no_pao.png",
  "assets/db_images/Penteando_o_cabelo.png",
  "assets/db_images/Precisa_lavar_a_roupa.png",
  "assets/db_images/Preciso_fazer_compras.png",
  "assets/db_images/Gato.png",
  "assets/db_images/Pato.png",
  "assets/db_images/Dente.png",
  "assets/db_images/Pente.png",
  "assets/db_images/Boca.png",
  "assets/db_images/Bola.png",
  "assets/db_images/Bola.png",
  "assets/db_images/Cola.png",
  "assets/db_images/Doce.png",
  "assets/db_images/Doze.png",
  "assets/db_images/Banco.png",
  "assets/db_images/Branco.png",
  "assets/db_images/Faca.png",
  "assets/db_images/Vaca.png",
  "assets/db_images/Bota.png",
  "assets/db_images/Gota.png",
  "assets/db_images/Bingo.png",
  "assets/db_images/Pingo.png",
  "assets/db_images/Bar.png",
  "assets/db_images/Par.png",
  "assets/db_images/Quadro.png",
  "assets/db_images/Quatro.png",
  "assets/db_images/Cola.png",
  "assets/db_images/Gola.png",
  "assets/db_images/Vaga.png",
  "assets/db_images/Vaca.png",
  "assets/db_images/Foto.png",
  "assets/db_images/Voto.png",
  "assets/db_images/Fila.png",
  "assets/db_images/Filha.png",
  "assets/db_images/Inferno.png",
  "assets/db_images/Inverno.png",
  "assets/db_images/Farinha.png",
  "assets/db_images/Varinha.png",
  "assets/db_images/Queijo.png",
  "assets/db_images/Queixo.png",
  "assets/db_images/Giz.png",
  "assets/db_images/Xis.png",
  "assets/db_images/Mala.png",
  "assets/db_images/Mapa.png",
  "assets/db_images/A_geladeira_deixa_a_comida_quente.png",
  "assets/db_images/A_musica_ouve_as_pessoas.png",
  "assets/db_images/A_unha_tem_pelos.png",
  "assets/db_images/Aneis_sao_usados_nos_dedos.png",
  "assets/db_images/As_folhas_das_arvores_sao_roxas.png",
  "assets/db_images/As_tartarugas_voam.png",
  "assets/db_images/Bibliotecas_sao_silenciosas.png",
  "assets/db_images/Carros_sao_mais_rapidos_do_que_os_avioes.png",
  "assets/db_images/Cavalos_sao_mais_rapidos_do_que_tartarugas.png",
  "assets/db_images/Elefantes_sao_mais_leves_do_que_patos.png",
  "assets/db_images/Idosos_sao_mais_novos_do_que_criancas.png",
  "assets/db_images/Maca_e_uma_fruta.png",
  "assets/db_images/Na_padaria_vende_televisao.png",
  "assets/db_images/No_acougue_vende_carne.png",
  "assets/db_images/No_futebol_ganha_quem_fizer_mais_gols.png",
  "assets/db_images/O_brasil_fica_na_europa.png",
  "assets/db_images/O_cafe_e_branco.png",
  "assets/db_images/O_carro_e_dirigido_pelo_homem.png",
  "assets/db_images/O_ceu_e_azul.png",
  "assets/db_images/O_chocolate_e_salgado.png",
  "assets/db_images/O_fogo_e_quente.png",
  "assets/db_images/O_mar_e_rosa.png",
  "assets/db_images/O_nariz_e_cheirado_pela_flor.png",
  "assets/db_images/O_pescador_pesca_vacas.png",
  "assets/db_images/O_sol_pode_ser_visto_a_noite.png",
  "assets/db_images/O_sorvete_e_gelado.png",
  "assets/db_images/O_verao_e_quente.png",
  "assets/db_images/O_volei_e_jogado_com_as_maos.png",
  "assets/db_images/Oculos_ajudam_a_enxergar_melhor.png",
  "assets/db_images/Onibus_sao_menores_do_que_os_carros.png",
  "assets/db_images/Os_cavalos_voam.png",
  "assets/db_images/Os_gatos_latem.png",
  "assets/db_images/Os_gatos_poem_ovos.png",
  "assets/db_images/Os_gatos_tem_escamas.png",
  "assets/db_images/Os_olhos_escutam.png",
  "assets/db_images/Os_peixes_andam.png",
  "assets/db_images/Os_pes_tem_dentes.png",
  "assets/db_images/Os_relogios_mostram_as_horas.png",
  "assets/db_images/Podemos_comer_portas.png",
  "assets/db_images/Portas_trancam_as_chaves.png",
  "assets/db_images/Quando_estamos_doentes_vamos_ao_medico.png",
  "assets/db_images/Sapatos_sao_usados_nas_maos.png",
  "assets/db_images/Tecidos_sao_mais_duros_do_que_madeira.png",
  "assets/db_images/Tem_areia_na_praia.png",
  "assets/db_images/Tem_criancas_na_escola.png",
  "assets/db_images/Tia_e_a_filha_da_sua_mae.png",
  "assets/db_images/Um_ano_tem_30_dias.png",
  "assets/db_images/Um_cachorro_pode_falar.png",
  "assets/db_images/Um_carro_e_pesado.png",
  "assets/db_images/Um_dia_tem_24_horas.png",
  "assets/db_images/A.png",
  "assets/db_images/B.png",
  "assets/db_images/C.png",
  "assets/db_images/D.png",
  "assets/db_images/E.png",
  "assets/db_images/F.png",
  "assets/db_images/G.png",
  "assets/db_images/H.png",
  "assets/db_images/I.png",
  "assets/db_images/J.png",
  "assets/db_images/K.png",
  "assets/db_images/L.png",
  "assets/db_images/M.png",
  "assets/db_images/N.png",
  "assets/db_images/O.png",
  "assets/db_images/P.png",
  "assets/db_images/Q.png",
  "assets/db_images/R.png",
  "assets/db_images/S.png",
  "assets/db_images/T.png",
  "assets/db_images/U.png",
  "assets/db_images/V.png",
  "assets/db_images/W.png",
  "assets/db_images/X.png",
  "assets/db_images/Y.png",
  "assets/db_images/Z.png"
];

const audioPathList = [
  "db_audios/Abelha.mp3",
  "db_audios/Agua.mp3",
  "db_audios/Anel.mp3",
  "db_audios/Arroz.mp3",
  "db_audios/Arvore.mp3",
  "db_audios/Banana.mp3",
  "db_audios/Barata.mp3",
  "db_audios/Batom.mp3",
  "db_audios/Bife.mp3",
  "db_audios/Boca.mp3",
  "db_audios/Bola.mp3",
  "db_audios/Bolo.mp3",
  "db_audios/Borracha.mp3",
  "db_audios/Botao.mp3",
  "db_audios/Cabelo.mp3",
  "db_audios/Cachorro.mp3",
  "db_audios/Cadeira.mp3",
  "db_audios/Cafe.mp3",
  "db_audios/Cama.mp3",
  "db_audios/Caneta.mp3",
  "db_audios/Carro.mp3",
  "db_audios/Casa.mp3",
  "db_audios/Cavalo.mp3",
  "db_audios/Cebola.mp3",
  "db_audios/Cerveja.mp3",
  "db_audios/Chuveiro.mp3",
  "db_audios/Cobra.mp3",
  "db_audios/Cola.mp3",
  "db_audios/Colher.mp3",
  "db_audios/Cueca.mp3",
  "db_audios/Dado.mp3",
  "db_audios/Dedo.mp3",
  "db_audios/Dente.mp3",
  "db_audios/Espelho.mp3",
  "db_audios/Faca.mp3",
  "db_audios/Feijao.mp3",
  "db_audios/Flor.mp3",
  "db_audios/Fogao.mp3",
  "db_audios/Frango.mp3",
  "db_audios/Garfo.mp3",
  "db_audios/Gato.mp3",
  "db_audios/Geladeira.mp3",
  "db_audios/Hospital.mp3",
  "db_audios/Igreja.mp3",
  "db_audios/Lapis.mp3",
  "db_audios/Leao.mp3",
  "db_audios/Leite.mp3",
  "db_audios/Livro.mp3",
  "db_audios/Lua.mp3",
  "db_audios/Maca.mp3",
  "db_audios/Macaco.mp3",
  "db_audios/Macarrao.mp3",
  "db_audios/Manga.mp3",
  "db_audios/Mao.mp3",
  "db_audios/Maracuja.mp3",
  "db_audios/Medico.mp3",
  "db_audios/Meia.mp3",
  "db_audios/Mesa.mp3",
  "db_audios/Moto.mp3",
  "db_audios/Nariz.mp3",
  "db_audios/Olho.mp3",
  "db_audios/Onibus.mp3",
  "db_audios/Orelha.mp3",
  "db_audios/Panela.mp3",
  "db_audios/Pao.mp3",
  "db_audios/Papel.mp3",
  "db_audios/Pato.mp3",
  "db_audios/Pe.mp3",
  "db_audios/Peixe.mp3",
  "db_audios/Pente.mp3",
  "db_audios/Perna.mp3",
  "db_audios/Pizza.mp3",
  "db_audios/Porco.mp3",
  "db_audios/Porta.mp3",
  "db_audios/Prato.mp3",
  "db_audios/Rato.mp3",
  "db_audios/Relogio.mp3",
  "db_audios/Saia.mp3",
  "db_audios/Salada.mp3",
  "db_audios/Sapato.mp3",
  "db_audios/Sapo.mp3",
  "db_audios/Shorts.mp3",
  "db_audios/Sofa.mp3",
  "db_audios/Sol.mp3",
  "db_audios/Sorvete.mp3",
  "db_audios/Suco.mp3",
  "db_audios/Sutia.mp3",
  "db_audios/Telefone.mp3",
  "db_audios/Televisao.mp3",
  "db_audios/Tenis.mp3",
  "db_audios/Tomate.mp3",
  "db_audios/Trem.mp3",
  "db_audios/Uva.mp3",
  "db_audios/Vaca.mp3",
  "db_audios/Vaso.mp3",
  "db_audios/Vela.mp3",
  "db_audios/Vestido.mp3",
  "db_audios/Vinho.mp3",
  "db_audios/Violao.mp3",
  "db_audios/A_crianca_esta_chorando.mp3",
  "db_audios/A_familia_esta_viajando.mp3",
  "db_audios/A_mae_beijou_seu_filho.mp3",
  "db_audios/A_mulher_esta_bebendo_agua.mp3",
  "db_audios/A_mulher_esta_comendo.mp3",
  "db_audios/A_mulher_esta_escrevendo.mp3",
  "db_audios/A_mulher_esta_lavando_a_louca.mp3",
  "db_audios/A_mulher_esta_ouvindo_musica.mp3",
  "db_audios/A_mulher_esta_pagando_a_conta.mp3",
  "db_audios/A_mulher_esta_pintando.mp3",
  "db_audios/A_mulher_esta_rezando.mp3",
  "db_audios/A_mulher_esta_sorrindo.mp3",
  "db_audios/A_mulher_esta_trabalhando.mp3",
  "db_audios/A_mulher_esta_varrendo_a_casa.mp3",
  "db_audios/A_mulher_passou_a_roupa.mp3",
  "db_audios/As_criancas_estao_brincando.mp3",
  "db_audios/As_criancas_estao_jogando_futebol.mp3",
  "db_audios/As_luzes_estao_acesas.mp3",
  "db_audios/Elas_estao_conversando.mp3",
  "db_audios/Elas_estao_fazendo_exercicios.mp3",
  "db_audios/Eles_estao_caminhando_na_praia.mp3",
  "db_audios/Eles_estao_dancando.mp3",
  "db_audios/Eles_estao_no_cinema.mp3",
  "db_audios/Eles_estao_se_abracando.mp3",
  "db_audios/Escovando_os_dentes.mp3",
  "db_audios/Esta_chovendo.mp3",
  "db_audios/Estou_com_calor.mp3",
  "db_audios/Estou_com_dor.mp3",
  "db_audios/O_bebe_nasceu.mp3",
  "db_audios/O_cachorro_esta_dormindo.mp3",
  "db_audios/O_cafe_esta_quente.mp3",
  "db_audios/O_homem_caiu_no_chao.mp3",
  "db_audios/O_homem_esta_comendo.mp3",
  "db_audios/O_homem_esta_correndo.mp3",
  "db_audios/O_homem_esta_cortando_as_unhas.mp3",
  "db_audios/O_homem_esta_cortando_o_pao.mp3",
  "db_audios/O_homem_esta_cozinhando.mp3",
  "db_audios/O_homem_esta_dirigindo.mp3",
  "db_audios/O_homem_esta_fazendo_churrasco.mp3",
  "db_audios/O_homem_esta_lendo_um_livro.mp3",
  "db_audios/O_homem_esta_nadando.mp3",
  "db_audios/O_homem_esta_plantando.mp3",
  "db_audios/O_homem_esta_tomando_banho.mp3",
  "db_audios/O_homem_quebrou_o_pe.mp3",
  "db_audios/O_medico_me_atendeu_hoje.mp3",
  "db_audios/O_telefone_esta_tocando.mp3",
  "db_audios/Passei_manteiga_no_pao.mp3",
  "db_audios/Penteando_o_cabelo.mp3",
  "db_audios/Precisa_lavar_a_roupa.mp3",
  "db_audios/Preciso_fazer_compras.mp3",
  "db_audios/Gato.mp3",
  "db_audios/Pato.mp3",
  "db_audios/Dente.mp3",
  "db_audios/Pente.mp3",
  "db_audios/Boca.mp3",
  "db_audios/Bola.mp3",
  "db_audios/Bola.mp3",
  "db_audios/Cola.mp3",
  "db_audios/Doce.mp3",
  "db_audios/Doze.mp3",
  "db_audios/Banco.mp3",
  "db_audios/Branco.mp3",
  "db_audios/Faca.mp3",
  "db_audios/Vaca.mp3",
  "db_audios/Bota.mp3",
  "db_audios/Gota.mp3",
  "db_audios/Bingo.mp3",
  "db_audios/Pingo.mp3",
  "db_audios/Bar.mp3",
  "db_audios/Par.mp3",
  "db_audios/Quadro.mp3",
  "db_audios/Quatro.mp3",
  "db_audios/Cola.mp3",
  "db_audios/Gola.mp3",
  "db_audios/Vaga.mp3",
  "db_audios/Vaca.mp3",
  "db_audios/Foto.mp3",
  "db_audios/Voto.mp3",
  "db_audios/Fila.mp3",
  "db_audios/Filha.mp3",
  "db_audios/Inferno.mp3",
  "db_audios/Inverno.mp3",
  "db_audios/Farinha.mp3",
  "db_audios/Varinha.mp3",
  "db_audios/Queijo.mp3",
  "db_audios/Queixo.mp3",
  "db_audios/Giz.mp3",
  "db_audios/Xis.mp3",
  "db_audios/Mala.mp3",
  "db_audios/Mapa.mp3",
  "db_audios/A_geladeira_deixa_a_comida_quente.mp3",
  "db_audios/A_musica_ouve_as_pessoas.mp3",
  "db_audios/A_unha_tem_pelos.mp3",
  "db_audios/Aneis_sao_usados_nos_dedos.mp3",
  "db_audios/As_folhas_das_arvores_sao_roxas.mp3",
  "db_audios/As_tartarugas_voam.mp3",
  "db_audios/Bibliotecas_sao_silenciosas.mp3",
  "db_audios/Carros_sao_mais_rapidos_do_que_os_avioes.mp3",
  "db_audios/Cavalos_sao_mais_rapidos_do_que_tartarugas.mp3",
  "db_audios/Elefantes_sao_mais_leves_do_que_patos.mp3",
  "db_audios/Idosos_sao_mais_novos_do_que_criancas.mp3",
  "db_audios/Maca_e_uma_fruta.mp3",
  "db_audios/Na_padaria_vende_televisao.mp3",
  "db_audios/No_acougue_vende_carne.mp3",
  "db_audios/No_futebol_ganha_quem_fizer_mais_gols.mp3",
  "db_audios/O_Brasil_fica_na_Europa.mp3",
  "db_audios/O_cafe_e_branco.mp3",
  "db_audios/O_carro_e_dirigido_pelo_homem.mp3",
  "db_audios/O_ceu_e_azul.mp3",
  "db_audios/O_chocolate_e_salgado.mp3",
  "db_audios/O_fogo_e_quente.mp3",
  "db_audios/O_mar_e_rosa.mp3",
  "db_audios/O_nariz_e_cheirado_pela_flor.mp3",
  "db_audios/O_pescador_pesca_vacas.mp3",
  "db_audios/O_sol_pode_ser_visto_a_noite.mp3",
  "db_audios/O_sorvete_e_gelado.mp3",
  "db_audios/O_verao_e_quente.mp3",
  "db_audios/O_volei_e_jogado_com_as_maos.mp3",
  "db_audios/Oculos_ajudam_a_enxergar_melhor.mp3",
  "db_audios/Onibus_sao_menores_do_que_os_carros.mp3",
  "db_audios/Os_cavalos_voam.mp3",
  "db_audios/Os_gatos_latem.mp3",
  "db_audios/Os_gatos_poem_ovos.mp3",
  "db_audios/Os_gatos_tem_escamas.mp3",
  "db_audios/Os_olhos_escutam.mp3",
  "db_audios/Os_peixes_andam.mp3",
  "db_audios/Os_pes_tem_dentes.mp3",
  "db_audios/Os_relogios_mostram_as_horas.mp3",
  "db_audios/Podemos_comer_portas.mp3",
  "db_audios/Portas_trancam_as_chaves.mp3",
  "db_audios/Quando_estamos_doentes_vamos_ao_medico.mp3",
  "db_audios/Sapatos_sao_usados_nas_maos.mp3",
  "db_audios/Tecidos_sao_mais_duros_do_que_madeira.mp3",
  "db_audios/Tem_areia_na_praia.mp3",
  "db_audios/Tem_criancas_na_escola.mp3",
  "db_audios/Tia_e_a_filha_da_sua_mae.mp3",
  "db_audios/Um_ano_tem_30_dias.mp3",
  "db_audios/Um_cachorro_pode_falar.mp3",
  "db_audios/Um_carro_e_pesado.mp3",
  "db_audios/Um_dia_tem_24_horas.mp3",
  "db_audios/A.mp3",
  "db_audios/B.mp3",
  "db_audios/C.mp3",
  "db_audios/D.mp3",
  "db_audios/E.mp3",
  "db_audios/F.mp3",
  "db_audios/G.mp3",
  "db_audios/H.mp3",
  "db_audios/I.mp3",
  "db_audios/J.mp3",
  "db_audios/K.mp3",
  "db_audios/L.mp3",
  "db_audios/M.mp3",
  "db_audios/N.mp3",
  "db_audios/O.mp3",
  "db_audios/P.mp3",
  "db_audios/Q.mp3",
  "db_audios/R.mp3",
  "db_audios/S.mp3",
  "db_audios/T.mp3",
  "db_audios/U.mp3",
  "db_audios/V.mp3",
  "db_audios/W.mp3",
  "db_audios/X.mp3",
  "db_audios/Y.mp3",
  "db_audios/Z.mp3"
];

const sectionList = [
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  3,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5
];

const questionsAnswerList = [
  false, // "A geladeira deixa a comida quente?"
  false, // "A música ouve as pessoas?"
  false, // "A unha tem pelos?"
  true, // "Anéis são usados nos dedos?"
  false, // "As folhas das árvores são roxas?"
  false, // "As tartarugas voam?"
  true, // "Bibliotecas são silenciosas?"
  false, // "Carros são mais rápidos do que os aviões?"
  false, // "Cavalos são mais rápidos do que tartarugas?"
  false, // "Elefantes são mais leves do que os patos?"
  false, // "Idosos são mais novos do que crianças?"
  true, // "Maçã é uma fruta?"
  false, // "Na padaria vende televisão?"
  true, // "No açougue vende carne?"
  true, // "No futebol ganha quem fizer mais gols?"
  false, // "O brasil fica na europa?"
  false, // "O café é branco?"
  true, // "O carro é dirigido pelo homem?"
  true, // "O céu é azul?"
  false, // "O chocolate é salgado?"
  true, // "O fogo é quente?"
  false, // "O mar é rosa?"
  false, // "O nariz é cheirado pela flor?"
  false, // "O pescador pesca vacas?"
  false, // "O sol pode ser visto a noite?"
  true, // "O sorvete é gelado?"
  true, // "O verão é quente?"
  true, // "O vôlei é jogado com as mãos?"
  true, // "Óculos ajudam a enxergar melhor?"
  false, // "Ônibus são menores do que carros?"
  false, // "Os cavalos voam?"
  false, // "Os gatos latem?"
  false, // "Os gatos põem ovos?"
  false, // "Os gatos tem escamas?"
  false, // "Os olhos escutam?"
  false, // "Os peixes andam?"
  false, // "Os pés tem dentes?"
  true, // "Os relógios mostram as horas?"
  false, // "Podemos comer portas?"
  true, // "Portas trancam as chaves?"
  true, // "Quando estamos doentes vamos ao médico?"
  false, // "Sapatos são usados nas mãos?"
  false, // "Tecidos são mais duros do que madeira?"
  true, // "Tem areia na praia?"
  true, // "Tem crianças na escola?"
  false, // "Tia é a filha da sua mãe?"
  false, // "Um ano tem 30 dias?"
  false, // "Um cachorro pode falar?"
  true, // "Um carro é pesado?"
  true, // "Um dia tem 24 horas?"
];
