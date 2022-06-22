EXEC NALUNO (2020121705);

--EX 3:
3.
SELECT COUNT(CODIGO_LIVRO) AS "Total livros de Inform�tica"
FROM LIVROS
WHERE upper(GENERO) = 'INFORM�TICA';

EXEC SQLCHECK('FEAHQXIAJQTWFEG');

--EX 4
4:
SELECT COUNT(CODIGO_LIVRO) AS "Total de Livros", AVG(PRECO_TABELA)AS "Pre�o M�dio", SUM(LIVROS.UNIDADES_VENDIDAS) AS "Total de livros vendidos"
FROM LIVROS;

EXEC SQLCHECK('FETVZGABLESUGNU');

--EX 5
5.
SELECT GENERO, COUNT(CODIGO_LIVRO) AS "QUANTIDADE"
FROM LIVROS
GROUP by GENERO
ORDER by GENERO;

EXEC SQLCHECK('FEHHHERCGBTHHIN');

--EX 6:
6.
SELECT TITULO, min(VENDAS.PRECO_UNITARIO) AS "P_MAIS_BAIXO", max(VENDAS.PRECO_UNITARIO) AS "P_MAIS_ALTO", round(avg(VENDAS.PRECO_UNITARIO),2) as "P_MEDIO"
FROM LIVROS,VENDAS
WHERE LIVROS.CODIGO_LIVRO = VENDAS.CODIGO_LIVRO AND UPPER(GENERO) = 'INFORM�TICA'
GROUP BY TITULO
ORDER by TITULO;

EXEC SQLCHECK('FEGFYBLDUJATION');

--EX 7:
7.
SELECT GENERO, (max(PRECO_TABELA)- min(PRECO_TABELA)) AS "DIFERENCA"
FROM LIVROS
GROUP BY GENERO
ORDER BY GENERO;

EXEC SQLCHECK('FECASYJEHNOCJLA');

--EX 8:
8.
SELECT TITULO, PRECO_TABELA AS "PRECO", SUM(QUANTIDADE) AS "NUM_VENDIDOS", SUM(QUANTIDADE * PRECO_TABELA) AS "REC_ESPERADA", SUM(QUANTIDADE * PRECO_UNITARIO) AS "REC_EFECTIVA"
FROM LIVROS, VENDAS
WHERE LIVROS.CODIGO_LIVRO = VENDAS.CODIGO_LIVRO
GROUP BY TITULO,PRECO_TABELA
ORDER BY TITULO;

EXEC SQLCHECK('FEPZSNIFJMVFKFO');

--EX 9:
9.
SELECT GENERO, CEIL(AVG(PRECO_TABELA)) AS "Pre�o M�dio"
FROM LIVROS
HAVING count(CODIGO_LIVRO) > 4
GROUP BY GENERO
ORDER BY CEIL(AVG(PRECO_TABELA));

EXEC SQLCHECK('FETBBIEGOHCHLSK');

--EX 10:
10.
SELECT AUTORES.NOME, min(PRECO_TABELA) as "Preco Minimo"
FROM LIVROS, AUTORES
WHERE AUTORES.CODIGO_AUTOR = LIVROS.CODIGO_AUTOR
GROUP BY AUTORES.NOME
HAVING min(LIVROS.PRECO_TABELA) > 30
ORDER BY 2;

EXEC SQLCHECK('FEJGQHLHMZOLMUK');

--EX 11:
11.
SELECT CLIENTES.CODIGO_CLIENTE, CLIENTES.NOME, SUM(QUANTIDADE) AS "N.Livros", ROUND(AVG(PRECO_UNITARIO),2) AS "Preco Medio", COUNT(DISTINCT CODIGO_AUTOR) AS "N. Autores Diferentes"
FROM LIVROS,CLIENTES,VENDAS
WHERE LIVROS.CODIGO_LIVRO = VENDAS.CODIGO_LIVRO AND VENDAS.CODIGO_CLIENTE = CLIENTES.CODIGO_CLIENTE AND CLIENTES.MORADA like '%Lisboa%'
GROUP BY CLIENTES.CODIGO_CLIENTE, CLIENTES.NOME
HAVING SUM(QUANTIDADE) > 4
ORDER BY CLIENTES.NOME;

EXEC SQLCHECK('FEUVKRRIJJGINIO');

--EX 12:
12.
SELECT AUTORES.NOME, REPLACE(COUNT(LIVROS.CODIGO_LIVRO),0,'Nenhum') AS "Num. Livros"
FROM LIVROS, AUTORES
WHERE AUTORES.CODIGO_AUTOR = LIVROS.CODIGO_AUTOR (+)
GROUP BY AUTORES.NOME
ORDER BY AUTORES.NOME;

EXEC SQLCHECK('FENMESWJTYLQODP');

SELECT AUTORES.NOME, REPLACE(COUNT(LIVROS.CODIGO_LIVRO),0,'Nenhum') AS "Num. Livros"
FROM AUTORES
LEFT OUTER JOIN LIVROS
ON  AUTORES.CODIGO_AUTOR = LIVROS.CODIGO_AUTOR
GROUP BY AUTORES.NOME
ORDER BY AUTORES.NOME;

EXEC SQLCHECK('FENMESWJTYLQODP');





