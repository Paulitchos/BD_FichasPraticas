EXEC NALUNO (2020121705);

--exerc3
Select a.codigo_autor, a.nome,l.titulo,l.preco_tabela,e.codigo_editora
From autores a, livros l,editoras e,(Select max(li.preco_tabela)maiscaro
                                      From livros li,editoras ed , autores au
                                      Where li.Codigo_editora = ed.Codigo_editora 
                                        and upper(ed.nome) like '%FCA - EDITORA')tab
                                          
Where a.Codigo_autor = l.Codigo_autor and l.preco_tabela = tab.maiscaro and e.Codigo_editora = l.Codigo_editora;
EXEC SQLCHECK('FJRKTIPCVCKCMKE'); 



--exerc4

Select a.nome,l.titulo,Count(l.titulo)AS "LIVROS FCA",Count(e.codigo_editora)AS "Total de Livros"
From autores a, livros l,editoras e,(Select max(li.preco_tabela)maiscaro
                                      From livros li,editoras ed , autores au
                                      Where li.Codigo_editora = ed.Codigo_editora 
                                        and upper(ed.nome) like '%FCA - EDITORA')tab
                                          
Where a.Codigo_autor = l.Codigo_autor and l.preco_tabela = tab.maiscaro and e.Codigo_editora = l.Codigo_editora
Group by a.nome,l.titulo;
EXEC SQLCHECK('FJYYEFTDFCNLNCV'); 

--exerc 5

Select a.nome , nvl(tab.genero,0)AS "Genero Preferido" , nvl(Count(l.Codigo_livro),0)AS "Total de Livros"  
From autores a, livros l, (Select au.Codigo_autor codigo,Count(genero)genero 
                            From autores au, livros li
                            Where li.Codigo_autor = au.codigo_autor(+)
                              and upper(au.genero_preferido) = upper(li.genero)
                            Group by au.Codigo_autor
                            )tab
Where a.Codigo_autor = l.Codigo_autor(+) and tab.codigo(+) = l.Codigo_autor
Group by a.nome , tab.genero
Order by 1
;

EXEC SQLCHECK('FJDVQTKERNOGOIZ'); 


--exerc6

Select ed.codigo_editora, ed.nome,max(tab.Nlivros) as NLIVROS
From editoras ed,livros li,(Select count(codigo_livro) Nlivros
                            From LIvros l, Editoras e
                            Where e.CODIGO_EDITORA = l.CODIGO_EDITORA
                            Group by e.CODIGO_EDITORA)tab,(Select  max(l.unidades_vendidas) max
                                                           From LIvros l, Editoras e
                                                           Where e.CODIGO_EDITORA = l.CODIGO_EDITORA)tab2
Where ed.CODIGO_EDITORA = li.CODIGO_EDITORA and li.Unidades_vendidas = tab2.max
Group by ed.Codigo_editora , ed.nome ;


                            ;
EXEC SQLCHECK('FJPTWDFFGUNYPPQ');


--exerc7
select distinct RESULTADO as RESULTADO
from (select 'O autor ' || A.NOME || ' escreveu ' || B.LIVROS_CEDITORA || ' de ' || C.LIVROS_SEDITORA || ' livros para a editora ' || E.NOME || '.' as RESULTADO
From LIVROS L, EDITORAS E, AUTORES A, 
(select L.CODIGO_AUTOR as COD_AUTOR, count(L.CODIGO_LIVRO) as LIVROS_CEDITORA
From EDITORAS E, LIVROS L
Where L.CODIGO_EDITORA = E.CODIGO_EDITORA
  and E.NOME = (Select E.NOME as E_NOME
                From EDITORAS E, LIVROS L
                Where L.CODIGO_EDITORA = E.CODIGO_EDITORA
                  and L.UNIDADES_VENDIDAS = (Select max(UNIDADES_VENDIDAS)
                                              From LIVROS))
                                              Group by L.CODIGO_AUTOR)B
                                              ,
                                              (Select L.CODIGO_AUTOR as COD_AUTOR, nvl(count(L.CODIGO_LIVRO), 0) as LIVROS_SEDITORA
                                              From LIVROS L
                                              Group by L.CODIGO_AUTOR) C
where L.CODIGO_EDITORA = E.CODIGO_EDITORA
  and L.CODIGO_AUTOR = A.CODIGO_AUTOR
  and B.COD_AUTOR = A.CODIGO_AUTOR
  and C.COD_AUTOR = B.COD_AUTOR
  and lower(E.NOME) like '%fca%')
Order by RESULTADO;

EXEC SQLCHECK('FJXICTAGYVHAQIV');


--exerc8


Select B.NOME_CLI as NOME
from (select C.CODIGO_CLIENTE, C.NOME as NOME_CLI, min(L.PRECO_TABELA) as MIN_PRECO
      from CLIENTES C, LIVROS L, VENDAS V
      where C.CODIGO_CLIENTE = V.CODIGO_CLIENTE
        and L.CODIGO_LIVRO = V.CODIGO_LIVRO
      group by C.CODIGO_CLIENTE, C.NOME) B
where B.MIN_PRECO = (select min(PRECO_TABELA) from LIVROS L, VENDAS V where L.CODIGO_LIVRO = V.CODIGO_LIVRO)
order by 1;
EXEC SQLCHECK('FJYVAOUHXSNKROT'); 





                     