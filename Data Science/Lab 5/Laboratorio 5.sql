--Inicio lab 5 Consultas 
select id, nombre, promedio FROM estudiante where promedio > 90

select nombre, materia from estudiante, asignacion where estudiante.id = asignacion.estudiante_id

Select nombre, materia from estudiante, asignacion where estudiante.id = asignacion.estudiante_id and nombre = 'Ignacia'

Select Distinct nombre, materia from estudiante, asignacion where estudiante.id = asignacion.estudiante_id and nombre = 'Ignacia'

select id from universidad where universidad = 'Ante Incorporated'

Select nombre, nota from estudiante, asignacion where estudiante.id = asignacion.estudiante_id
and materia = 'D' and universidad_id = 55
--Ejemplo de error
Select id from universidad, asignacion where universidad.id = asignacion.universidad_id

Select universidad.id from universidad, asignacion where universidad.id = asignacion.universidad_id

Select universidad, direccion from universidad, asignacion where universidad.id = asignacion.universidad_id and direccion = 'Uruguay' and materia = 'A'


Select Distinct universidad, direccion from universidad, asignacion where universidad.id = asignacion.universidad_id and direccion = 'Uruguay' and materia = 'A'

Select estudiante.id, nombre, promedio, universidad from estudiante, universidad, asignacion 
where asignacion.estudiante_id = estudiante.id
and asignacion.universidad_id = universidad.id

Select estudiante.id, nombre, promedio, universidad
from estudiante, universidad, asignacion
where asignacion.estudiante_id = estudiante.id
and asignacion.universidad_id = universidad.id
order by promedio desc

Select estudiante.id, nombre, promedio, universidad
from estudiante, universidad, asignacion
where asignacion.estudiante_id = estudiante.id
and asignacion.universidad_id = universidad.id
order by promedio desc, universidad

Select estudiante.id, nombre, promedio, universidad
from estudiante, universidad, asignacion
where asignacion.estudiante_id = estudiante.id
and asignacion.universidad_id = universidad.id
order by promedio desc, nombre, universidad

select id, universidad from universidad where universidad like '%Corp%'
select id, universidad from universidad where universidad like '%CORP%'
select * from universidad where universidad like '%Corp%'

select * from estudiante, universidad

select id, nombre, apellido, promedio, promedio/10 from estudiante
select id, nombre, apellido, promedio, promedio/10.0 from estudiante
select id, nombre, apellido, promedio, promedio/10.0 as prom10 from estudiante

-- CONJUNTOS

SELECT estudiante.id, nombre, apellido, promedio, universidad, telefono
FROM estudiante, universidad, asignacion
WHERE asignacion.estudiante_id = estudiante.id
AND asignacion.universidad_id = universidad.id

SELECT E.id, nombre, apellido, promedio, universidad, telefono
FROM estudiante E, universidad U, asignacion A
WHERE A.estudiante_id = E.id
AND A.universidad_id = U.id

SELECT E1.id, E1.nombre, E1.promedio, E2.id, E2.nombre, E2.promedio
FROM estudiante E1, estudiante E2
WHERE E1.promedio = E2.promedio;

SELECT E1.id, E1.nombre, E1.promedio, E2.id, E2.nombre, E2.promedio
FROM estudiante E1, estudiante E2
WHERE E1.promedio = E2.promedio
AND E1.id <> E2.id;

SELECT E1.id, E1.nombre, E1.promedio, E2.id, E2.nombre, E2.promedio
FROM estudiante E1, estudiante E2
WHERE E1.promedio = E2.promedio
AND E1.id < E2.id;

SELECT universidad FROM universidad
UNION
SELECT nombre FROM estudiante;

SELECT universidad as todos_los_nombres FROM universidad
UNION
SELECT nombre as todos_los_nombres FROM estudiante;

SELECT universidad as todos_los_nombres FROM universidad
UNION ALL
SELECT nombre as todos_los_nombres FROM estudiante;

SELECT universidad as todos_los_nombres FROM universidad
UNION ALL
SELECT nombre as todos_los_nombres FROM estudiante
ORDER BY todos_los_nombres;

SELECT estudiante_id FROM asignacion WHERE materia = 'D'
INTERSECT
SELECT estudiante_id FROM asignacion WHERE materia = 'A'

SELECT A1.estudiante_id
FROM asignacion A1, asignacion A2
WHERE A1.estudiante_id = A2.estudiante_id
AND A1.materia = 'D' AND A2.materia = 'A';

SELECT estudiante_id FROM asignacion WHERE materia = 'D'
EXCEPT
SELECT estudiante_id FROM asignacion WHERE materia = 'A';

SELECT A1.estudiante_id
FROM asignacion A1, asignacion A2
WHERE A1.estudiante_id = A2.estudiante_id
AND A1.materia = 'D' AND A2.materia <> 'A';

SELECT DISTINCT A1.estudiante_id
FROM asignacion A1, asignacion A2
WHERE A1.estudiante_id = A2.estudiante_id
AND A1.materia = 'D' AND A2.materia <> 'A';

--Consulta y subconsulta
SELECT id, nombre
FROM estudiante
WHERE id in (SELECT estudiante_id FROM asignacion WHERE materia = 'B');

SELECT estudiante.id, nombre
FROM estudiante, asignacion
WHERE estudiante.id = asignacion.estudiante_id
AND materia = 'B';

-- Consulta compiladores
SELECT nombre
FROM estudiante
WHERE id in (SELECT estudiante_id FROM asignacion WHERE materia = 'C');

SELECT DISTINCT nombre
FROM estudiante, asignacion
WHERE estudiante.id = asignacion.estudiante_id
AND materia = 'C';

-- Promedio 
SELECT promedio
FROM estudiante
WHERE id IN (SELECT estudiante_id FROM asignacion WHERE materia = 'C');


SELECT DISTINCT promedio
FROM estudiante, asignacion
WHERE estudiante.id = asignacion.estudiante_id
AND materia = 'C';

SELECT promedio
FROM estudiante, asignacion
WHERE estudiante.id = asignacion.estudiante_id
AND materia = 'C';

-- Estudiantes que están asignados a base de datos y no a análisis (D)
SELECT id, nombre
FROM estudiante
WHERE id in (SELECT estudiante_id FROM asignacion WHERE materia = 'D')
AND id not in (SELECT estudiante_id FROM asignacion WHERE materia = 'A');

SELECT id, nombre
FROM estudiante
WHERE id in (SELECT estudiante_id FROM asignacion WHERE materia = 'D')
AND not id in (SELECT estudiante_id FROM asignacion WHERE materia = 'A');

-- Todas las universidades que tengan otras universidades en la misma dirección
SELECT universidad, direccion
FROM universidad U1
WHERE exists (SELECT * from universidad U2 WHERE U2.direccion = U1.direccion);

SELECT universidad, direccion
FROM universidad U1
WHERE exists (SELECT * from universidad U2 WHERE U2.direccion = U1.direccion
AND U1.id <> U2.id);

--Estudiantes con los promedios más altos
SELECT nombre, promedio
FROM estudiante E1
WHERE not exists (SELECT * FROM estudiante E2
WHERE E2.promedio > E1.promedio);


-- Estudiantes con los promedios más altos
SELECT nombre, promedio
FROM estudiante
WHERE promedio >= ALL(SELECT promedio FROM estudiante);

SELECT nombre
FROM estudiante E1
WHERE promedio > ALL(SELECT promedio FROM estudiante E2
WHERE E2.id <> E1.id);

--Ejemplo ANY
SELECT nombre
FROM estudiante E1
WHERE NOT promedio <= ANY(SELECT promedio FROM estudiante E2
WHERE E2.id <> E1.id);

SELECT nombre, promedio
FROM estudiante
WHERE promedio > ANY(SELECT promedio FROM estudiante);


-- Equivalencia ANY con EXISTS
SELECT nombre, promedio
FROM estudiante E1
WHERE EXISTS (SELECT * FROM estudiante E2
WHERE E2.promedio < E1.promedio)

-- Ejemplo SELECT en FROM
SELECT id, nombre, promedio, promedio/10.0 as prom10
FROM estudiante
WHERE prom10 > 6.0;

SELECT id, nombre, promedio, promedio/10.0 as prom10
FROM estudiante
WHERE promedio/10.0 > 6.0;

SELECT *
FROM (SELECT id, nombre, promedio, promedio/10.0 as prom10
      FROM estudiante) G
WHERE prom10 > 6.0;

-- Ejemplo SELECT en SELECT
SELECT universidad, nombre, promedio
FROM universidad, asignacion, estudiante
WHERE universidad.id = asignacion.universidad_id
AND estudiante.id = asignacion.estudiante_id
AND promedio >= all
    (SELECT promedio FROM estudiante, asignacion
     WHERE estudiante.id = asignacion.estudiante_id
     AND universidad.id = asignacion.universidad_id);

-- Universidades con mejores promedios
-- Da error
SELECT universidad,
(SELECT nombre, promedio
 FROM asignacion, estudiante
 WHERE universidad.id = asignacion.universidad_id
 AND estudiante.id = asignacion.estudiante_id
 AND promedio >= all
     (SELECT promedio FROM estudiante, asignacion
      WHERE estudiante.id = asignacion.estudiante_id
      AND universidad.id = asignacion.universidad_id)) AS mejor_promedio
FROM universidad;

-- Sin error
SELECT universidad,
(SELECT DISTINCT promedio
 FROM asignacion, estudiante
 WHERE universidad.id = asignacion.universidad_id
 AND estudiante.id = asignacion.estudiante_id
 AND promedio >= all
     (SELECT promedio FROM estudiante, asignacion
      WHERE estudiante.id = asignacion.estudiante_id
      AND universidad.id = asignacion.universidad_id)) AS mejor_promedio
FROM universidad;


--Universidades y nombres con mejor promedio
SELECT universidad,
(SELECT DISTINCT nombre
 FROM asignacion, estudiante
 WHERE universidad.id = asignacion.universidad_id
 AND estudiante.id = asignacion.estudiante_id
 AND promedio >= all
     (SELECT promedio FROM estudiante, asignacion
      WHERE estudiante.id = asignacion.estudiante_id
      AND universidad.id = asignacion.universidad_id)) AS mejor_promedio
FROM universidad;

--Join
SELECT universidad,
       (SELECT DISTINCT nombre
        from asignacion,
             estudiante
        where universidad.id = asignacion.universidad_id
          and estudiante.id = asignacion.estudiante_id
          and promedio >= all (select promedio
                               from estudiante,
                                    asignacion
                               where estudiante.id = asignacion.universidad_id)) as mejor_promedio
from universidad;


select distinct nombre, materia
from estudiante,
     asignacion
where estudiante.id = asignacion.estudiante_id;

select distinct nombre, materia
from estudiante
         Inner join asignacion on estudiante.id = asignacion.estudiante_id;

select Distinct nombre, materia
from estudiante
         join asignacion on estudiante.id = asignacion.estudiante_id;


---
select nombre, promedio
from estudiante,
     asignacion
where estudiante.id = asignacion.estudiante_id
  and materia = 'D'
  and universidad_id = 55;

select nombre, promedio
from estudiante
         join asignacion on estudiante.id = asignacion.estudiante_id
where materia = 'D'
  and universidad_id = 55

select nombre, promedio
from estudiante
         join asignacion on estudiante.id = asignacion.estudiante_id and materia = 'D' and universidad_id = 55;

---
select asignacion.estudiante_id, nombre, promedio, asignacion.universidad_id, direccion
from asignacion,
     estudiante,
     universidad
where asignacion.estudiante_id = estudiante.id
  and asignacion.universidad_id = universidad.id;

select asignacion.estudiante_id, nombre, promedio, asignacion.universidad_id, direccion
from asignacion
         join estudiante
         join universidad on asignacion.estudiante_id = estudiante.id and asignacion.universidad_id = universidad.id;

select asignacion.estudiante_id, nombre, promedio, asignacion.universidad_id, direccion
from (asignacion join estudiante on asignacion.estudiante_id = estudiante.id)
         join universidad on asignacion.universidad_id = universidad.id;


---
select distinct nombre, materia
from estudiante naturaal
         join asignacion;

---

select nombre, promedio
from estudiante
         join asignacion on estudiante.id = asignacion.estudiante_id
where materia = 'D'
  and universidad_id = 55;

select nombre, promedio
from estudiante
         natural join asignacion
where materia = 'D'
  and universidad_id = 55;

select nombre, promedio
from estudiante
         join asignacion using (id)
where materia = 'D'
  and universidad_id = 55;

--

select e1.id, e1.nombre, e1.promedio, e2.id, e2.nombre, e2.promedio
from estudiante e1,
     estudiante e2
where e1.promedio = e2.promedio
  and e1.id < e2.id;


select e1.id, e1.nombre, e1.promedio, e2.id, e2.nombre, e2.promedio
from estudiante e1
         join estudiante e2
              using (promedio) on e1.id < e2.id;

select e1.id, e1.nombre, e1.promedio, e2.id, e2.nombre, e2.promedio
from estudiante e1
         join estudiante e2
              using (promedio)
where e1.id < e2.id;

---

select nombre, estudiante.id, asignacion.universidad_id, asignacion.materia
from estudiante
         inner join asignacion using (id);

select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante
         left outer join asignacion using (id);
select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante
         left join asignacion using (id);

select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante
         natural left join asignacion;
select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante,
     asignacion
where estudiante.id = asignacion.estudiante_id
union
select nombre, estudiante.id, null, null
from estudiante
where id not in (Select estudiante_id from asignacion);

----

select nombre, estudiante.id, asignacion.universidad_id, materia
from asignacion
         natural left join estudiante;
select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante
         natural right join asignacion;

select nombre, estudiante.id, asignacion.universidad_id, materia
from estudiante
         full outer join asignacion using (id)
--Agregaciones y agrupaciones
select * from estudiante
select avg(promedio) from estudiante

select * from estudiante
select min(promedio) from estudiante

select * from estudiante, asignacion
where estudiante.id = asignacion.estudiante_id and materia = 'C'

select min(promedio) from estudiante, asignacion
where estudiante.id = asignacion.estudiante_id and materia = 'C'

select min(nota) from estudiante, asignacion
where estudiante.id = asignacion.estudiante_id and materia = 'C'

select avg(promedio) from estudiante, asignacion
where estudiante.id = asignacion.estudiante_id and materia = 'C'

select avg(promedio) from estudiante where estudiante.id IN (Select estudiante_id from asignacion where materia = 'D')

Select * from estudiante where promedio > 95
Select count(*) from estudiante where promedio > 95

select count(*) from asignacion where universidad_id = 55
select count(distinct estudiante_id) from asignacion where universidad_id = 55

Select * from estudiante E1
Where (select count(*) from estudiante E2
		where E2.id <> E1.id and E2.promedio = E1.promedio) =
		(select count (*) from estudiante E2
		where E2.id <> E1.id and E2.nombre=E1.nombre)

Select DB.avg_prom, NO_DB.avg_prom
From (Select avg(promedio) as avg_prom from estudiante
	where id in (
		select estudiante_id from asignacion where materia = 'D')) as DB, 
	(select avg(promedio) as avg_prom from estudiante
	where id NOT IN (
	Select estudiante_id FROM asignacion where materia = 'D')) as NO_DB

Select DB.avg_prom - NO_DB.avg_prom
From (Select avg(promedio) as avg_prom from estudiante
	where id in (
		select estudiante_id from asignacion where materia = 'D')) as DB, 
	(select avg(promedio) as avg_prom from estudiante
	where id NOT IN (
	Select estudiante_id FROM asignacion where materia = 'D')) as NO_DB

Select (Select avg(promedio) as avg_prom From estudiante
	where id IN (
		Select estudiante_id From asignacion where materia = 'D')) -
		(Select avg(promedio) as avg_prom from estudiante
		where id not in (select estudiante_id from asignacion where materia ='D')) as DIF
		from estudiante

Select Distinct (Select avg(promedio) as avg_prom From estudiante
	where id IN (
		Select estudiante_id From asignacion where materia = 'D')) -
		(Select avg(promedio) as avg_prom from estudiante
		where id not in (select estudiante_id from asignacion where materia ='D')) as DIF
		from estudiante

Select * from asignacion order by univerisdad_id
select universidad_id, count(*) from asignacion group by universidad_id order by universidad_id

Select u.id,  count(*) from universidad u JOIN asignacion a ON (u.id=a.universidad_id)
group by u.id
order by u.id

Select u.id, universidad, count(*) from universidad u JOIN asignacion a ON (u.id=a.universidad_id)
group by u.id
order by u.id

Select u.direccion, sum(e.promedio)
from universidad u JOIN asignacion a ON (u.id = a.universidad_id)
Join estudiante e ON (e.id = a.estudiante_id)
GROUP BY u.direccion

Select distinct direccion from universidad

Select u.universidad, a.materia, a.nota
from asignacion a JOin universidad u ON (u.id = a.universidad_id)
order by u.id, a.materia

SELECT 
    u.universidad, 
    a.materia, 
    MIN(a.nota) AS nota_menor, 
    MAX(a.nota) AS nota_mayor
FROM asignacion a 
JOIN universidad u ON u.id = a.universidad_id
GROUP BY u.universidad, a.materia
ORDER BY u.universidad, a.materia;



SELECT *
FROM (
    SELECT 
        u.universidad, 
        a.materia, 
        MIN(a.nota) AS nota_menor, 
        MAX(a.nota) AS nota_mayor
    FROM asignacion a 
    JOIN universidad u ON (u.id = a.universidad_id)
    GROUP BY u.id, a.materia
) RES
WHERE RES.nota_menor <> RES.nota_mayor;


SELECT nota_mayor - nota_menor
FROM (
    SELECT u.universidad, a.materia,
           MIN(a.nota) AS nota_menor,
           MAX(a.nota) AS nota_mayor
    FROM asignacion a
    JOIN universidad u ON (u.id = a.universidad_id)
    GROUP BY u.id, a.materia
) RES
WHERE RES.nota_menor <> RES.nota_mayor;

SELECT MAX(nota_mayor - nota_menor)
FROM (
    SELECT u.universidad, a.materia,
           MIN(a.nota) AS nota_menor,
           MAX(a.nota) AS nota_mayor
    FROM asignacion a
    JOIN universidad u ON (u.id = a.universidad_id)
    GROUP BY u.id, a.materia
) RES
WHERE RES.nota_menor <> RES.nota_mayor;

SELECT e.id, u.universidad
FROM estudiante e
JOIN asignacion a ON (e.id = a.estudiante_id)
JOIN universidad u ON (u.id = a.universidad_id)
ORDER BY e.id;

SELECT e.id, COUNT(DISTINCT u.universidad)
FROM estudiante e
JOIN asignacion a ON (e.id = a.estudiante_id)
JOIN universidad u ON (u.id = a.universidad_id)
GROUP BY e.id;




SELECT e.id, e.nombre, COUNT(DISTINCT u.universidad)
FROM estudiante e
JOIN asignacion a ON (e.id = a.estudiante_id)
JOIN universidad u ON (u.id = a.universidad_id)
GROUP BY e.id

UNION

SELECT e.id, e.nombre, 0
FROM estudiante e
JOIN asignacion a ON (e.id = a.estudiante_id)
JOIN universidad u ON (u.id = a.universidad_id)
WHERE e.id NOT IN (SELECT estudiante_id FROM asignacion);


Select u.universidad from universidad U JOIN asignacion a ON (u.id = a.universidad_id)
group by u.universidad having count(*) < 3

Select materia from estudiante e JOIN asignacion a ON (e.id = a.estudiante_id)
group by materia
HAVING max(e.promedio) < (Select AVG(promedio) from estudiante)

Select materia from estudiante e JOIN asignacion a ON (e.id = a.estudiante_id)
group by materia
HAVING max(e.promedio) < 100


