-- PostgreSQL schema for Shoe Sales / Warehouses (3NF)
BEGIN;

DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS product_variants CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS colors CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS manufacturers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS warehouses CASCADE;

CREATE TABLE customers (
  id            BIGSERIAL PRIMARY KEY,
  full_name     TEXT NOT NULL,
  email         TEXT NOT NULL UNIQUE,
  phone         TEXT
);

CREATE TABLE positions (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

CREATE TABLE employees (
  id            BIGSERIAL PRIMARY KEY,
  full_name     TEXT NOT NULL,
  position_id   BIGINT NOT NULL REFERENCES positions(id)
);

CREATE TABLE warehouses (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  address       TEXT NOT NULL,
  capacity      INTEGER NOT NULL CHECK (capacity >= 0),
  shelf_count   INTEGER NOT NULL CHECK (shelf_count >= 0)
);

CREATE TABLE categories (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

CREATE TABLE manufacturers (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

CREATE TABLE colors (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

CREATE TABLE products (
  id               BIGSERIAL PRIMARY KEY,
  model_name       TEXT NOT NULL UNIQUE,
  category_id      BIGINT NOT NULL REFERENCES categories(id),
  manufacturer_id  BIGINT NOT NULL REFERENCES manufacturers(id)
);

-- A specific sellable SKU: (model, size, color) with price
CREATE TABLE product_variants (
  id          BIGSERIAL PRIMARY KEY,
  product_id  BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  size        INTEGER NOT NULL CHECK (size > 0),
  color_id    BIGINT NOT NULL REFERENCES colors(id),
  price       NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  UNIQUE (product_id, size, color_id, price)
);

CREATE TABLE orders (
  id            BIGSERIAL PRIMARY KEY,
  order_number  INTEGER NOT NULL UNIQUE,
  order_date    DATE NOT NULL,
  customer_id   BIGINT NOT NULL REFERENCES customers(id),
  employee_id   BIGINT NOT NULL REFERENCES employees(id),
  warehouse_id  BIGINT NOT NULL REFERENCES warehouses(id)
);

CREATE TABLE order_items (
  id          BIGSERIAL PRIMARY KEY,
  order_id    BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  variant_id  BIGINT NOT NULL REFERENCES product_variants(id),
  quantity    INTEGER NOT NULL CHECK (quantity > 0),
  unit_price  NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

COMMIT;