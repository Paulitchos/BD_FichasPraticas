EXEC NALUNO (2020121705);

--EX 3:
3.
select TITULO, PRECO_TABELA as PRECO,tab.avglivro as "PRECO_MEDIO", (PRECO_TABELA - tab.avglivro) as "DIFERENÇA"
from LIVROS, (SELECT l.CODIGO_AUTOR,avg(PRECO_TABELA) avglivro
                      FROM LIVROS l,AUTORES
                      WHERE lower(genero) like '%informática%'
                      GROUP BY l.CODIGO_AUTOR)tab
WHERE LIVROS.CODIGO_AUTOR = tab.CODIGO_AUTOR and lower(genero) like '%informática%'
GROUP BY TITULO,PRECO_TABELA,tab.avglivro
ORDER by 1;

EXEC SQLCHECK('FICJIOZCLJFNLMU'); 

--EX 4:
4.
SELECT DISTINCT GENERO, CLIENTES.NOME
FROM LIVROS,VENDAS,CLIENTES
WHERE LIVROS.CODIGO_LIVRO = VENDAS.CODIGO_LIVRO 
AND VENDAS.CODIGO_CLIENTE = CLIENTES.CODIGO_CLIENTE 
AND PRECO_UNITARIO = (SELECT min(PRECO_UNITARIO) UNIDADES_VENDIDAS
                      FROM VENDAS
                      GROUP BY GENERO)
ORDER BY 1;

EXEC SQLCHECK('FILWXDFDSFMAMJD'); 

--EX 5:
5.
SELECT TITULO,to_char(round(unidades_vendidas / tab.total * 100, 1), '990.99') as PERCENT
FROM LIVROS,EDITORAS,(SELECT sum(UNIDADES_VENDIDAS) total
                            FROM LIVROS,EDITORAS
                            WHERE  EDITORAS.CODIGO_EDITORA  = LIVROS.CODIGO_EDITORA 
                            AND lower(EDITORAS.NOME) like '%fca%')tab
WHERE EDITORAS.CODIGO_EDITORA = LIVROS.CODIGO_EDITORA 
AND lower(EDITORAS.NOME) like '%fca%'
ORDER BY 2 DESC,1;

EXEC SQLCHECK('FIFWYRRESPXPNOX'); 

--EX 6:
6.
SELECT Titulo
FROM LIVROS li,VENDAS ve,CLIENTES cli, (Select max(vendas.QUANTIDADE) total
                                        From vendas)tab
WHERE LI.CODIGO_LIVRO = VE.CODIGO_LIVRO
 AND VE.CODIGO_CLIENTE = CLI.CODIGO_CLIENTE
AND lower(CLI.MORADA) like '%lisboa%'
And ve.quantidade = tab.total
Group by Titulo;

EXEC SQLCHECK('FIRSRCNFVCMUOYM');

--EX 7:
7.
Select titulo "Total de Livros", tab1.autores "Total de Autores", tab2.editoras "Total de Editoras"
From (Select count(Titulo) titulo
      From Livros)tab,(Select count(autores.nome)autores
                       From autores)tab1,(Select count(editoras.nome)editoras
                       From editoras)tab2
                       
;

EXEC SQLCHECK('FICQADRGLVCOPJU');  

--EX 8:
8.
select 'O autor ' || aut.nome || ' escreveu ' || count(livros.codigo_livro) || ' e ' || tab.num_edit || ' sob a alçada da editora FCA - EDITORA' as "Resultado"
from autores aut, livros, (select codigo_autor, count(codigo_livro) as num_edit
                           from livros l, editoras e
                           where l.codigo_editora = e.codigo_editora
                           and e.nome like '%FCA%'
                           group by codigo_autor)tab
where aut.codigo_autor = tab.codigo_autor
and aut.codigo_autor = livros.codigo_autor
group by aut.nome, tab.num_edit
order by 1;

EXEC SQLCHECK('FIOURJBHGHYOQJF'); 



                        


                     