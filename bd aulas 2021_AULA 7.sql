EXEC NALUNO (2020121705);

--EX 3:
3.
select TITULO, PRECO_TABELA
from LIVROS
WHERE PRECO_TABELA = (SELECT MAX(PRECO_TABELA)
                      FROM LIVROS
                      WHERE lower(genero) like '%informática%');
;


EXEC SQLCHECK('FHKFRNECWCGPKRJ'); 

--EX 4:
4.
select TITULO, PRECO_TABELA
from LIVROS
WHERE lower(genero) like '%informática%' 
and PRECO_TABELA >= ALL(SELECT PRECO_TABELA
                      FROM LIVROS
                      WHERE lower(genero) like '%informática%');
;

EXEC SQLCHECK('FHMJGDUDTFPFLEE'); 

--EX 5:
5.
SELECT TITULO, PRECO_TABELA
FROM LIVROS OUTERLIV
WHERE lower(genero) like '%informática%' 
and not exists (SELECT PRECO_TABELA
FROM LIVROS
WHERE lower(genero) like '%informática%' and LIVROS.PRECO_TABELA > OUTERLIV.PRECO_TABELA);
;

EXEC SQLCHECK('FHFYVFEEGWWUMOF'); 

--EX 6:
6.
select TITULO, tab.PRECO_TABELA as "PRECO_TABELA"
from livros, (select max(preco_tabela) PRECO_TABELA
              from LIVROS
              where lower(genero) like '%informática%' 
              ) tab
where livros.preco_tabela = tab.PRECO_TABELA
;

EXEC SQLCHECK('FHQCKOQFKININNW'); 

--EX 7:
7.
SELECT DISTINCT AUTORES.NOME as "NOME"
FROM LIVROS, AUTORES, (SELECT AVG(PAGINAS) avgpaginas
                       FROM LIVROS
                       )tab
WHERE LIVROS.CODIGO_AUTOR = AUTORES.CODIGO_AUTOR
AND LIVROS.PAGINAS > tab.avgpaginas
ORDER BY 1;

EXEC SQLCHECK('FHWXXUBGIDJWOHR');  

--EX 8:
8.
select AUTORES.NOME
from LIVROS, autores
where autores.CODIGO_AUTOR = livros.CODIGO_AUTOR
group by autores.NOME
HAVING count(codigo_LIVRO) > (select avg(count(codigo_livro)) avglivro
                              from LIVROS, autores
                              where autores.CODIGO_AUTOR = livros.CODIGO_AUTOR
                              GROUP BY autores.NOME)
;


EXEC SQLCHECK('FHQBXYAHZSBJPGW'); 

--EX 9:
9.
--SELECT GENERO, TITULO, UNIDADES_VENDIDAS
--FROM LIVROS NATURAL JOIN (SELECT GENERO,max(UNIDADES_VENDIDAS) UNIDADES_VENDIDAS
--                          FROM LIVROS
--                          GROUP BY GENERO
--                          )
--ORDER BY 1
--;

SELECT GENERO, TITULO, UNIDADES_VENDIDAS
FROM LIVROS 
WHERE (GENERO,UNIDADES_VENDIDAS) in(SELECT GENERO,max(UNIDADES_VENDIDAS) UNIDADES_VENDIDAS
                                    FROM LIVROS
                                    GROUP BY GENERO)
ORDER BY 1
;

EXEC SQLCHECK('FHFMGEPISFXRQCN'); 

--EX 10:
10.
SELECT editoras.NOME
FROM EDITORAS,LIVROS
WHERE LIVROS.CODIGO_EDITORA = EDITORAS.CODIGO_EDITORA AND lower(GENERO) like '%aventura%' and to_char(LIVROS.DATA_EDICAO,'YYYY') = '2013'
GROUP BY editoras.NOME
HAVING count(codigo_livro) > any(SELECT count(l.codigo_livro)
                                 FROM EDITORAS e,LIVROS l
                                 WHERE L.CODIGO_EDITORA = E.CODIGO_EDITORA AND lower(l.GENERO) like '%aventura%' and to_char(L.DATA_EDICAO,'YYYY') = '2013'
                                 GROUP BY e.NOME) 
;

EXEC SQLCHECK('FHACSGFJFNNIRUK');
