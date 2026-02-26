# DB Project — Cafes/Sales (PostgreSQL)

В репозитории лежат:

- `schema.sql` — создание таблиц (3НФ, PK/FK, ограничения)
- `er_diagram.pdf` — ER-диаграмма
- `csv_import/` — подготовленные CSV для импорта данных
- `load_from_csv.sql` — загрузка CSV через `\copy`
- `seed.sql` — альтернативная загрузка через `INSERT` (если CSV не используете)

## Требования
- PostgreSQL 13+ (подойдёт и новее)
- `psql` (клиент PostgreSQL)

## Быстрый старт (вариант с CSV)

```bash
createdb shoes_sales
psql -d shoes_sales -f schema.sql
psql -d shoes_sales -f load_from_csv.sql
```

> В `load_from_csv.sql` используются команды `\copy`, поэтому запускать нужно именно через `psql`.

## Альтернатива (вариант без CSV)

```bash
createdb shoes_sales
psql -d shoes_sales -f schema.sql
psql -d shoes_sales -f seed.sql
```

## Проверка

Примеры запросов:

```sql
-- Кол-во заказов
SELECT COUNT(*) FROM orders;

-- Топ-5 товаров по количеству
SELECT p.name, SUM(oi.quantity) AS qty
FROM order_items oi
JOIN product_variants pv ON pv.id = oi.product_variant_id
JOIN products p ON p.id = pv.product_id
GROUP BY p.name
ORDER BY qty DESC
LIMIT 5;
```

## Структура

```text
.
├─ schema.sql
├─ load_from_csv.sql
├─ seed.sql
├─ er_diagram.pdf
└─ csv_import/
   ├─ customers.csv
   ├─ employees.csv
   ├─ orders.csv
   ├─ order_items.csv
   ├─ products.csv
   ├─ product_variants.csv
   └─ ...
```
