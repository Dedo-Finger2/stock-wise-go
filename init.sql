CREATE TYPE "item_status" AS ENUM (
  'out_of_stock',
  'in_risk',
  'danger',
  'fine'
);

CREATE TABLE "users" (
  "id" text PRIMARY KEY NOT NULL,
  "email" varchar(200) UNIQUE NOT NULL,
  "password" varchar(255) NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp
);

CREATE TABLE "items" (
  "id" text PRIMARY KEY NOT NULL,
  "user_id" text NOT NULL,
  "name" varchar(255) NOT NULL,
  "description" varchar(255),
  "min_acceptable_quantity" integer NOT NULL,
  "category_id" text NOT NULL,
  "unit_type_id" text NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp
);

CREATE TABLE "item_price_logs" (
  "id" text PRIMARY KEY NOT NULL,
  "item_id" text NOT NULL,
  "price" decimal(10,2) NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "inventories" (
  "id" text PRIMARY KEY NOT NULL,
  "user_id" text UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "inventory_items" (
  "inventory_id" text NOT NULL,
  "item_id" text NOT NULL,
  "location_id" text,
  "valid_until" timestamp,
  "discarded" bool NOT NULL,
  "quantity" float NOT NULL,
  "status" item_status NOT NULL,
  "added_at" timestamp NOT NULL
);

CREATE TABLE "purchase_lists" (
  "id" text PRIMARY KEY NOT NULL,
  "user_id" text NOT NULL,
  "created_at" timestamp NOT NULL,
  "completed_at" timestamp
);

CREATE TABLE "purchase_list_items" (
  "id" text PRIMARY KEY NOT NULL,
  "purchase_list_id" text NOT NULL,
  "item_id" text NOT NULL
);

CREATE TABLE "purchases" (
  "purchase_list_item" text PRIMARY KEY NOT NULL,
  "quantity_bought" float NOT NULL,
  "unit_price_paid" decimal(10,2),
  "total_price_paid" decimal(10,2)
);

CREATE TABLE "categories" (
  "id" text PRIMARY KEY NOT NULL,
  "name" varchar(200) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "units" (
  "id" text PRIMARY KEY NOT NULL,
  "name" varchar(150) UNIQUE NOT NULL,
  "abbreviation" varchar(15) NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "locations" (
  "id" text PRIMARY KEY NOT NULL,
  "name" varchar(255) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "activity_logs" (
  "id" text PRIMARY KEY NOT NULL,
  "user_id" text NOT NULL,
  "action" varchar(255) NOT NULL,
  "target_table" varchar(50) NOT NULL,
  "target_id" text NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE UNIQUE INDEX ON "inventory_items" ("inventory_id", "item_id");

COMMENT ON TABLE "users" IS 'Tabela que conterá os dados relacionado aos usuários.';

COMMENT ON COLUMN "users"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "users"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "users"."updated_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "items" IS 'Tabela que conterá os dados relacionado aos itens.';

COMMENT ON COLUMN "items"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "items"."min_acceptable_quantity" IS 'Default = 0';

COMMENT ON COLUMN "items"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "items"."updated_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "item_price_logs" IS 'Tabela que conterá os dados relacionados ao histórico de preço dos itens.';

COMMENT ON COLUMN "item_price_logs"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "item_price_logs"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "inventories" IS 'Tabela que conterá os dados relacionados aos inventário dos usuários.';

COMMENT ON COLUMN "inventories"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "inventories"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "inventory_items" IS 'Tabela que conterá os dados relacionados aos itens dentro dos inventários.';

COMMENT ON COLUMN "inventory_items"."discarded" IS 'Default = false';

COMMENT ON COLUMN "inventory_items"."quantity" IS 'Default = 0';

COMMENT ON COLUMN "inventory_items"."added_at" IS 'Default = current_timestamp';

COMMENT ON TABLE "purchase_lists" IS 'Tabela que conterá os dados relacionados as listas de compras.';

COMMENT ON COLUMN "purchase_lists"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "purchase_lists"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "purchase_list_items" IS 'Tabela que conterá os dados relacionados aos itens dentro das listas de compras.';

COMMENT ON TABLE "purchases" IS 'Tabela que conterá os dados relacionados a listas de compras que foram completas.';

COMMENT ON TABLE "categories" IS 'Tabela que conterá os dados relacionados as categorias dos itens.';

COMMENT ON COLUMN "categories"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "categories"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "units" IS 'Tabela que conterá os dados relacionados as unidades de medida dos itens.';

COMMENT ON COLUMN "units"."id" IS 'Dado gerado no servidor.';

COMMENT ON COLUMN "units"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "locations" IS 'Tabela que conterá os dados relacionados as possíveis localizações dos itens.';

COMMENT ON COLUMN "locations"."created_at" IS 'Dado gerado no servidor.';

COMMENT ON TABLE "activity_logs" IS 'Tabela que conterá os dados relacionados ao log de atividades executadas por algum usuário.';

COMMENT ON COLUMN "activity_logs"."created_at" IS 'Dado gerado no servidor.';

ALTER TABLE "items" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "items" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "items" ADD FOREIGN KEY ("unit_type_id") REFERENCES "units" ("id");

ALTER TABLE "item_price_logs" ADD FOREIGN KEY ("item_id") REFERENCES "items" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "inventories" ("user_id");

ALTER TABLE "inventory_items" ADD FOREIGN KEY ("inventory_id") REFERENCES "inventories" ("id");

ALTER TABLE "inventory_items" ADD FOREIGN KEY ("item_id") REFERENCES "items" ("id");

ALTER TABLE "inventory_items" ADD FOREIGN KEY ("location_id") REFERENCES "locations" ("id");

ALTER TABLE "purchase_lists" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "purchase_list_items" ADD FOREIGN KEY ("purchase_list_id") REFERENCES "purchase_lists" ("id");

ALTER TABLE "purchase_list_items" ADD FOREIGN KEY ("item_id") REFERENCES "items" ("id");

ALTER TABLE "purchases" ADD FOREIGN KEY ("purchase_list_item") REFERENCES "purchase_list_items" ("id");

ALTER TABLE "activity_logs" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

INSERT INTO "categories"
("id", "name", "created_at")
VALUES 
('1f1cdcb0-7568-4497-8343-8ff3c05de660', 'MEDICAMENTO', CURRENT_TIMESTAMP),
('5f58a8fd-70a8-43d7-86e5-421ea2fd77c1', 'ALIMENTO', CURRENT_TIMESTAMP),
('02822923-c429-4c5d-a0c2-66e05902370e', 'LIMPEZA', CURRENT_TIMESTAMP),
('49be0863-3b40-493a-9dcc-cff90b8917ca', 'HIGIENE', CURRENT_TIMESTAMP),
('3fc606ae-c453-40ca-a7e6-32b524c57606', 'GERAL', CURRENT_TIMESTAMP);

INSERT INTO "units"
("id", "name", "abbreviation", "created_at")
VALUES 
('7bdc7e06-0402-4b31-a152-23be02f6de77', 'KILO', 'KG', CURRENT_TIMESTAMP),
('0bf6be47-4208-4d71-8c48-75d56c044e92', 'GRAMA', 'G', CURRENT_TIMESTAMP),
('08a3abed-f593-4831-9e85-c69428681c81', 'LITRO', 'L', CURRENT_TIMESTAMP),
('58695f6d-7785-4f3d-8648-05ebfcae6bb6', 'MILIGRAMA', 'ML', CURRENT_TIMESTAMP),
('36f71e31-f6ed-45b9-9943-2199edca9b03', 'CAIXA', 'CAIXA', CURRENT_TIMESTAMP),
('bf5d9a03-f917-45d7-b7f2-284c01473158', 'CARTELA', 'CARTELA', CURRENT_TIMESTAMP),
('a4cdb66a-7961-44df-86d9-8b2736f11c0c', 'PENCA', 'PENCA', CURRENT_TIMESTAMP),
('ffcf3cf0-fe77-483e-8d87-82cf1afe0d3d', 'UNIDADE', 'UNIDADE', CURRENT_TIMESTAMP);
